import React from 'react';
import { useSettings } from 'stores';
import { ResetIcon } from './ResetIcon';

export const ResetButton: React.FC = () => {
  const handleDisplay = useSettings((state) => state.setModalDisplay);

  return (
    <button className='save-button' onClick={() => handleDisplay(true)}>
      RESET <ResetIcon />
    </button>
  );
};
