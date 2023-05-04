import React, { Fragment, useState, useEffect } from 'react';
import { SearchField } from 'components';
import { fetchClientData } from 'utils/DataHandler';
import { PlayerPage } from './PlayerPage';

interface Player {
  UID: number;
  name: string;
}

export const PlayerList: React.FC = (props) => {
  const [players, setPlayers] = useState<Player[]>([]);
  const [searches, setSearches] = useState<Player[]>(players);
  const [viewingPlayer, setViewingPlayer] = useState<number>(0);

  useEffect(() => {
    fetchClientData('RIVAL::fetchPlayers').then(setPlayers);
  }, []);

  useEffect(() => {
    setSearches(players);
  }, [players]);

  const sortByKey = (array: any[], key: string) => {
    return array.sort((a, b) => {
      let x = a[key];
      let y = b[key];

      if (typeof x === 'string') {
        x = ('' + x).toLowerCase();
      }
      if (typeof y === 'string') {
        y = ('' + y).toLowerCase();
      }

      return x < y ? -1 : x > y ? 1 : 0;
    });
  };

  const handleSearch = (event: React.ChangeEvent<HTMLInputElement>): void => {
    const value = event.target.value;
    if (parseInt(value)) {
      // Filter by UID
      const filteredPlayers = players.filter((player: Player) =>
        player.UID.toString().startsWith(value)
      );

      setSearches(sortByKey(filteredPlayers, 'UID'));
    } else {
      // Filter by Name
      const filteredPlayers = players.filter((player: Player) => player.name.includes(value));
      setSearches(sortByKey(filteredPlayers, 'name'));
    }
  };

  return (
    <div className='player-list'>
      {viewingPlayer === 0 ? (
        <Fragment>
          <SearchField callback={handleSearch} />
          <div className='player-slots'>
            {searches.map((player: Player) => (
              <section className='side-menu-card' onClick={() => setViewingPlayer(player.UID)}>
                <label>{player.name}</label>
                <label>
                  UID: <span>{player.UID}</span>
                </label>
              </section>
            ))}
          </div>
        </Fragment>
      ) : (
        <PlayerPage playerUID={viewingPlayer} exit={() => setViewingPlayer(0)} />
      )}
    </div>
  );
};
