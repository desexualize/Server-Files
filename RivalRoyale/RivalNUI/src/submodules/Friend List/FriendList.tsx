import React, { useRef, useState } from 'react';
import shallow from 'zustand/shallow';
import { FriendPage } from './FriendPage';
import { useMountEffect, useOutsideClick } from 'utils/hooks';
import { fetchClientData } from 'utils/DataHandler';
import { useFriends, useSideMenu } from 'stores';
import { DownloadResource } from 'utils/Resource';
import { AddFriendPage } from './AddFriendPage';
import './FriendList.scss';

const FriendIcon = DownloadResource('resources/photos/FriendIcon.png');

export const FriendList: React.FC = (props) => {
  const [activeSection, setActiveSection] = useState<string>('friend-page');
  const friendListRef = useRef<HTMLDivElement>(null);
  const setDisplay = useSideMenu((state) => state.setDisplay);

  const { clearFriends, addFriend, Friends, setOnlinePlayers } = useFriends(
    (state) => ({
      clearFriends: state.clearFriends,
      addFriend: state.addFriend,
      Friends: state.Friends,
      setOnlinePlayers: state.setOnlinePlayers,
    }),
    shallow
  );

  useOutsideClick(friendListRef, () => {
    friendListRef?.current?.classList.add('slideRight');
    setTimeout(() => setDisplay('friendList', false), 350);
  });

  useMountEffect(() => {
    clearFriends();

    fetchClientData('RIVAL::fetchFriends').then((newFriends) => {
      Object.entries(newFriends).forEach((friend: any, v) => {
        addFriend({ id: friend[1].id, name: friend[0], status: friend[1].status });
      });
    });

    fetchClientData('RIVAL::fetchOnlinePlayers').then(setOnlinePlayers);
  });

  const handleChangeSection = (section: string): void => {
    setActiveSection(section);
  };

  const getOnlineFriendCount = (): number => {
    let count = 0;
    Object.values(Friends).forEach((friend) => {
      if (friend.status === 'ONLINE') count += 1;
    });

    return count;
  };

  return (
    <div className='side-menu-container' ref={friendListRef}>
      <div className='friend-list-banner'>
        <section>
          <img alt='' src={FriendIcon} />
          <span>{getOnlineFriendCount() || 0}</span>
        </section>
        <label>ONLINE FRIENDS</label>
      </div>
      <div className='side-menu-section'>
        <section
          className={activeSection === 'friend-page' ? 'active' : ''}
          style={{ marginRight: '0.625em', marginLeft: '-1.5em' }}
          onClick={() => handleChangeSection('friend-page')}>
          <span style={{ marginLeft: '1.125em' }}>FRIEND LIST</span>
        </section>
        <section
          className={activeSection === 'add-friend' ? 'active' : ''}
          style={{ marginLeft: '0.625em', marginRight: '-1.5em' }}
          onClick={() => handleChangeSection('add-friend')}>
          <span style={{ marginLeft: '0.625em' }}>ADD FRIEND</span>
        </section>
      </div>
      {activeSection === 'friend-page' && <FriendPage />}
      {activeSection === 'add-friend' && <AddFriendPage />}
    </div>
  );
};
