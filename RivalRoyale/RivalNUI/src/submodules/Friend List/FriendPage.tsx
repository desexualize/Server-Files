import React, { Fragment, useState, useCallback } from 'react';
import { useFriends } from 'stores';
import { FriendContextMenu } from './FriendContextMenu';
import { FriendCard } from './FriendCard';
import { OfflineFriendCard } from './OfflineFriendCard';
import { Friend } from './types';

export const FriendPage: React.FC = () => {
  const friends = useFriends((state) => state.Friends);

  const [anchorPoint, setAnchorPoint] = useState<number>(0);
  const [selectedPlayer, setSelectedPlayer] = useState<number>(0);
  const [showContext, setShowContext] = useState<boolean>(false);

  const handleContextMenu = useCallback((event, player) => {
    let { target } = event;
    target = target.tagName === 'SECTION' ? target : target.parentNode;

    setAnchorPoint(target.offsetTop);
    setSelectedPlayer(player);
    setShowContext(true);
  }, []);

  if (friends.length === 0) {
    return <label className='friend-list-empty'>YOUR FRIEND LIST IS EMPTY</label>;
  }

  return (
    <div className='friend-list-container'>
      {friends.map((friend: Friend, index: number) => (
        <Fragment key={index}>
          {friend.status === 'OFFLINE' ? (
            <OfflineFriendCard {...friend} />
          ) : (
            <FriendCard {...friend} onClick={handleContextMenu} />
          )}
        </Fragment>
      ))}

      {showContext && (
        <FriendContextMenu
          player={selectedPlayer}
          hideMenu={() => setShowContext(false)}
          y={anchorPoint}
        />
      )}
    </div>
  );
};
