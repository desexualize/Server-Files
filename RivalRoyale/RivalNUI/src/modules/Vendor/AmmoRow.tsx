import React, { Fragment } from 'react';
import { VendorTag } from './VendorTag';
import { ItemCard } from './ItemCard';
import { DownloadResource } from 'utils/Resource';
import { EmptyItemCard } from './EmptyItemCard';

const ARAmmo = DownloadResource('resources/photos/ARAmmo.png');

export const AmmoRow = () => {
  return (
    <Fragment>
      <VendorTag label='AMMO' />
      <div className='vendor-row-wrapper'>
        <ItemCard label='Pistol Ammo' price={2500} src={ARAmmo} />
        <ItemCard label='AR Ammo' price={2500} src={ARAmmo} />
        <EmptyItemCard />
        <EmptyItemCard />
        <EmptyItemCard />
        <EmptyItemCard />
        <EmptyItemCard />
      </div>
    </Fragment>
  );
};
