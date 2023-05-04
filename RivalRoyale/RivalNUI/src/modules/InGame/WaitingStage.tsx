import React, { useRef } from 'react';
import { RegisterCommand } from 'utils/CommandManager';

export const WaitingStage: React.FC = () => {
  const counterRef = useRef<HTMLHeadingElement>(null);

  RegisterCommand('SET_PLAYER_COUNT', (count) => {
    if (counterRef.current) counterRef.current.innerText = `${count} / 32 PLAYERS`;
  });

  return (
    <h1 className='waiting-stage' ref={counterRef}>
      0 / 32 PLAYERS
    </h1>
  );
};
