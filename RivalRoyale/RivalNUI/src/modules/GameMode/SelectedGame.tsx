import React, { useEffect, useState } from 'react';
import { useHistory } from 'react-router-dom';
import { useSelectedGame } from 'stores';
import { fetchClientData, sendClientData } from 'utils/DataHandler';
import { DownloadResource } from 'utils/Resource';

const MapPreview = DownloadResource('resources/photos/MapPreview.jpg');

interface SelectedGameProps {
  selectedGame: string;
}

export const SelectedGame: React.FC<SelectedGameProps> = ({ selectedGame }) => {
  const [playerCount, setPlayerCount] = useState<number>(0);
  const changeGame = useSelectedGame((state) => state.changeGame);
  const history = useHistory();

  const handleChange = () => {
    changeGame(selectedGame);
    sendClientData('RIVAL::requestSquadPlayers');
    history.push('/');
  };

  useEffect(() => {
    fetchClientData('RIVAL::getPlayerCount', selectedGame).then(setPlayerCount);
  }, [selectedGame]);

  return (
    <div className='game-mode-selected'>
      <h1 className='game-mode-title'>{selectedGame}</h1>
      <img alt='' className='game-mode-preview' src={MapPreview} />
      <section className='game-mode-description'>
        Lorem ipsum dolor sit amet, Adipiscing elit. Donec viverra, Integer et purus nisl. Lorem
        ipsum dolor sit amet, consectetur Adipiscing elit. Donec viverra.
      </section>
      <label className='game-mode-player-counter'>
        <span>{playerCount}</span> PLAYERS ARE PLAYING {selectedGame}
      </label>
      <button onClick={handleChange}>SELECT</button>
    </div>
  );
};
