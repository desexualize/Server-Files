import React, { Fragment } from 'react';
import { DefaultLayout } from 'layouts';
import { PageComponent } from 'types';
import { ArmouryCard } from './ArmouryCard';
import { WardrobeCard } from './WardrobeCard';
import { Navigation } from 'components';
import './StorageSelector.scss';

const StorageSelector: PageComponent<{}> = () => {
  return (
    <Fragment>
      <Navigation />
      <DefaultLayout className='storage-selector'>
        <ArmouryCard />
        <WardrobeCard />
      </DefaultLayout>
    </Fragment>
  );
};

export default StorageSelector;
