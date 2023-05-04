import create from 'zustand';
import { NotificationType } from 'utils/NotificationCenter';
import { PlaySound } from 'utils/SoundManager';

interface Notification {
  notifications: NotificationType[];
  pushNotification: (notification: NotificationType) => void;
  deleteNotification: (id: number) => void;
}

const NotificationStore = (set, get) => ({
  notifications: [],

  pushNotification: (n) => {
    const showingNotifications = get().notifications;
    const alreadyExists = showingNotifications.some(
      (p) => p.type === n.type && p.message === n.message
    );

    // If notification is unique then push it
    if (!alreadyExists) {
      PlaySound('swoosh');
      set((state) => ({ notifications: [...state.notifications, n] }));
    }
  },

  deleteNotification: (id) => {
    set((state) => ({ notifications: state.notifications.filter((n) => n.id !== id) }));
  },
});

export const useNotification = create<Notification>(NotificationStore);
