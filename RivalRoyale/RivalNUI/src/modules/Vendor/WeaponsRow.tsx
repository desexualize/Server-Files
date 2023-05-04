import React, { Fragment } from 'react';
import { VendorTag } from './VendorTag';
import { EmptyItemCard } from './EmptyItemCard';

export const WeaponsRow = () => {
  return (
    <Fragment>
      <VendorTag label='WEAPONS' />
      <div className='vendor-row-wrapper'>
        <EmptyItemCard />
        <EmptyItemCard />
        <EmptyItemCard />
        <EmptyItemCard />
        <EmptyItemCard />
        <EmptyItemCard />
        <EmptyItemCard />
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
