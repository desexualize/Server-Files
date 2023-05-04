import React, { Fragment } from 'react';
import { EmptyItemCard } from './EmptyItemCard';
import { VendorTag } from './VendorTag';

export const ConsumablesRow = () => {
  return (
    <Fragment>
      <VendorTag label='CONSUMABLES' />
      <div className='vendor-row-wrapper'>
        <EmptyItemCard />
        <EmptyItemCard />
        <EmptyItemCard />
        <EmptyItemCard />
        <EmptyItemCard />
        <EmptyItemCard />
        <EmptyItemCard />
      </div>
    </Fragment>
  );
};
