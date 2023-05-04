import create from 'zustand';
import { fetchClientData } from 'utils/DataHandler';
import { PlaySound } from 'utils/SoundManager';

interface VendorStore {
  cart: any[];
  clearCart: () => void;
  addItemToCart: (item: string) => void;
  removeItemFromCart: (item: string) => void;
}

let vendorPrices = {};
fetchClientData('RIVAL::requestVendorPrices').then((fetchPrices) => (vendorPrices = fetchPrices));

const VendorStoreStore = (set, get) => ({
  cart: [],

  clearCart: () => {
    set((state) => ({ cart: [] }));
  },

  addItemToCart: (label) => {
    PlaySound('click');

    const currentCart = get().cart;
    const foundItem = currentCart.find((item) => item.label === label);
    const itemAmount = foundItem ? foundItem.amount + 1 : 1;
    const constructedItem = { label: label, price: vendorPrices[label], amount: itemAmount };

    if (foundItem) {
      return set((state) => ({
        cart: state.cart.map((item) => (item.label === label ? constructedItem : item)),
      }));
    }

    set((state) => ({ cart: [...state.cart, constructedItem] }));
  },

  removeItemFromCart: (label) => {
    set((state) => ({ cart: state.cart.filter((_item) => _item.label !== label) }));
  },
});

export const useVendorStore = create<VendorStore>(VendorStoreStore);
