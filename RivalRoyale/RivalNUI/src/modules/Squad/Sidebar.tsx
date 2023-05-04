import React from 'react';
import shallow from 'zustand/shallow';
import { useMountEffectFixed } from 'utils/hooks';
import { fetchClientData, sendClientData } from 'utils/DataHandler';
import { useAdminAuth, useSideMenu } from 'stores';
import { DownloadResource } from 'utils/Resource';

const AdminIcon = DownloadResource('resources/photos/AdminIcon.png');
const FriendIcon = DownloadResource('resources/photos/FriendIcon.png');
const SettingsIcon = DownloadResource('resources/photos/SettingsIcon.png');

export const Sidebar: React.FC = () => {
  const { auth, setAuth } = useAdminAuth(
    (state) => ({ auth: state.auth, setAuth: state.setAuth }),
    shallow
  );

  const setSideMenuState = useSideMenu((state) => state.setDisplay);

  useMountEffectFixed(() => {
    fetchClientData('RIVAL::requestAccess').then((auth: boolean) => setAuth(auth));
  });

  return (
    <div className='side-navbar'>
      <div className='side-navbar-icons'>
        <section id='friend-list' onClick={() => setSideMenuState('friendList', true)}>
          <img alt='' src={FriendIcon} />
          <label>0</label>
        </section>
        {auth && (
          <section id='staff' onClick={() => setSideMenuState('adminMenu', true)}>
            <img alt='' src={AdminIcon} />
          </section>
        )}
        <section id='settings' onClick={() => setSideMenuState('settings', true)}>
          <img alt='' src={SettingsIcon} />
        </section>
      </div>
      <button onClick={() => sendClientData('RIVAL::leaveSquad')}>LEAVE SQUAD</button>
    </div>
  );
};
