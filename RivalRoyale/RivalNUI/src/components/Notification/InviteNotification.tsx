import React from 'react';

interface NotificationProps {
  message: string;
  handleAccept: () => void;
  handleExit: () => void;
}

export const InviteNotification: React.FC<NotificationProps> = ({
  handleExit,
  handleAccept,
  message,
}) => {
  return (
    <div className={`notification notification-invite`}>
      <div className='notification-content'>
        <h1 className='notification-title'>MESSAGE!</h1>
        <label className='notification-text'>{message}</label>
      </div>
      <section className='notification-btn-group'>
        <button id='primary' onClick={handleAccept}>
          ACCEPT
        </button>
        <button id='secondary' onClick={handleExit}>
          REJECT
        </button>
      </section>
    </div>
  );
};
