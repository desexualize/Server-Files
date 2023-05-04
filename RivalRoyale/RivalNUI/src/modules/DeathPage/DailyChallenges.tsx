import React from 'react';

export const DailyChallenges: React.FC = () => {
  return (
    <div className='info-bar-xp-challenges death-page-challenges'>
      <div className='challenge-wrapper'>
        <label>DAILY CHALLENGE 1</label>
        <section className='challenge-section'>
          <div className='challenge-progress-bar'>
            <div style={{ width: '0%' }} />
          </div>
          <label>0 / 0</label>
        </section>
        <label>0 XP</label>
      </div>
      <div className='challenge-wrapper'>
        <label>DAILY CHALLENGE 2</label>
        <section className='challenge-section'>
          <div className='challenge-progress-bar'>
            <div style={{ width: '0%' }} />
          </div>
          <label>0 / 0</label>
        </section>
        <label>0 XP</label>
      </div>
      <div className='challenge-wrapper'>
        <label>DAILY CHALLENGE 3</label>
        <section className='challenge-section'>
          <div className='challenge-progress-bar'>
            <div style={{ width: '0%' }} />
          </div>
          <label>0 / 0</label>
        </section>
        <label>0 XP</label>
      </div>
    </div>
  );
};
