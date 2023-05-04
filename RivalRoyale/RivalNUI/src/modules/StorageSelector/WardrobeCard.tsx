import React from 'react';
import { DownloadResource } from 'utils/Resource';

const WardrobeBackground = DownloadResource('resources/photos/WardrobeBackground.png');
const WardrobeCharacter = DownloadResource('resources/photos/WardrobeCharacter.png');

export const WardrobeCard = () => {
  return (
    <div className='storage-card wardrobe-card'>
      <img className='storage-card-image' alt='' src={WardrobeBackground} />
      <img className='storage-card-character' alt='' src={WardrobeCharacter} />
      <div className='storage-card-bottom'>
        <label>WARDROBE</label>
      </div>
    </div>
  );
};
