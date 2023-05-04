import React from 'react';
import { useSideMenu } from 'stores';
import { SaveIcon } from './SaveIcon';

export const SaveButton: React.FC<any> = ({ onClick }) => {
  const setSideMenuState = useSideMenu((state) => state.setDisplay);

  const handleSave = (): void => {
    setSideMenuState('settings', false);
    onClick();
  };

  return (
    <button className='save-button' onClick={handleSave}>
      SAVE <SaveIcon />
    </button>
  );
};
