import React, { useState } from 'react';
import { Modal } from './Modal';

interface ModalProps {
  reason: string;
  setDisplay: (boolean) => void;
}

export const TextModal: React.FC<ModalProps> = ({ reason, setDisplay }) => {
  const [text, setText] = useState<string>('');

  const handleSubmit = (): void => {
    setDisplay(false);
    fetch('https://RivalNUI/RIVAL::handlePromptCb', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: JSON.stringify(text),
    });
  };

  const handleClose = (value: boolean): void => {
    setDisplay(value);
    fetch('https://RivalNUI/RIVAL::handlePromptCb', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: JSON.stringify('ERROR'),
    });
  };

  return (
    <Modal className='text-modal' setDisplay={handleClose} width='43.75em' height='31.25em'>
      <div className='text-modal-title'>
        <h1>
          <span>RIVAL</span> WARFARE
        </h1>
      </div>
      <label className='text-modal-subtitle'>TEXT-PROMPT</label>
      <label className='text-modal-description'>{reason}</label>
      <textarea placeholder='SAY...' value={text} onChange={(e) => setText(e.target.value)} />
      <div className='text-modal-btn-group'>
        <button id='cancel' onClick={() => handleClose(false)}>
          CANCEL
        </button>
        <button id='submit' onClick={handleSubmit}>
          SUBMIT
        </button>
      </div>
    </Modal>
  );
};
