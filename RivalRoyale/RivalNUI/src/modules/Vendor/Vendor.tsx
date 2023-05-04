import React, { Fragment, useState, useEffect } from 'react';
import { DefaultLayout } from 'layouts';
import { PageComponent } from 'types';
import { ShoppingCart } from './ShoppingCart';
import { WeaponsRow } from './WeaponsRow';
import { AmmoRow } from './AmmoRow';
import { ConsumablesRow } from './ConsumablesRow';
import { fetchClientData, sendClientData } from 'utils/DataHandler';
import { useKeyPress } from 'utils/hooks';
import { useVendorStore } from 'stores';
import { Overlay } from 'components';
import './Vendor.scss';
import { RegisterCommand } from 'utils/CommandManager';

const Vendor: PageComponent<{}> = () => {
  const [cash, setCash] = useState<number>(0);
  const clearCart = useVendorStore((state) => state.clearCart);

  RegisterCommand('CLEAR_VENDOR_CART', clearCart);

  useKeyPress('Escape', () => sendClientData('RIVAL::exitVendor'));
  useEffect(() => {
    fetchClientData('RIVAL::fetchCash').then(setCash);
  }, []);

  return (
    <Fragment>
      <Overlay />
      <DefaultLayout className='vendor-container'>
        <ConsumablesRow />
        <WeaponsRow />
        <AmmoRow />
      </DefaultLayout>
      <ShoppingCart cash={cash} />
    </Fragment>
  );
};

export default Vendor;
