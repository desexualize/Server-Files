/* eslint-disable react-hooks/exhaustive-deps */
import React, { useEffect, useCallback, useState } from 'react';
import { PrimaryInventory } from './PrimaryInventory';
import { useMountEffect } from 'utils/hooks';
import { fetchClientData, sendClientData } from 'utils/DataHandler';
import { useInventory, useDrag } from 'stores';
import { getInventoryIcon } from 'utils/InventoryIcon';
import { SecondaryInventory } from './SecondaryInventory';
import { RegisterCommand } from 'utils/CommandManager';
import shallow from 'zustand/shallow';
import './Inventory.scss';

const Inventory: React.FC = () => {
  const [primaryInv, setPrimaryInv] = useState<boolean>(true);
  RegisterCommand('SET_PRIMARY_INV', setPrimaryInv);

  const {
    dragging,
    startedPosition,
    capturedElement,
    currentItem,
    relativeInventory,
    handleDropZone,
    setStartedPosition,
    setDragging,
    setCapturedElement,
  } = useDrag();

  const {
    primaryItems,
    hotbarItems,
    secondaryItems,
    setPrimaryItems,
    setHotbarItems,
    setSecondaryItems,
  } = useInventory(
    (state) => ({
      primaryItems: state.primaryItems,
      hotbarItems: state.hotbarItems,
      secondaryItems: state.secondaryItems,
      setPrimaryItems: state.setPrimaryItems,
      setHotbarItems: state.setHotbarItems,
      setSecondaryItems: state.setSecondaryItems,
    }),
    shallow
  );

  const moveToInventory = (inventory, targetIdx) => {
    const items =
      inventory === 'primary'
        ? primaryItems
        : inventory === 'secondary'
        ? secondaryItems
        : hotbarItems;

    let currentIdx = items.indexOf(currentItem);
    console.log(inventory, relativeInventory);

    switch (inventory) {
      case 'primary': {
        if (currentIdx === -1) {
          if (relativeInventory === 'secondary') {
            currentIdx = secondaryItems.indexOf(currentItem);

            secondaryItems[currentIdx] = items[targetIdx];
            items[targetIdx] = currentItem;
          } else {
            currentIdx = hotbarItems.indexOf(currentItem);

            hotbarItems[currentIdx] = items[targetIdx];
            items[targetIdx] = currentItem;
          }
        } else {
          items[currentIdx] = items[targetIdx];
          items[targetIdx] = currentItem;
        }

        setPrimaryItems(items);
        break;
      }
      case 'secondary': {
        if (currentIdx === -1) {
          if (relativeInventory === 'primary') {
            currentIdx = primaryItems.indexOf(currentItem);
            primaryItems[currentIdx] = items[targetIdx];
            items[targetIdx] = currentItem;
          } else {
            currentIdx = hotbarItems.indexOf(currentItem);
            hotbarItems[currentIdx] = items[targetIdx];
            items[targetIdx] = currentItem;
          }
        } else {
          items[currentIdx] = items[targetIdx];
          items[targetIdx] = currentItem;
        }

        setSecondaryItems(items);
        break;
      }

      case 'hotbar': {
        if (currentIdx === -1) {
          if (relativeInventory === 'primary') {
            currentIdx = primaryItems.indexOf(currentItem);
            primaryItems[currentIdx] = items[targetIdx];
            items[targetIdx] = currentItem;
          } else {
            currentIdx = secondaryItems.indexOf(currentItem);
            secondaryItems[currentIdx] = items[targetIdx];
            items[targetIdx] = currentItem;
          }
        } else {
          items[currentIdx] = items[targetIdx];
          items[targetIdx] = currentItem;
        }

        setHotbarItems(items);
        break;
      }
    }

    if (capturedElement) {
      capturedElement.style.background = 'none';
      capturedElement.style.left = `${startedPosition.x1}px`;
      capturedElement.style.top = `${startedPosition.y1}px`;
    }

    setDragging(false);
    const hoveredElement = document.querySelector('.inventory-dropzone');
    hoveredElement && hoveredElement.classList.remove('inventory-dropzone');
  };

  const handleMoveMouse = (event: MouseEvent) => {
    dragging && handleDropZone(event.pageX, event.pageY);

    if (capturedElement && dragging) {
      capturedElement.style.background = 'rgba(0, 0, 0, 0.5)';
      capturedElement.style.left = `${event.pageX - startedPosition.x}px`;
      capturedElement.style.top = `${event.pageY - startedPosition.y}px`;
    } else if (capturedElement) {
      capturedElement.style.background = 'none';
      capturedElement.style.left = `${startedPosition.x1}px`;
      capturedElement.style.top = `${startedPosition.y1}px`;

      setCapturedElement(null);
      setStartedPosition(null);
    }
  };

  const handleMoveUp = useCallback(
    ({ pageX, pageY }) => {
      const targetElements: Element[] = document.elementsFromPoint(pageX, pageY);

      for (const element of targetElements) {
        const inventoryType = element.getAttribute('data-type');

        if (element.tagName === 'BUTTON') {
          sendClientData('RIVAL::useInventoryAction', {
            action: element.innerHTML,
            inventory: relativeInventory,
            item: currentItem,
          });

          handleItemsFetch();
        }

        if (inventoryType && element.classList.contains('inventory-dropzone')) {
          const targetIdx = element.getAttribute('data-index');

          moveToInventory(inventoryType, targetIdx);
        }
      }

      setDragging(false);
    },
    [currentItem, moveToInventory, setDragging]
  );

  useEffect(() => {
    window.addEventListener('mousemove', handleMoveMouse);
    window.addEventListener('mouseup', handleMoveUp);

    return () => {
      window.removeEventListener('mousemove', handleMoveMouse);
      window.removeEventListener('mouseup', handleMoveUp);
    };
  }, [handleMoveMouse, handleMoveUp]);

  const handleItemsFetch = () => {
    fetchClientData('RIVAL::fetchInventoryItems', 'primary').then((items) => {
      items.forEach((item) => {
        item.src = getInventoryIcon(item.label, item.type);
      });

      setPrimaryItems(items);
    });

    fetchClientData('RIVAL::fetchInventoryItems', 'hotbar').then((items) => {
      items.forEach((item) => {
        item.src = getInventoryIcon(item.label, item.type);
      });

      setHotbarItems(items);
    });

    fetchClientData('RIVAL::fetchInventoryItems', 'secondary').then((items) => {
      items.forEach((item) => {
        item.src = getInventoryIcon(item.label, item.type);
      });

      setSecondaryItems(items);
    });
  };

  useMountEffect(() => {
    handleItemsFetch();
  });

  RegisterCommand('FETCH_INV_ITEMS', handleItemsFetch);

  return (
    <div className='inventory'>
      {primaryInv ? (
        <div className='primary-inventory-container'>
          <PrimaryInventory />
        </div>
      ) : (
        <SecondaryInventory />
      )}
    </div>
  );
};

export default Inventory;
