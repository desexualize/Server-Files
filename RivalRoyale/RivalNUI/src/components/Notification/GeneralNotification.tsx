import React from 'react';

interface NotificationProps {
  message: string;
}

export const GeneralNotification: React.FC<NotificationProps> = ({ message }) => {
  return (
    <div className={`notification notification-general`}>
      <div className='notification-content'>
        <h1 className='notification-title'>MESSAGE! </h1>
        <label className='notification-text'>{message}</label>
      </div>
    </div>
  );
};
