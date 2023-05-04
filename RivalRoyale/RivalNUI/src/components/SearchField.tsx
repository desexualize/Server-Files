import React from 'react';
import { DownloadResource } from 'utils/Resource';

const SearchIcon = DownloadResource('resources/photos/SearchIcon.png');

export const SearchField: React.FC<{ callback: (a) => void }> = ({ callback }) => {
  return (
    <div className='player-search'>
      <img alt='' src={SearchIcon} />
      <input
        className='player-search-bar'
        placeholder='Search for a player...'
        onChange={callback}
      />
    </div>
  );
};
