import React, { useState, useEffect } from 'react';
import { fetchClientData, sendClientData } from 'utils/DataHandler';

interface PlayerProps {
  playerUID: number;
  exit: () => void;
}

const actionButtons = ['BAN', 'KICK', 'SPECTATE', 'MUTE', 'REGISTER WARNING', 'SHOW WARNINGS'];

export const PlayerPage: React.FC<PlayerProps> = ({ playerUID, exit }) => {
  const [playerInfo, setPlayerInfo] = useState<any>();

  useEffect(() => {
    fetchClientData('RIVAL::fetchPlayerInfo', playerUID).then(setPlayerInfo);
  }, [playerUID]);

  if (!playerInfo) {
    return null;
  }

  return (
    <div className='player-info'>
      <section className='side-menu-card player-info-card'>
        <h1>{playerInfo.name}</h1>
        <label>
          USER ID: <span>{playerInfo.UID}</span>
        </label>
        <label>
          STATUS: <span>{playerInfo.status}</span>
        </label>
        <label>
          LAST LOGIN: <span>{playerInfo.lastLogin}</span>
        </label>
      </section>

      {actionButtons.map((action: string, index: number) => (
        <section
          className='side-menu-card'
          key={index}
          onClick={() => sendClientData('RIVAL::performAction', { playerUID, action })}>
          <label>{action}</label>
        </section>
      ))}

      <section className='side-menu-card' onClick={exit}>
        <label>EXIT</label>
      </section>
    </div>
  );
};
