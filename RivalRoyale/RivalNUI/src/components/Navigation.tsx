import React from 'react';
import { useLocation, useHistory } from 'react-router-dom';
import { sendClientData } from 'utils/DataHandler';
import { PlaySound } from 'utils/SoundManager';

enum endPoints {
  LOCKER = '/Locker',
  GANGS = '/',
  PLAY = '/',
  STORAGE = '/',
  STORE = '/',
}

export const Navigation: React.FC = () => {
  const history = useHistory();
  const location = useLocation();

  const handleSwitch = (type: string): void => {
    history.push(endPoints[type]);
    PlaySound('click');

    if (type !== 'LOCKER') {
      sendClientData('RIVAL::exitLocker');
    }
  };

  return (
    <header className='navbar-container'>
      <section
        className={'navbar-item ' + (location.pathname === '/Locker' && 'active')}
        onClick={() => handleSwitch('LOCKER')}>
        <label>LOCKER</label>
      </section>
      <section className={'navbar-item disabled-nav'}>
        <label>GANGS</label>
      </section>
      <section
        className={'navbar-item ' + (location.pathname === '/' && 'active')}
        onClick={() => handleSwitch('PLAY')}>
        <label>PLAY</label>
      </section>
      <section className={'navbar-item disabled-nav'}>
        <label>STORAGE</label>
      </section>
      <section className={'navbar-item disabled-nav'}>
        <label>STORE</label>
      </section>
    </header>
  );
};
