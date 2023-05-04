import React, { Fragment } from 'react';
import { useSettings } from 'stores';
import { AudioCard } from './AudioCard';
import { SaveButton } from '../SaveButton';
import { ResetButton } from '../ResetButton';

export const AudioPanel: React.FC = () => {
  const { Audio, applyVolume } = useSettings((state) => ({
    Audio: state.Audio,
    applyVolume: state.applyVolume,
  }));

  return (
    <div className='settings-container'>
      <label>AUDIO</label>
      <section className='settings-card-wrapper'>
        {Object.entries(Audio).map(([k, v]: any, idx: number) => (
          <Fragment key={idx}>
            <AudioCard label={k} value={v} />
          </Fragment>
        ))}
      </section>
      <div className='settings-btn-group'>
        <SaveButton onClick={applyVolume} />
        <ResetButton />
      </div>
    </div>
  );
};
