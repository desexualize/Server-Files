import React from 'react';
import { useClothing } from 'stores';
import { DownloadResource } from 'utils/Resource';
import { ClothingComponent } from './ClothingComponent';

const topRow = {
  Hair: DownloadResource('resources/photos/HairIcon.png'),
  Mask: DownloadResource('resources/photos/MaskIcon.png'),
  Helmet: DownloadResource('resources/photos/HelmetIcon.png'),
};

const middleRow = {
  Torso: DownloadResource('resources/photos/TorsoIcon.png'),
  Undershirt: DownloadResource('resources/photos/UndershirtIcon.png'),
};

const bottomRow = {
  Pants: DownloadResource('resources/photos/PantsIcon.png'),
  Shoes: DownloadResource('resources/photos/ShoesIcon.png'),
  Parachute: DownloadResource('resources/photos/ParachuteIcon.png'),
};

export const ClothingPanel: React.FC = () => {
  const ownedClothes = useClothing((state) => state.clothes);

  return (
    <div className='clothing-panel'>
      <div className='clothing-container'>
        {Object.keys(topRow).map((title, index: number) => (
          <ClothingComponent
            title={title}
            src={topRow[title]}
            ownedClothing={ownedClothes[title]}
            key={index}
          />
        ))}
      </div>
      <div className='clothing-container'>
        {Object.keys(middleRow).map((title, index: number) => (
          <ClothingComponent
            title={title}
            src={middleRow[title]}
            ownedClothing={ownedClothes[title]}
            key={index}
          />
        ))}
      </div>
      <div className='clothing-container'>
        {Object.keys(bottomRow).map((title, index: number) => (
          <ClothingComponent
            title={title}
            src={bottomRow[title]}
            ownedClothing={ownedClothes[title]}
            key={index}
          />
        ))}
      </div>
    </div>
  );
};
