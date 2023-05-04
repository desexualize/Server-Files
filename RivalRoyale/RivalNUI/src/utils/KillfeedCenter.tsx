import React, { useState } from 'react';
import { Kill } from 'components';
import { RegisterCommand } from 'utils/CommandManager';
import { CSSTransition, TransitionGroup } from 'react-transition-group';

interface KillType {
  id: number;
  message: string;
  distance: number;
}

export const KillfeedCenter = () => {
  const [kills, setKills] = useState<KillType[]>([]);

  RegisterCommand('REGISTER_KILL', (kill: KillType) => setKills((state) => [...state, kill]));

  const unRegisterKill = (id: number) =>
    setKills((state) => state.filter((kill: KillType) => kill.id !== id));

  return (
    <TransitionGroup className='kill-feed'>
      {kills.map((kill: KillType, index: number) => (
        <CSSTransition timeout={250} key={index}>
          <Kill {...kill} deleteSelf={() => unRegisterKill(kill.id)} />
        </CSSTransition>
      ))}
    </TransitionGroup>
  );
};
