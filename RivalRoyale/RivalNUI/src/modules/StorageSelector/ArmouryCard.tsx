import React from 'react';
import { DownloadResource } from 'utils/Resource';

const ArmouryBackground = DownloadResource('resources/photos/AKBackground.png');
const ArmouryCharacter = DownloadResource('resources/photos/ArmouryCharacter.png');

export const ArmouryCard = () => {
  return (
    <div className='storage-card armoury-card'>
      <img className='storage-card-image' alt='' src={ArmouryBackground} />
      <img className='storage-card-character' alt='' src={ArmouryCharacter} />
      <div className='storage-card-bottom'>
        <label>ARMOURY</label>
      </div>
    </div>
  );
};
