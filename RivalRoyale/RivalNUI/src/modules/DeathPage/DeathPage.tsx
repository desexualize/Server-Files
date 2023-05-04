import React from 'react';
import { DailyChallenges } from './DailyChallenges';
import { DeathContent } from './DeathContent';
import { DefaultLayout } from 'layouts';
import { ReturnButton } from './ReturnButton';
import { PageComponent } from 'types';
import './DeathPage.scss';

const DeathPage: PageComponent<{}> = () => {
  return (
    <DefaultLayout className='death-page-overlay'>
      <ReturnButton />
      <DeathContent />
      <DailyChallenges />
    </DefaultLayout>
  );
};

export default DeathPage;
