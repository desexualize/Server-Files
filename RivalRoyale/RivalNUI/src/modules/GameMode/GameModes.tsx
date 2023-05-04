import React from 'react';
import { PageComponent } from 'types';
import { DownloadResource } from 'utils/Resource';

// Required resources for this module
const Solo = DownloadResource('resources/photos/Solo.jpg');
const Duos = DownloadResource('resources/photos/Duos.jpg');
const Trios = DownloadResource('resources/photos/Trios.jpg');
const LockIcon = DownloadResource('resources/photos/LockIcon.png');
const Deathmatch = DownloadResource('resources/photos/Deathmatch.jpg');

interface GameProps {
  selectedGame: string;
  setSelectedGame: (string) => void;
}

export const GameModes: PageComponent<GameProps> = ({ selectedGame, setSelectedGame }) => {
  return (
    <div className='game-mode-wrapper'>
      <div className='game-mode-primary-container'>
        <section
          className={`game-mode-card ${selectedGame === 'DUOS' && 'active'}`}
          onClick={() => setSelectedGame('DUOS')}>
          <img alt='' src={Duos} />
          <div>DUOS</div>
        </section>
        <section
          className={`game-mode-card ${selectedGame === 'SOLO' && 'active'}`}
          onClick={() => setSelectedGame('SOLO')}>
          <img alt='' src={Solo} />
          <div>SOLO</div>
        </section>
        <section
          className={`game-mode-card ${selectedGame === 'TRIOS' && 'active'}`}
          onClick={() => setSelectedGame('TRIOS')}>
          <img alt='' src={Trios} />
          <div>TRIOS</div>
        </section>
      </div>
      <div className='game-mode-secondary-container'>
        <section className='game-mode-card'>
          <img alt='' src={LockIcon} className='locked-icon' />
          <img alt='' src={Deathmatch} />
          <div>DEATHMATCH</div>
        </section>
        <section className='game-mode-card'>
          <img alt='' src={LockIcon} className='locked-icon' />
          <img alt='' src={Deathmatch} />
          <div>DEATHMATCH</div>
        </section>
        <section className='game-mode-card'>
          <img alt='' src={LockIcon} className='locked-icon' />
          <img alt='' src={Deathmatch} />
          <div>DEATHMATCH</div>
        </section>
      </div>
    </div>
  );
};
