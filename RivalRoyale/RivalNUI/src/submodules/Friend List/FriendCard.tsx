import React from 'react';
import { FriendProp } from './types';

export const FriendCard: React.FC<FriendProp> = ({ id, name, status, onClick }) => {
  return (
    <section className='friend-card side-menu-card' onClick={(e) => onClick(e, id)}>
      <label>{name.toUpperCase()}</label>
      <span>{status}</span>
    </section>
  );
};
