import React from 'react';
import { useSideMenu, useSettings } from 'stores';
import { sendClientData } from 'utils/DataHandler';
import { Modal } from 'components';

export const ResetModal: React.FC = () => {
  const setDisplay = useSettings((state) => state.setModalDisplay);
  const setSideMenuState = useSideMenu((state) => state.setDisplay);

  const handleResetSettings = (): void => {
    setDisplay(false);
    setSideMenuState('settings', false);
    sendClientData('RIVAL::resetSettings');
  };

  return (
    <Modal className='settings-reset-modal' setDisplay={setDisplay}>
      <h1>RESET SETTINGS</h1>
      <span>YOU ARE ABOUT TO RESET ALL OF YOUR SETTINGS</span>
      <br />
      <br />
      <span>ARE YOU SURE?</span>

      <div className='modal-btn-group'>
        <button onClick={() => setDisplay(false)}>CANCEL</button>
        <button onClick={handleResetSettings}>CONFIRM</button>
      </div>
    </Modal>
  );
};
