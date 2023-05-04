import React, { useRef, useState } from 'react';
import { ButtonGroup } from './ButtonGroup';
import { Hotbar } from './Hotbar';
import { useInventory, useDrag } from 'stores';
import { sendClientData } from 'utils/DataHandler';
import { useOutsideClick } from 'utils/hooks';

export const PrimaryInventory: React.FC = () => {
  const [sellingItems, setSellingItems] = useState<any[]>([]);
  const primaryItems = useInventory((state) => state.primaryItems);
  const handleMoveDown = useDrag((state) => state.handleMoveDown);

  const inventoryRef = useRef<HTMLDivElement>(null);
  useOutsideClick(inventoryRef, () => sendClientData('RIVAL::closeInventory'));

  const handleSell = (label) => {
    const alreadySelling = sellingItems.some((item) => item === label);

    if (alreadySelling) {
      setSellingItems((p) => p.filter((item) => item !== label));
    } else {
      setSellingItems((p) => [...p, label]);
    }
  };

  return (
    <div className='primary-inventory' ref={inventoryRef}>
      <ButtonGroup onSell={() => sendClientData('RIVAL::sellItems', sellingItems)} />
      <label>RIVAL WARFARE INVENTORY</label>
      <div className='inventory-grid'>
        {primaryItems.map((item, index: number) => (
          <div
            className={
              sellingItems.some((_item) => item.type !== 'empty' && _item === item.label)
                ? 'inventory-item inventory-selling'
                : 'inventory-item '
            }
            key={index}
            onClick={() => handleSell(item.label)}>
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
      <Hotbar />
    </div>
  );
};
