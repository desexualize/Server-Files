import create from 'zustand';

interface SideMenu {
  friendList: boolean;
  settings: boolean;
  adminMenu: boolean;
  setDisplay: (key: string, value: boolean) => void;
}

const SideMenuStore = (set, get) => ({
  friendList: false,
  settings: false,
  adminMenu: false,

  setDisplay: (key, value) => {
    const currentState = <SideMenu>get();
    currentState[key] = value;

    set((state) => {
      currentState;
    });
  },
});

export const useSideMenu = create<SideMenu>(SideMenuStore);
