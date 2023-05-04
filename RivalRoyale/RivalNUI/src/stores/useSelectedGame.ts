import create from 'zustand';

interface GameMode {
  selectedGame: string | null;
  changeGame: (string) => void;
}

const SelectedGame = (set, get) => ({
  selectedGame: null,

  changeGame: (mode) => {
    set((state) => ({ selectedGame: mode }));
  },
});

export const useSelectedGame = create<GameMode>(SelectedGame);
