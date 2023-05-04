import React, { Fragment } from 'react';
import { useSettings } from 'stores';
import { SettingsToggleCard } from './SettingsToggleCard';
import { SettingsSlider } from './SettingsSlider';
import { SaveButton } from '../SaveButton';
import { ResetButton } from '../ResetButton';

export const GamePlayPanel: React.FC = () => {
  const { GamePlay, applySettings } = useSettings((state) => ({
    GamePlay: state.GamePlay,
    applySettings: state.applySettings,
  }));

  return (
    <div className='settings-container'>
      <label>GAMEPLAY</label>
      <section className='settings-card-wrapper'>
        {Object.entries(GamePlay).map(([k, v]: any, idx: number) => (
          <Fragment key={idx}>
            {v.type === 'toggle' && <SettingsToggleCard label={k} {...v} />}
            {v.type === 'slider' && <SettingsSlider label={k} {...v} />}
          </Fragment>
        ))}
      </section>
      <div className='settings-btn-group'>
        <SaveButton onClick={applySettings} />
        <ResetButton />
      </div>
    </div>
  );
};
