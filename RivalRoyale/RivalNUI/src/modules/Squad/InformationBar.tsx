import React, { useState, useEffect } from 'react';
import { useSquadData } from 'stores';
import { RegisterCommand } from 'utils/CommandManager';

export const InformationBar: React.FC = () => {
  const currentDate = new Date();
  const [dateString, setDateString] = useState<string>(
    `${23 - currentDate.getUTCHours()}H ${60 - currentDate.getUTCMinutes()}M`
  );
  const { level, minLevelXp, nextLevelXp, currentXp, dailyChallenges, setData } = useSquadData();

  useEffect(() => {
    setInterval(() => {
      const currentDate = new Date();
      setDateString(`${23 - currentDate.getUTCHours()}H ${60 - currentDate.getUTCMinutes()}M`);
    }, 60 * 1000); // Runs every min
  }, []);

  const handleCalc = (min: number, max: number, progress: number): number => {
    return ((progress - min) / (max - min)) * 100;
  };

  RegisterCommand('SET_SQUAD_INFO', setData);

  return (
    <div className='info-bar-container'>
      <div className='info-bar-xp-container'>
        <div>
          <label>LEVEL</label>
          <span>{level}</span>
        </div>
        <div className='info-bar-xp-progress'>
          <div
            style={{
              width: `${handleCalc(minLevelXp, nextLevelXp, currentXp)}%`,
            }}
          />
        </div>
        <span className='info-bar-xp-current'>
          {currentXp} / {nextLevelXp}
        </span>
      </div>
      <div className='info-bar-challenges-content'>
        <label>DAILY CHALLENGES</label>
        <span> {dateString}</span>
      </div>
      <div className='info-bar-xp-challenges'>
        {dailyChallenges.map((challenge) => (
          <div className='challenge-wrapper'>
            <label>{challenge.title}</label>
            <section className='challenge-section'>
              <div className='challenge-progress-bar'>
                <div style={{ width: `${(challenge.progress / challenge.maxProgress) * 100}%` }} />
              </div>
              <label>
                {challenge.progress} / {challenge.maxProgress}
              </label>
            </section>
            <label>{challenge.rewardAmount} XP</label>
          </div>
        ))}
      </div>
    </div>
  );
};
