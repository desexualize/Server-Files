import React from 'react';
import { DownloadResource } from 'utils/Resource';

const KeyIcon = DownloadResource('resources/photos/MediumKey.png');

export const MediumKey: React.FC<{ value: string }> = ({ value }) => {
  return (
    <section>
      <img alt='' src={KeyIcon} style={{ height: '2.8125rem', width: '6.0625rem' }} />
      <span style={{ fontSize: '1.4375rem', top: '47.5%' }}>{value}</span>
    </section>
  );
};
