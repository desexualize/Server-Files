import React, { useState } from 'react';
import { useSettings } from 'stores';
import { CardProps } from '../SettingsTypes';

export const SettingsSlider: React.FC<CardProps> = (props) => {
  const { value: inheritedValue, range, label } = props;
  const setSettingValue = useSettings((state) => state.setValue);
  const [value, setValue] = useState<number>(
    typeof inheritedValue === 'number' ? inheritedValue : 0
  );

  if (!range) {
    return null;
  }

  const handleSlide = (e: React.ChangeEvent<HTMLInputElement>): void => {
    const parsedResult = parseInt(e?.target?.value);

    setValue(parsedResult);
    setSettingValue(label, parsedResult);
  };

  return (
    <div className='settings-card settings-slider'>
      <section>
        <label>{label}</label>
        <label>{value}</label>
      </section>
      <input type='range' value={value} min={range.min} max={range.max} onChange={handleSlide} />
    </div>
  );
};
