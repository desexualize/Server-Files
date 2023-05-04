import React from 'react';
import { useSettings } from 'stores';
import { CardProps } from '../SettingsTypes';

export const AudioCard: React.FC<CardProps> = ({ value, label }) => {
  const setVolumeOverride = useSettings((state) => state.setVolumeOverride);

  const handleChange = (e: any): void => {
    const result: number = parseInt(e.target.value);
    setVolumeOverride(label, result);
  };

  return (
    <div className='settings-card settings-slider'>
      <section>
        <label>{label}</label>
        <label>{value}</label>
      </section>
      <input
        type='range'
        value={typeof value === 'number' ? value : 1}
        min={1}
        max={10}
        onChange={handleChange}
      />
    </div>
  );
};
