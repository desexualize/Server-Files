import React, { Fragment, Suspense, useState } from 'react';
import { render } from 'react-dom';
import { HashRouter, Switch, Route, useHistory } from 'react-router-dom';
import { RegisterCommand, CMDHandler } from 'utils/CommandManager';
import { TextModal } from 'components';
import { useMountEffectFixed } from 'utils/hooks';
import { sendClientData } from 'utils/DataHandler';

import './styles/index.scss';
import './components/styles/index.scss';

// Random Modules
const RecordingHandler = React.lazy(() => import('utils/RecordingHandler'));
const NotificationCenter = React.lazy(() => import('utils/NotificationCenter'));

// Modules
const DeathPage = React.lazy(() => import('modules/DeathPage/DeathPage'));
const DiscordWidget = React.lazy(() => import('modules/DiscordWidget/DiscordWidget'));
const GameMode = React.lazy(() => import('modules/GameMode/GameMode'));
const InGame = React.lazy(() => import('modules/InGame/InGame'));
const Locker = React.lazy(() => import('modules/Locker/Locker'));
const Squad = React.lazy(() => import('modules/Squad/Squad'));
const Vendor = React.lazy(() => import('modules/Vendor/Vendor'));
const Winner = React.lazy(() => import('modules/WinnerPage/WinnerPage'));

const ExtraModules: React.FC<any> = React.memo(() => {
  const [secondaryModules, setSecondaryModules] = useState<any>([]);

  // A command which handles the state of secondaryModules
  RegisterCommand('HANDLE_MODULE', (data) => {
    const { label, display } = data;

    if (!display) {
      return setSecondaryModules(
        secondaryModules.map((module) =>
          module.label === label ? { ...module, display: false } : module
        )
      );
    }

    const ImportedModule = React.lazy(() => import(`modules/${label}/${label}`));
    setSecondaryModules((previousState) => [
      ...previousState,
      { module: ImportedModule, label: label, display: true },
    ]);
  });

  // All extra modules gets rendered here
  return (
    <Suspense fallback={<Fragment />}>
      {secondaryModules.map(
        ({ module: CapitalizedModule, display }, index: number) => display && <CapitalizedModule />
      )}
    </Suspense>
  );
});

const Render: React.FC = React.memo(() => {
  const history = useHistory();
  const [modalDisplay, setModalDisplay] = useState<boolean>(false);
  const [modalReason, setModalReason] = useState<string>('No title.');

  // Initializes all the command handler
  // useNuiEvent<unknown>('RivalNUI', 'SEND_REGISTERED_COMMAND', CMDHandler);
  RegisterCommand('REDIRECT_TO_URL', history.push);
  useMountEffectFixed(() => {
    window.addEventListener('message', (message: MessageEvent<any>): void => {
      const { command, data } = message.data;
      CMDHandler(command, data);
    });
  });

  // Registers command to handle the text modal
  RegisterCommand('HANDLE_TEXT_MODAL', ({ reason, display }) => {
    setModalDisplay(display || false);
    setModalReason(reason);
  });

  RegisterCommand('REQUEST_CLOTHING', () => {
    const prefix = 'rw-clothing-';
    const tempClothing: any[] = [];

    for (const item in localStorage) {
      if (item.startsWith(prefix)) {
        const parsedItem = JSON.parse(localStorage[item]);
        tempClothing.push({
          component: item.replace(prefix, ''),
          componentId: parsedItem.componentId,
          textureId: parsedItem.textureId,
        });
      }
    }

    sendClientData('RIVAL::baseClothing', tempClothing);
  });

  // Renders a bunch of stuff together
  return (
    <Fragment>
      <ExtraModules />
      {modalDisplay && <TextModal reason={modalReason} setDisplay={setModalDisplay} />}
      <Suspense fallback={<Fragment>Loading...</Fragment>}>
        <RecordingHandler />
        <NotificationCenter />
      </Suspense>
    </Fragment>
  );
});

render(
  <React.StrictMode>
    <HashRouter>
      <Render />
      <Suspense fallback={<Fragment>Loading...</Fragment>}>
        <Switch>
          {/* Routes and their endpoints */}
          <Route path='/' component={Squad} exact />
          <Route path='/DeathPage' component={DeathPage} />
          <Route path='/DiscordWidget' component={DiscordWidget} />
          <Route path='/GameMode' component={GameMode} />
          <Route path='/hidden' />
          <Route path='/InGame' component={InGame} />
          <Route path='/Locker' component={Locker} />
          <Route path='/Vendor' component={Vendor} />
          <Route path='/Winner' component={Winner} />
        </Switch>
      </Suspense>
    </HashRouter>
  </React.StrictMode>,
  document.getElementById('root') as HTMLElement
);
