import React from 'react';
import shallow from 'zustand/shallow';
import { DownloadResource } from 'utils/Resource';
import { useInventory } from 'stores';
import { useMountEffect } from 'utils/hooks';
import { getInventoryIcon } from 'utils/InventoryIcon';
import { RegisterCommand } from 'utils/CommandManager';

const HotbarKey = DownloadResource('resources/photos/HotbarKey.png');

export const Hotbar: React.FC<any> = () => {
  const { hotbarItems, setHotbarItems } = useInventory(
    (state) => ({
      hotbarItems: state.hotbarItems,
      setHotbarItems: state.setHotbarItems,
    }),
    shallow
  );

  useMountEffect(() => {
    const handleItems = (items) => {
      items.forEach((item) => {
        item.src = getInventoryIcon(item.label, item.type);
      });

      setHotbarItems(items);
    };

    RegisterCommand('FORCE_FETCH_HOTBAR', handleItems);
  });

  return (
    <div className='inventory-hotbar'>
      {hotbarItems.map((item, index: number) => (
        <div className='inventory-item' key={index}>
          <div className='hotbar-num'>
            <img alt='' src={HotbarKey} />
            <label>{index + 1}</label>
          </div>
          <section className='inventory-temp-item' data-index={index.toString()} data-type='hotbar'>
            {item.src && <img alt='' src={item.src} />}
            <span>{item.label}</span>
            {item.amount > 0 && <p>X{item.amount}</p>}
          </section>
        </div>
      ))}
    </div>
  );
};
