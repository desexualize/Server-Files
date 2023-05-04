import React, { Fragment, useCallback } from 'react';
import shallow from 'zustand/shallow';
import { DownloadResource } from 'utils/Resource';
import { sendClientData } from 'utils/DataHandler';
import { useChat } from 'stores';

const ArrowRightIcon = DownloadResource('resources/photos/ArrowRight.png');

const ChatInput: React.FC<any> = React.forwardRef((_, ref: React.LegacyRef<HTMLInputElement>) => {
  const { section, setSection } = useChat(
    (state) => ({
      section: state.section,
      setSection: state.setSection,
    }),
    shallow
  );

  const handleChatMessage = useCallback(
    ({ key, target }) => {
      const chatText = target.value;

      if (key === 'Enter' && chatText.length > 1) {
        sendClientData('RIVAL::registerChatMessage', {
          chatMessage: chatText,
          section: section,
        });

        target.value = '';
      }
    },
    [section]
  );

  const handleFocused = () => sendClientData('RIVAL::toggleKeys', true);
  const handleLeaveFocus = () => sendClientData('RIVAL::toggleKeys');

  return (
    <Fragment>
      <div className='chat-input'>
        <img alt='' src={ArrowRightIcon} />
        <input
          placeholder='SAY...'
          onKeyUp={handleChatMessage}
          onFocus={handleFocused}
          onBlur={handleLeaveFocus}
          ref={ref}
        />
      </div>
      <div className='chat-sections'>
        <section
          className={section === 'GLOBAL' ? 'chat-active-section' : ''}
          onClick={() => setSection('GLOBAL')}>
          <label>GLOBAL</label>
        </section>
        <section
          className={section === 'SQUAD' ? 'chat-active-section' : ''}
          onClick={() => setSection('SQUAD')}>
          <label>SQUAD</label>
        </section>
        <section
          className={section === 'EU' ? 'chat-active-section' : ''}
          onClick={() => setSection('EU')}>
          <label>EU</label>
        </section>
        <section
          className={section === 'US' ? 'chat-active-section' : ''}
          onClick={() => setSection('US')}>
          <label>US</label>
        </section>
      </div>
    </Fragment>
  );
});

export default ChatInput;
