import React from 'react';
import { DownloadResource } from 'utils/Resource';

const KeyIcon = DownloadResource('resources/photos/SmallKey.png');

export const SmallKey: React.FC<{ value: string }> = ({ value }) => {
  return (
    <section>
      <img alt='' src={KeyIcon} />
      <span>{value}</span>
    </section>
  );
};
