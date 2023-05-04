import create from 'zustand';

interface SquadType {
  dailyChallenges: any[];
  minLevelXp: number;
  nextLevelXp: number;
  currentXp: number;
  level: number;

  setData: <T>(data: T) => void;
}

const SquadData = (set, get) => ({
  dailyChallenges: [],
  currentXp: 0,
  minLevelXp: 0,
  nextLevelXp: 0,
  level: 0,

  setData: (data) => {
    set((state) => ({
      dailyChallenges: data.dailyChallenges,
      currentXp: data.currentXp,
      minLevelXp: data.minLevelXp,
      nextLevelXp: data.nextLevelXp,
      level: data.level,
    }));
  },
});

export const useSquadData = create<SquadType>(SquadData);
