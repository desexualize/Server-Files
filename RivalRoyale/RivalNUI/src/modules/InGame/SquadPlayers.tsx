import React, { useState } from 'react';
import { RegisterCommand } from 'utils/CommandManager';

interface SquadPlayer {
  name: string;
  avatar: string;
  talking: boolean;
}

export const SquadPlayers = () => {
  const [squadPlayers, setSquadPlayers] = useState<SquadPlayer[]>([]);
  RegisterCommand('SET_SQUAD_MEMBERS', setSquadPlayers);

  if (!squadPlayers) {
    return null;
  }

  return (
    <div className='squad-players'>
      {squadPlayers &&
        squadPlayers.map(
          (player: SquadPlayer, index: number) =>
            player && (
              <section key={index}>
                <img
                  alt=''
                  src={player.avatar}
                  style={{ borderColor: player.talking ? '#FDFF85' : '#3c3c3c' }}
                />
                <label>{player.name}</label>
              </section>
            )
        )}
    </div>
  );
};
