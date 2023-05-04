// export interface Item {
// label: string;
// icon: string;
// }

export type Item = any;

export interface PrimaryInventoryProps {
  items: Item[];
  hotbarItems: Item[];
  setItems: (any) => void;
  setHotbarItems: (any) => void;
  handleMoveDown?: any;
  setCurrentItem?: any;
  currentItem?: any;
}
