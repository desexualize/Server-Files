import React from 'react';
import shallow from 'zustand/shallow';
import { Notification } from 'components';
import { useNotification } from 'stores';
import { RegisterCommand } from 'utils/CommandManager';
import { CSSTransition, TransitionGroup } from 'react-transition-group';

type notificationType = 'invite' | 'message' | 'warning';

export interface NotificationType {
  type: notificationType;
  message: string;
  id: number;
  callbackUrl: string;
}

const NotificationCenter: React.FC = React.memo((props) => {
  const { pushNotification, notifications } = useNotification(
    (state) => ({
      pushNotification: state.pushNotification,
      notifications: state.notifications,
    }),
    shallow
  );

  RegisterCommand('PUSH_NEW_NOTIFICATION', pushNotification);

  return (
    <div className='notification-root' style={{ zIndex: 100 }}>
      <TransitionGroup>
        {notifications.map((notificationData, index: number) => (
          <CSSTransition key={index.toString()} timeout={500}>
            <Notification
              key={index}
              id={notificationData.id}
              type={notificationData.type}
              message={notificationData.message}
              callbackUrl={notificationData.callbackUrl}
            />
          </CSSTransition>
        ))}
      </TransitionGroup>
    </div>
  );
});

export default NotificationCenter;
