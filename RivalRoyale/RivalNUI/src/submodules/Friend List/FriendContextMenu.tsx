import React, { useRef } from 'react';
import { useFriends } from 'stores';
import { useOutsideClick } from 'utils/hooks';
import { sendClientData } from 'utils/DataHandler';

interface ContextProps {
  hideMenu: () => void;
  player: number;
  y: number;
}

export const FriendContextMenu: React.FC<ContextProps> = ({ player, hideMenu, y }) => {
  const contextRef = useRef<HTMLDivElement>(null);
  const removeFriend = useFriends((state) => state.removeFriend);

  useOutsideClick(contextRef, hideMenu);

  const handleInvite = (): void => {
    hideMenu();
    sendClientData('RIVAL::invitePlayer', player);
  };

  const handleRemoval = (): void => {
    hideMenu();
    removeFriend(player);
  };

  return (
    <div
      className='friend-context-menu'
      style={{ top: y + 'px', left: '26.302vw' }}
      ref={contextRef}>
      <section className='friend-context-item' onClick={handleInvite}>
        INVITE TO GAME
      </section>
      <section className='friend-context-item' onClick={handleRemoval}>
        REMOVE FRIEND
      </section>
    </div>
  );
};
