import React, { createRef, useEffect, useRef } from 'react';
import ChatInput from './ChatInput';
import { useChat } from 'stores';
import { useStorage } from 'utils/hooks';
import { sendClientData } from 'utils/DataHandler';
import { RegisterCommand } from 'utils/CommandManager';

export const ChatComponent = () => {
  const [hideChat, setHideChat] = useStorage('hide_chat', false);
  const chatFlowRef = useRef<HTMLDivElement>(null);
  const chatInputRef = createRef<HTMLInputElement>();

  const { section, messages, addMessage, clearSquadChat } = useChat((state) => ({
    section: state.section,
    messages: state.messages,
    addMessage: state.addMessage,
    clearSquadChat: state.clearSquadChat,
  }));

  RegisterCommand('PUSH_CHAT_MESSAGE', addMessage);
  RegisterCommand('CLEAR_SQUAD_CHAT', clearSquadChat);
  useEffect(() => sendClientData('RIVAL::setChatSection', section), [section]);

  useEffect(() => {
    chatFlowRef.current?.scrollTo({
      top: chatFlowRef?.current?.scrollHeight,
      behavior: 'smooth',
    });
  }, [messages]);

  if (hideChat) {
    return (
      <div className='chat-container'>
        <section onClick={() => setHideChat(!hideChat)} className={hideChat && 'chat-hidden'}>
          <label>{hideChat ? 'SHOW CHAT' : 'HIDE CHAT'}</label>
        </section>
      </div>
    );
  }

  function focusRef() {
    chatInputRef?.current?.focus();
  }

  return (
    <div className='chat-container'>
      <section onClick={() => setHideChat(!hideChat)} className={hideChat && 'chat-hidden'}>
        <label>{hideChat ? 'SHOW CHAT' : 'HIDE CHAT'}</label>
      </section>
      <div className='chat-flow' ref={chatFlowRef} onClick={focusRef}>
        {messages &&
          messages.map(
            ({ chatTag, chatMessage, author, section: chatSection }, index: number) =>
              chatSection === section && (
                <div className='chat-message' key={index}>
                  <span id='tag' style={{ color: chatTag.color }}>
                    [{chatTag.label}]
                  </span>
                  <span id='name'>{author}: </span>
                  <span id='message'>{chatMessage}</span>
                </div>
              )
          )}
      </div>
      <ChatInput ref={chatInputRef} />
    </div>
  );
};
