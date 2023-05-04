import React from 'react';
import { sendClientData } from 'utils/DataHandler';

export const ReturnButton: React.FC = () => {
  return (
    <button className='winner-page-return-btn' onClick={() => sendClientData('RIVAL::leaveSquad')}>
      RETURN TO LOBBY
    </button>
  );
};
