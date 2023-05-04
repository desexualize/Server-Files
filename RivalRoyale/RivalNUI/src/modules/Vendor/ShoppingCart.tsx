import React from 'react';
import { DownloadResource } from 'utils/Resource';
import { useVendorStore } from 'stores';
import { sendClientData } from 'utils/DataHandler';
import shallow from 'zustand/shallow';

const DeleteIcon = DownloadResource('resources/photos/DeleteIcon.png');

export const ShoppingCart: React.FC<{ cash: number }> = ({ cash }) => {
  const { cart, removeItemFromCart } = useVendorStore(
    (state) => ({
      cart: state.cart,
      removeItemFromCart: state.removeItemFromCart,
    }),
    shallow
  );

  const calculateTotal = (): number => {
    let total = 0;
    cart.forEach((item) => {
      total += item.price * item.amount;
    });

    return total;
  };

  const formatPrice = (num: number): string => {
    return new Intl.NumberFormat('en-US', {}).format(num).replace(/,/g, '.');
  };

  const cartTotal: number = calculateTotal();
  const canAffordPurchase = cash >= cartTotal;

  return (
    <div className='vendor-shopping-cart'>
      <div className='vendor-shopping-cart-wrapper'>
        <h1 className='vendor-shopping-cart-title'>CART</h1>
        <section className='vendor-shopping-items'>
          {cart.map(({ label, amount, price }, index: number) => (
            <div className='vendor-shopping-item' key={index}>
              {amount === 1 ? (
                <label>{label}</label>
              ) : (
                <label>
                  {label} X {amount}
                </label>
              )}
              <div>
                <span>${formatPrice(price * amount)}</span>
                <img alt='' src={DeleteIcon} onClick={() => removeItemFromCart(label)} />
              </div>
            </div>
          ))}
        </section>
        <div className='vendor-shopping-checkout'>
          <div>
            <label>TOTAL</label>
            <span>${formatPrice(cartTotal)}</span>
          </div>
          <button
            style={{ cursor: canAffordPurchase ? 'pointer' : 'not-allowed' }}
            onClick={() => canAffordPurchase && sendClientData('RIVAL::tryPurchase', cart)}>
            CONFIRM PURHCASE
          </button>
        </div>
      </div>
    </div>
  );
};
