import React from 'react';
import { ItemProps } from './ItemProps';
import { useVendorStore } from 'stores';

export const ItemCard: React.FC<ItemProps> = ({ label, src, price }) => {
  const addItemToCart = useVendorStore((state) => state.addItemToCart);

  return (
    <div className='vendor-item-card'>
      <label>{label}</label>
      <img src={src} alt='' draggable='false' />
      <span>${price}</span>
      <button onClick={() => addItemToCart(label)}>BUY</button>
    </div>
  );
};
