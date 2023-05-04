import React from 'react';
import { useSettings } from 'stores';
import { CardProps } from '../SettingsTypes';

export const SettingsToggleCard: React.FC<CardProps> = (props) => {
  const { value, label } = props;
  const toggleValue = useSettings((state) => state.toggleValue);

  return (
    <div className='settings-card settings-toggle-card'>
      <label>{label}</label>
      <div
        className={`settings-toggler ${value ? 'on' : 'off'}`}
        onClick={() => toggleValue(label)}>
        {value ? 'ON' : 'OFF'}
      </div>
    </div>
  );
};
