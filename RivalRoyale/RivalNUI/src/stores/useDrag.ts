import create from 'zustand';

interface DragAndDrop {
  dragging: boolean;
  currentItem: any;
  capturedElement: any;
  startedPosition: any;
  relativeInventory: string;

  setDragging: (value: boolean) => void;
  setCurrentItem: <T>(item: T) => void;
  setCapturedElement: <T>(element: T) => void;
  setStartedPosition: (anchor: any) => void;

  handleDropZone: (pageX: number, pageY: number) => void;
  handleMoveDown: <T>(event: T, item: any, inventory: string) => void;
}

const DragStore = (set, get) => ({
  dragging: false,
  currentItem: null,
  capturedElement: null,
  startedPosition: null,
  relativeInventory: '',

  setDragging: (value) => set((state) => ({ dragging: value })),
  setCurrentItem: (item) => set((state) => ({ currentItem: item })),
  setCapturedElement: (element) => set((state) => ({ capturedElement: element })),
  setStartedPosition: (position) => set((state) => ({ startedPosition: position })),

  handleDropZone: (pageX, pageY) => {
    const targetElements: Element[] = document.elementsFromPoint(pageX, pageY);
    const hoveredElement = document.querySelector('.inventory-dropzone');
    const capturedElement = get().capturedElement;

    hoveredElement && hoveredElement.classList.remove('inventory-dropzone');
    targetElements.forEach((element) => {
      if (element.classList.contains('inventory-temp-item') && element !== capturedElement) {
        element.classList.add('inventory-dropzone');
      }
    });
  },

  handleMoveDown: (event, item, inventory) => {
    event.preventDefault();
    const state = get();
    state.setDragging(true);

    if (!state.capturedElement) {
      const rect = event.target.getBoundingClientRect();
      state.setCapturedElement(event.target);
      state.setStartedPosition({
        x: event.pageX - rect.left,
        y: event.pageY - rect.top,
        x1: rect.left,
        y1: rect.top,
      });

      state.setCurrentItem(item);
    }

    set((state) => ({ relativeInventory: inventory }));
  },
});

export const useDrag = create<DragAndDrop>(DragStore);
