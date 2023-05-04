import React from 'react';
import { Friend } from './types';

export const OfflineFriendCard: React.FC<Friend> = ({ name, status }) => {
  return (
    <section className='friend-card offline-friend-card side-menu-card'>
      <label>{name.toUpperCase()}</label>
      <span>{status}</span>
    </section>
  );
};
