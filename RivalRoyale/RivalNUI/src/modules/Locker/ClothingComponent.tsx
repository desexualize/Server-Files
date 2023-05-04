import React, { useEffect, useState } from 'react';
import { Arrow } from './Arrow';
import { useStorage } from 'utils/hooks';
import { sendClientData } from 'utils/DataHandler';
import { PlaySound } from 'utils/SoundManager';

interface ClothingProps {
  title: string;
  src: string;
  ownedClothing: any;
}

interface Num {
  min: number;
  max: number;
}

export const ClothingComponent: React.FC<ClothingProps> = ({ title, src, ownedClothing }) => {
  const [clothingData, setClothingData] = useStorage('clothing-' + title, {
    componentId: 0,
    textureId: 0,
  });

  const componentNum: Num = { min: 0, max: ownedClothing.length - 1 };
  const [textureNum, setTextureNum] = useState<Num>({ min: 0, max: 0 });

  const handleChange = (type, data) => {
    if (type === 'componentId') {
      PlaySound('click');

      const formattedNum = Math.max(
        Number(componentNum.min),
        Math.min(Number(componentNum.max), Number(data))
      );

      if (formattedNum === clothingData.componentId) {
        return;
      }

      sendClientData('RIVAL::swapClothingComponent', {
        component: title,
        componentId: ownedClothing[formattedNum],
        textureId: 0,
      });

      return setClothingData({ componentId: formattedNum, textureId: textureNum.min });
    }
    PlaySound('change');

    let formattedNum = clothingData.textureId + 1;
    if (formattedNum > textureNum.max) {
      formattedNum = textureNum.min;
    }

    sendClientData('RIVAL::swapClothingComponent', {
      component: title,
      textureId: formattedNum,
      componentId: ownedClothing[clothingData.componentId],
    });

    setClothingData({ componentId: clothingData.componentId, textureId: formattedNum });
  };

  useEffect(() => {
    ownedClothing.forEach((cloth) => {
      if (cloth.id === ownedClothing[clothingData.componentId].id) {
        setTextureNum((p) => ({ max: cloth.textureId - 1, min: p.min }));
      }
    });
  }, [clothingData.componentId, ownedClothing]);

  return (
    <div className='clothing-content'>
      <label>{title.toUpperCase()}</label>
      <img alt='' src={src} onClick={() => handleChange('textureId', null)} />

      <section>
        <Arrow onClick={() => handleChange('componentId', clothingData.componentId - 1)} />
        {clothingData.componentId} / {componentNum.max}
        <Arrow onClick={() => handleChange('componentId', clothingData.componentId + 1)} />
      </section>
    </div>
  );
};
