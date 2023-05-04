import React, { useState } from 'react';
import { RegisterCommand } from 'utils/CommandManager';
import { DownloadResource } from 'utils/Resource';

const CashBag = DownloadResource('resources/photos/CashBag.png');
const PlayerIcon = DownloadResource('resources/photos/PlayerIcon.png');
const Headshot = DownloadResource('resources/photos/Headshot.png');

interface Anchor {
  width: number;
  x: number;
  y: number;
}

interface Info {
  cash: number;
  players: number;
  kills: number;
}

export const GameInfo = () => {
  const [anchorPoint, setAnchorPoint] = useState<Anchor>({ width: 0, x: 0, y: 0 });
  const [gameInfo, setGameInfo] = useState<Info>({ cash: 0, players: 0, kills: 0 });

  RegisterCommand('SET_GAME_INFO_ANCHOR', setAnchorPoint);
  RegisterCommand('SET_GAME_INFO', setGameInfo);

  return (
    <div
      className='game-info-container'
      style={{ width: anchorPoint.width, top: anchorPoint.y, left: anchorPoint.x }}>
      <section>
        <img alt='' src={CashBag} />
        <label>{gameInfo.cash}</label>
      </section>
      <section>
        <img alt='' src={PlayerIcon} />
        <label>{gameInfo.players}</label>
      </section>
      <section>
        <img alt='' src={Headshot} />
        <label>{gameInfo.kills}</label>
      </section>
    </div>
  );
};
