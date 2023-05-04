import create from 'zustand';

interface Clothing {
  clothes: any;
  setClothes: <T>(value: T[]) => void;
}

const ClothingStore = (set, get) => ({
  clothes: [],
  setClothes: (clothes) => set((state) => ({ clothes: clothes })),
});

export const useClothing = create<Clothing>(ClothingStore);
