import React, { Fragment, useState, useEffect } from 'react';
import { AdminMenu, FriendList, Settings } from 'submodules';
import { ButtonGroup } from './ButtonGroup';
import { ChatComponent } from './ChatComponent';
import { InformationBar } from './InformationBar';
import { Navigation } from 'components';
import { Sidebar } from './Sidebar';
import { useSideMenu } from 'stores';
import { DefaultLayout } from 'layouts';
import { PageComponent } from 'types';
import shallow from 'zustand/shallow';
import './Squad.scss';

const Squad: PageComponent<{}> = () => {
  const [hideElements, setHideElements] = useState<boolean>(false);
  const { adminMenu, friendList, settings } = useSideMenu(
    (state) => ({
      adminMenu: state.adminMenu,
      friendList: state.friendList,
      settings: state.settings,
    }),
    shallow
  );

  useEffect(() => {
    if (adminMenu || friendList || settings) {
      return setHideElements(true);
    }

    setHideElements(false);
  }, [adminMenu, friendList, settings]);

  return (
    <Fragment>
      {!hideElements && <ChatComponent />}
      {!hideElements && <Sidebar />}
      {friendList && <FriendList />}
      {adminMenu && <AdminMenu />}
      {settings && <Settings />}
      <Navigation />

      <DefaultLayout className='squad-wrapper'>
        <InformationBar />
        <ButtonGroup />
      </DefaultLayout>
    </Fragment>
  );
};

export default Squad;
