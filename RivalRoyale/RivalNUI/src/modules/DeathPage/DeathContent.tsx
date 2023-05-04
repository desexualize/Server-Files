import React, { useState } from 'react';
import { RegisterCommand } from 'utils/CommandManager';
import { XPProgressBar } from './XPProgressBar';

export const DeathContent: React.FC = () => {
  const [deathData, setDeathData] = useState<any>({});
  RegisterCommand('SET_DEATH_CONTENT', setDeathData);

  return (
    <div className='death-page-container'>
      <div className='death-page-top'>
        <h1>ELIMINATED</h1>
        <p>
          BY <span>{deathData.killerName || 'Unknown'}</span>
        </p>
        <label>
          HEALTH <span>{deathData.killerHealth || 0} </span>
        </label>
        <label>
          ARMOUR <span>{deathData.killerArmour || 0} </span>
        </label>
      </div>
      <div className='death-page-stats'>
        <label>
          <span>{deathData.damageGiven || 0}</span> DAMAGE GIVEN
        </label>
        <label>
          <span>{deathData.xpEarnt || 0}</span> XP EARNED
        </label>
        <label>
          <span>{deathData.playersKilled || 0}</span> KILLS
        </label>
      </div>

      <XPProgressBar />
    </div>
  );
};
