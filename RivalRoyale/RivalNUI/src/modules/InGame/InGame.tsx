import React, { useState } from 'react';
import { KillfeedCenter } from 'utils/KillfeedCenter';
import { DefaultLayout } from 'layouts';
import { SquadPlayers } from './SquadPlayers';
import { WeaponHolder } from './WeaponHolder';
import { Compass } from './Compass';
import { RegisterCommand } from 'utils/CommandManager';
import { WaitingStage } from './WaitingStage';
import { Hotbar } from './Hotbar';
import { Watermark } from './Watermark';
import { GameInfo } from './GameInfo';
import './InGame.scss';
import '../Inventory/Inventory.scss';

const InGame: React.FC = () => {
  const [waitingStage, setWaitingStage] = useState<boolean>(false);
  RegisterCommand('WAITING_STAGE', setWaitingStage);

  return (
    <DefaultLayout className='game-wrapper'>
      <KillfeedCenter />
      <SquadPlayers />
      <WeaponHolder />
      <Hotbar />
      <Watermark />
      <GameInfo />
      {waitingStage ? <WaitingStage /> : <Compass />}
    </DefaultLayout>
  );
};

export default InGame;
