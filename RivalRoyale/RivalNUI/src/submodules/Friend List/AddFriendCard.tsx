import React from 'react';
import { sendClientData } from 'utils/DataHandler';
import { DownloadResource } from 'utils/Resource';

const AddFriendIcon = DownloadResource('resources/photos/AddFriendIcon.png');

export const AddFriendCard: React.FC<{ name: string; id: any }> = ({ name, id }) => {
  return (
    <section
      className='friend-card add-friend-card side-menu-card'
      onClick={() => sendClientData('RIVAL::sendFriendReq', id)}>
      <div>
        <label>{name.toUpperCase()}</label>
        <span>{id}</span>
      </div>
      <div>
        <p>ADD FRIEND</p>
        <img alt='add-friend-icon' src={AddFriendIcon} />
      </div>
    </section>
  );
};
