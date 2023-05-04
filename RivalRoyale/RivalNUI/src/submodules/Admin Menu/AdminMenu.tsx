import React, { useState, useEffect, useRef } from 'react';
import { useSideMenu } from 'stores';
import { useOutsideClick } from 'utils/hooks';
import { IncomingReports } from './IncomingReports';
import { PlayerList } from './PlayerList';
import { fetchClientData } from 'utils/DataHandler';
import { DownloadResource } from 'utils/Resource';

import './AdminMenu.scss';

const AdminIcon = DownloadResource('resources/photos/AdminIcon.png');

export const AdminMenu: React.FC = (props) => {
  const setDisplay = useSideMenu((state) => state.setDisplay);
  const [activeSection, setActiveSection] = useState<string>('player');
  const [numberOfPlayers, setNumberOfPlayers] = useState<number>(0);
  const adminMenuRef = useRef<HTMLDivElement>(null);

  useOutsideClick(adminMenuRef, () => {
    adminMenuRef?.current?.classList.add('slideRight');
    setTimeout(() => setDisplay('adminMenu', false), 350);
  });

  useEffect(() => {
    fetchClientData('RIVAL::getNumPlayers').then((num: number) => setNumberOfPlayers(num));
  }, []);

  return (
    <div className='side-menu-container' ref={adminMenuRef}>
      <div className='admin-banner'>
        <img alt='' src={AdminIcon} />
        <section>
          <span>{numberOfPlayers}</span>
          <label>ONLINE PLAYERS</label>
        </section>
      </div>
      <div className='side-menu-section'>
        <section
          className={activeSection === 'player' ? 'active' : ''}
          style={{ marginRight: '0.625em', marginLeft: '-1.5em' }}
          onClick={() => setActiveSection('player')}>
          <span style={{ marginLeft: '1.125em' }}>PLAYER SEARCH</span>
        </section>

        <section
          className={activeSection === 'reports' ? 'active' : ''}
          style={{ marginLeft: '0.625em', marginRight: '-1.5em' }}
          onClick={() => setActiveSection('reports')}>
          <span style={{ marginLeft: '0.625em' }}>INCOMING REPORTS</span>
        </section>
      </div>
      {activeSection === 'reports' ? <IncomingReports /> : <PlayerList />}
    </div>
  );
};
