import React, { useCallback, useEffect } from 'react';
import { sendClientData } from 'utils/DataHandler';
import { useNotification } from 'stores';
import { InviteNotification } from './InviteNotification';
import { WarningNotification } from './WarningNotification';
import { GeneralNotification } from './GeneralNotification';
import { NotificationType } from 'utils/NotificationCenter';

export const Notification: React.FC<NotificationType> = ({ id, message, type, callbackUrl }) => {
  const deleteNotification = useNotification((state) => state.deleteNotification);

  const handleDelete = useCallback((): void => deleteNotification(id), [deleteNotification, id]);
  const handleClick = (accepted: boolean): void => {
    handleDelete();
    sendClientData(callbackUrl, [accepted, id]);
  };

  const handleAccept = (): void => handleClick(true);
  const handleReject = (): void => handleClick(false);

  useEffect(() => {
    setTimeout(() => handleDelete(), type === 'invite' ? 30000 : 6500);
  }, [handleDelete, type]);

  switch (type) {
    case 'invite':
      return (
        <InviteNotification
          message={message}
          handleAccept={handleAccept}
          handleExit={handleReject}
        />
      );
    case 'warning':
      return <WarningNotification />;
    case 'message':
      return <GeneralNotification message={message} />;
    default:
      return null;
  }
};
