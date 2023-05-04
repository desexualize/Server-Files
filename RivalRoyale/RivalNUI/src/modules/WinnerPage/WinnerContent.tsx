import React, { useEffect, useState } from 'react';
import { fetchClientData } from 'utils/DataHandler';

export const WinnerContent = () => {
  const [winningPlayers, setWinningPlayers] = useState<any>([]);

  useEffect(() => {
    fetchClientData('RIVAL::getWinningPlayers').then(setWinningPlayers);
  }, []);

  return (
    <div className='winner-content'>
      <h1>VICTORY</h1>

      <section className='winner-players'>
        <h2>WINNERS</h2>
        <div>
          {winningPlayers.map((player, index: number) => (
            <label key={index}>
              <span>[{player.uid}]</span>
              {player.name}
            </label>
          ))}
        </div>
      </section>
    </div>
  );
};
