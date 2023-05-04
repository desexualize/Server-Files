import React from 'react';
import { DownloadResource } from 'utils/Resource';

const KeyIcon = DownloadResource('resources/photos/LargeKey.png');

export const LargeKey: React.FC<{ value: string }> = ({ value }) => {
  return (
    <section>
      <img alt='' src={KeyIcon} style={{ height: '2.8125rem', width: '9.8125rem' }} />
      <span style={{ fontSize: '1.4375rem', top: '47.5%' }}>{value}</span>
    </section>
  );
};
