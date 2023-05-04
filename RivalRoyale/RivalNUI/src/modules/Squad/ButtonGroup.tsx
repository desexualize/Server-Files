import React from 'react';
import { useSelectedGame } from 'stores';
import { sendClientData } from 'utils/DataHandler';
import { useHistory } from 'react-router-dom';
import { DownloadResource } from 'utils/Resource';

const gameBanners = {
  SOLO: DownloadResource('resources/photos/SoloBanner.jpg'),
  DUOS: DownloadResource('resources/photos/DuosBanner.jpg'),
  TRIOS: DownloadResource('resources/photos/TriosBanner.jpg'),
};

export const ButtonGroup: React.FC = () => {
  const selectedGame = useSelectedGame((state) => state.selectedGame);
  const history = useHistory();

  return (
    <div className='squad-btn-group'>
      {selectedGame ? (
        <div
          id='game-mode-banner'
          style={{ backgroundImage: `url(${gameBanners[selectedGame]})` }}
          onClick={() => history.push('/GameMode')}></div>
      ) : (
        <div id='game-mode' onClick={() => history.push('/GameMode')}>
          <label>SELECT GAMEMODE</label>
        </div>
      )}
      <div id='ready' onClick={() => sendClientData('RIVAL::launchSquad', selectedGame)}>
        <label>LAUNCH</label>
      </div>
    </div>
  );
};
