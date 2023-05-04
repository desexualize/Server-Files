import React, { useState } from 'react';
import { RegisterCommand } from 'utils/CommandManager';

export const XPProgressBar: React.FC = () => {
  const [winnerData, setWinnerData] = useState<any>({});
  RegisterCommand('SET_WINNER_DATA', setWinnerData);

  return (
    <div className='winner-page-xp-bar'>
      <label className='winner-page-level'>
        LEVEL <span>{winnerData.level || 0}</span>
      </label>
      <div className='winner-page-progress-bar'>
        <div style={{ width: `${(winnerData.currentXp / winnerData.nextLevelXp) * 100}%` }} />
      </div>
      <p>
        {winnerData.currentXp || 0} / {winnerData.nextLevelXp || 0}
      </p>

      <div className='winner-page-gained'>
        <section>
          <label>VICTORY XP</label>
          <label>+{winnerData.victoryXp || 0}</label>
        </section>
        <section>
          <label>ELIMINATION XP</label>
          <label>+{winnerData.elimiationXp || 0}</label>
        </section>
        <section>
          <label>PLACEMENT XP</label>
          <label>+{winnerData.placementXp || 0}</label>
        </section>
        <section>
          <label>LOOT XP</label>
          <label>+{winnerData.lootXp || 0}</label>
        </section>
        <section className='total-xp'>
          <label>TOTAL MATCH XP</label>
          <label>
            <span>+{winnerData.totalXp || 0}</span>
          </label>
        </section>
      </div>
    </div>
  );
};
