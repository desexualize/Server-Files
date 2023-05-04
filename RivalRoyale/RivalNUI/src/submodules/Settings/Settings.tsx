import React, { useRef } from 'react';
import shallow from 'zustand/shallow';
import { useOutsideClick, useMountEffect } from 'utils/hooks';
import { fetchClientData } from 'utils/DataHandler';
import { useSideMenu, useSettings } from 'stores';
import { GamePlayPanel } from './GamePlay/GamePlayPanel';
import { KeyBindPanel } from './KeyBinds/KeyBindPanel';
import { AudioPanel } from './Audio/AudioPanel';
import { ResetModal } from './ResetModal';
import { DownloadResource } from 'utils/Resource';

import './Settings.scss';

const SettingsIcon = DownloadResource('resources/photos/SettingsIcon.png');

export const Settings: React.FC = () => {
  const settingsRef = useRef<HTMLDivElement>(null);
  const sideMenu = useSideMenu();
  const { forceNewSettings, resetModal, section, setSection } = useSettings(
    (state) => ({
      forceNewSettings: state.forceNewSettings,
      resetModal: state.resetModal,
      section: state.section,
      setSection: state.setSection,
    }),
    shallow
  );

  useOutsideClick(settingsRef, () => {
    settingsRef?.current?.classList.add('slideRight');
    setTimeout(() => sideMenu.setDisplay('settings', false), 350);
  });

  useMountEffect(() => {
    fetchClientData('RIVAL::fetchSettings').then(forceNewSettings);
  });

  return (
    <div className='side-menu-container' ref={settingsRef}>
      <div className='settings-banner'>
        <img alt='' src={SettingsIcon} />
        <h1>SETTINGS</h1>
      </div>
      <div className='settings-sections'>
        <section
          className={section === 'GAMEPLAY' ? 'active-section' : ''}
          onClick={() => setSection('GAMEPLAY')}>
          GAMEPLAY
        </section>
        <section
          className={section === 'AUDIO' ? 'active-section' : ''}
          onClick={() => setSection('AUDIO')}>
          AUDIO
        </section>
        <section
          className={section === 'KEYBINDS' ? 'active-section' : ''}
          onClick={() => setSection('KEYBINDS')}>
          KEYBINDS
        </section>
      </div>

      {/* Conditional renders */}
      {section === 'GAMEPLAY' && <GamePlayPanel />}
      {section === 'KEYBINDS' && <KeyBindPanel />}
      {section === 'AUDIO' && <AudioPanel />}
      {resetModal && <ResetModal />}
    </div>
  );
};
