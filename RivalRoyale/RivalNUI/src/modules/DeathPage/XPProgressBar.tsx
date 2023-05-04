import React, { useState } from 'react';
import { RegisterCommand } from 'utils/CommandManager';

export const XPProgressBar: React.FC = () => {
  const [deathData, setDeathData] = useState<any>({});
  RegisterCommand('SET_DEATH_PAGE_XP', setDeathData);

  return (
    <div className='death-page-xp-bar'>
      <label className='death-page-level'>
        LEVEL <span>{deathData.level || 0}</span>
      </label>
      <div className='death-page-progress-bar'>
        <div style={{ width: `${(deathData.currentXp / deathData.nextLevelXp) * 100}%` }} />
      </div>
      <p>
        {deathData.currentXp || 0} / {deathData.nextLevelXp || 0}
      </p>

      <div className='death-page-gained'>
        <section>
          <label>VICTORY XP</label>
          <label>+{deathData.victoryXp || 0}</label>
        </section>
        <section>
          <label>ELIMINATION XP</label>
          <label>+{deathData.elimiationXp || 0}</label>
        </section>
        <section>
          <label>PLACEMENT XP</label>
          <label>+{deathData.placementXp || 0}</label>
        </section>
        <section>
          <label>LOOT XP</label>
          <label>+{deathData.lootXp || 0}</label>
        </section>
        <section className='total-xp'>
          <label>TOTAL MATCH XP</label>
          <label>
            <span>+{deathData.totalXp || 0}</span>
          </label>
        </section>
      </div>
    </div>
  );
};
