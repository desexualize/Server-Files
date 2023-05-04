import React from 'react';
import { DownloadResource } from 'utils/Resource';
import { useInventory, useDrag } from 'stores';

const HotbarKey = DownloadResource('resources/photos/HotbarKey.png');

export const Hotbar: React.FC<any> = () => {
  const hotbarItems = useInventory((state) => state.hotbarItems);
  const handleMoveDown = useDrag((state) => state.handleMoveDown);

  return (
    <div className='inventory-hotbar'>
      {hotbarItems.map((item, index: number) => (
        <div className='inventory-item' key={index}>
          <div className='hotbar-num'>
            <img alt='' src={HotbarKey} />
            <label>{index + 1}</label>
          </div>
          <section
            className='inventory-temp-item'
            onMouseDown={(e) => handleMoveDown(e, item, 'hotbar')}
            data-index={index.toString()}
            data-type='hotbar'>
            {item.src && <img alt='' src={item.src} />}
            <span>{item.label}</span>
            {item.amount > 0 && <p>X{item.amount}</p>}
          </section>
        </div>
      ))}
    </div>
  );
};
