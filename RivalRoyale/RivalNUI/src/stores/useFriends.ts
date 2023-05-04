import create from 'zustand';
import { sendClientData } from 'utils/DataHandler';

interface OnlinePlayer {
  [name: string]: number;
}

interface Friend {
  id: number | unknown;
  name: string;
  status: string;
}

interface FriendsType {
  Friends: Friend[];
  OnlinePlayers: OnlinePlayer[];

  clearFriends: () => void;
  addFriend: (friend: Friend) => void;
  removeFriend: (id: number) => void;

  setOnlinePlayers: (players: OnlinePlayer[]) => void;
}

const Friends = (set, get) => ({
  Friends: [],
  OnlinePlayers: [],

  clearFriends: () => {
    set((state) => ({ Friends: [] }));
  },

  addFriend: (friend) => {
    set((state) => ({ Friends: [...state.Friends, friend] }));
  },

  removeFriend: (id) => {
    set((state) => ({ Friends: state.Friends.filter((friend) => friend.id !== id) }));
    sendClientData('RIVAL::removeFriend', id);
  },

  setOnlinePlayers: (players) => {
    set((state) => ({ OnlinePlayers: players }));
  },
});

export const useFriends = create<FriendsType>(Friends);
