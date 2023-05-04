import React from 'react';
import { DefaultLayout } from 'layouts';
import { PageComponent } from 'types';
import { ReturnButton } from './ReturnButton';
import { WinnerContent } from './WinnerContent';
import { XPProgressBar } from './XPProgressBar';
import './WinnerPage.scss';

const DeathPage: PageComponent<{}> = () => {
  return (
    <DefaultLayout className='winner-page-overlay'>
      <ReturnButton />
      <WinnerContent />
      <XPProgressBar />
    </DefaultLayout>
  );
};

export default DeathPage;
