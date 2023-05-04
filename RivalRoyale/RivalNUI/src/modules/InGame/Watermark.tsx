import React from 'react';
import { DownloadResource } from 'utils/Resource';

const Logo = DownloadResource('resources/photos/RivalLogo.png');

export const Watermark = () => {
  return <img className='water-mark' alt='' src={Logo} />;
};
