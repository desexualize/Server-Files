import React, { useState } from 'react';
import { ReturnButton } from 'components';
import { GameModes } from './GameModes';
import { SelectedGame } from './SelectedGame';
import { DefaultLayout } from 'layouts';
import { useSelectedGame } from 'stores';

import './GameMode.scss';

const GameMode: React.FC = () => {
  const selectedGame = useSelectedGame((state) => state.selectedGame);
  const [previewedGame, setPreviewedGame] = useState<string>(selectedGame || 'SOLO');

  return (
    <DefaultLayout className='game-mode-container'>
      <ReturnButton />
      <GameModes selectedGame={previewedGame} setSelectedGame={setPreviewedGame} />
      <SelectedGame selectedGame={previewedGame} />
    </DefaultLayout>
  );
};

export default GameMode;
