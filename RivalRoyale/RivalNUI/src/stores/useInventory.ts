import create from 'zustand';
import { sendClientData } from 'utils/DataHandler';

// interface Item {
//   label: string;
//   icon: string;
// }

type Item = any;

interface Inventory {
  primaryItems: Item[];
  hotbarItems: Item[];
  secondaryItems: Item[];

  setPrimaryItems: (items: Item[]) => void;
  setHotbarItems: (items: Item[]) => void;
  setSecondaryItems: (items: Item[]) => void;
}

const InventoryStore = (set, get) => ({
  primaryItems: [],
  hotbarItems: [],
  secondaryItems: [],

  setPrimaryItems: (items) => {
    const currentState = get();

    set((state) => ({ primaryItems: items }));
    sendClientData('RIVAL::syncInventoryClient', [
      items,
      currentState.secondaryItems,
      currentState.hotbarItems,
    ]);
  },

  setHotbarItems: (items) => {
    const currentState = get();

    set((state) => ({ hotbarItems: items }));
    sendClientData('RIVAL::syncInventoryClient', [
      currentState.primaryItems,
      currentState.secondaryItems,
      items,
    ]);
  },

  setSecondaryItems: (items) => {
    const currentState = get();

    set((state) => ({ secondaryItems: items }));
    sendClientData('RIVAL::syncInventoryClient', [
      currentState.primaryItems,
      items,
      currentState.hotbarItems,
    ]);
  },
});

export const useInventory = create<Inventory>(InventoryStore);
