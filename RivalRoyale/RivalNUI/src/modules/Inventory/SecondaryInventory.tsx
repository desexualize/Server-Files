import React, { useRef } from 'react';
import { useDrag, useInventory } from 'stores';
import { sendClientData } from 'utils/DataHandler';
import { useOutsideClick } from 'utils/hooks';
import { Hotbar } from './Hotbar';

export const SecondaryInventory = () => {
  const { primaryItems, secondaryItems } = useInventory((state) => ({
    primaryItems: state.primaryItems,
    secondaryItems: state.secondaryItems,
  }));

  const handleMoveDown = useDrag((state) => state.handleMoveDown);
  const inventoryRef = useRef<HTMLDivElement>(null);

  useOutsideClick(inventoryRef, () => sendClientData('RIVAL::exitCrate'));

  return (
    <div className='inventory'>
      <div className='secondary-inventory-container' ref={inventoryRef}>
        <div className='inventory-wrapper'>
          <div className='secondary-inventory'>
            <label className='inventory-text'>YOUR INVENTORY</label>
            <div className='inventory-grid'>
              {primaryItems.map((item, index: number) => (
                <div className='inventory-item' key={index}>
                  <section
                    className='inventory-temp-item'
                    // Make sure that item has content before drag
                    onMouseDown={(e) => item.label && handleMoveDown(e, item, 'primary')}
                    data-index={index.toString()}
                    data-type='primary'>
                    {item.src && <img alt='' src={item.src} />}
                    <span>{item.label}</span>
                    {item.amount > 0 && <p>X{item.amount}</p>}
                  </section>
                </div>
              ))}
            </div>
          </div>
          <div className='inventory-spacer' />
          <div className='secondary-inventory'>
            <label className='inventory-text'>SECOND INVENTORY</label>
            <div className='inventory-grid'>
              {secondaryItems.map((item, index: number) => (
                <div className='inventory-item' key={index}>
                  <section
                    className='inventory-temp-item'
                    // Make sure that item has content before drag
                    onMouseDown={(e) => item.label && handleMoveDown(e, item, 'secondary')}
                    data-index={index.toString()}
                    data-type='secondary'>
                    {item.src && <img alt='' src={item.src} />}
                    <span>{item.label}</span>
                    {item.amount > 0 && <p>X{item.amount}</p>}
                  </section>
                </div>
              ))}
            </div>
          </div>
        </div>

        <Hotbar />
      </div>
    </div>
  );
};
