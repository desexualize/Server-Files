import React, { Fragment } from 'react';
import { useSettings } from 'stores';
import { KeyCard } from './KeyCard';
import { SaveButton } from '../SaveButton';
import { ResetButton } from '../ResetButton';

export const KeyBindPanel: React.FC = () => {
  const { KeyBinds, applyKeyBinds } = useSettings((state) => ({
    KeyBinds: state.KeyBinds,
    applyKeyBinds: state.applyKeyBinds,
  }));

  return (
    <div className='settings-container'>
      <label>KEYBINDS</label>
      <section className='settings-card-wrapper'>
        {Object.entries(KeyBinds).map(([k, v]: any, idx: number) => (
          <Fragment key={idx}>
            <KeyCard label={k} value={v} />
          </Fragment>
        ))}
      </section>
      <div className='settings-btn-group'>
        <SaveButton onClick={applyKeyBinds} />
        <ResetButton />
      </div>
    </div>
  );
};
