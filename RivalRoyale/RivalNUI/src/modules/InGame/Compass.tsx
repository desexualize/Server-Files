import React, { useRef } from 'react';
import { RegisterCommand } from 'utils/CommandManager';
import { DownloadResource } from 'utils/Resource';

const Arrow = DownloadResource('resources/photos/CompassArrow.png');

export const Compass: React.FC = React.memo(() => {
  const rotationRef = useRef<HTMLDivElement>(null);

  RegisterCommand('SET_COMPASS_HEADING', (direction) => {
    if (rotationRef.current)
      rotationRef.current.style.transform = `translate3d(${direction / 16}em, 0, 0)`;
  });

  return (
    <div className='compass-overlay'>
      <img alt='' src={Arrow} />
      <div className='compass-wrapper'>
        <div ref={rotationRef} />
      </div>
    </div>
  );
});
