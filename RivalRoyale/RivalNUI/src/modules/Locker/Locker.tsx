import React, { useEffect, useState } from 'react';
import { useClothing } from 'stores';
import { Navigation } from 'components';
import { fetchClientData } from 'utils/DataHandler';
import { ClothingPanel } from './ClothingPanel';
import { ClothingToolTip } from './ClothingToolTip';
import { DefaultLayout } from 'layouts';
import { PageComponent } from 'types';
import './Locker.scss';

const Locker: PageComponent<{}> = () => {
  const [loaded, setLoaded] = useState<boolean>(false);
  const setClothes = useClothing((state) => state.setClothes);

  useEffect(() => {
    fetchClientData('RIVAL::enterLocker').then((ownedClothes) => {
      setClothes(ownedClothes);
      setLoaded(true);
    });
  }, [setClothes]);

  if (!loaded) {
    return null;
  }

  return (
    <DefaultLayout>
      <Navigation />
      <ClothingPanel />
      <ClothingToolTip />
    </DefaultLayout>
  );
};

export default Locker;
