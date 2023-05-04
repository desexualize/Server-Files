import React, { useCallback, useEffect, useState } from 'react';
import { SearchField } from 'components';
import { PageComponent } from 'types';
import { AddFriendCard } from './AddFriendCard';
import { useFriends } from 'stores';

export const AddFriendPage: PageComponent<{}> = () => {
  const onlinePlayers = useFriends((state) => state.OnlinePlayers);
  const [searches, setSearches] = useState<any>(onlinePlayers);

  useEffect(() => {
    setSearches(onlinePlayers);
  }, [onlinePlayers]);

  const sortPlayers = useCallback((array: any[], key: string) => {
    return array.sort((a, b) => {
      let x = key === 'name' ? a[0] : a[1];
      let y = key === 'name' ? b[0] : b[1];

      if (typeof x === 'string') {
        x = ('' + x).toLowerCase();
      }
      if (typeof y === 'string') {
        y = ('' + y).toLowerCase();
      }

      return x < y ? -1 : x > y ? 1 : 0;
    });
  }, []);

  const handleSearch = (event: React.ChangeEvent<HTMLInputElement>): void => {
    const value = event.target.value;
    if (parseInt(value)) {
      // Filter by UID
      const filteredPlayers = Object.entries(onlinePlayers).filter((player) =>
        player[1].toString().startsWith(value)
      );

      setSearches(Object.fromEntries(filteredPlayers));
    } else {
      // Filter by Name

      const filteredPlayers = Object.entries(onlinePlayers).filter((player) =>
        player[0].includes(value)
      );

      setSearches(Object.fromEntries(filteredPlayers));
    }
  };

  return (
    <div className='add-friend-container'>
      <SearchField callback={handleSearch} />
      <div className='add-friend-wrapper'>
        {Object.entries(searches).map((Player) => (
          <AddFriendCard name={Player[0]} id={Player[1]} />
        ))}
      </div>
    </div>
  );
};
