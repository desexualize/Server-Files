import create from 'zustand';

interface ChatMessage {
  timeStamp: string;
  chatMessage: string;
  author: string;
  section: string;
  chatTag: {
    label: string;
    color: string;
  };
}

interface Chat {
  messages: ChatMessage[];
  section: string;

  setSection: (section: string) => void;
  addMessage: (message: ChatMessage) => void;
  clearSquadChat: () => void;
}

const ChatStore = (set, get) => ({
  messages: [],
  section: 'GLOBAL',

  addMessage: (message) => {
    set((state) => ({ messages: [...state.messages, message] }));
  },

  setSection: (section) => {
    set((state) => ({ section: section }));
  },

  clearSquadChat: () => {
    const currentMessages = get().messages;
    const filteredMessages = currentMessages.filter((message) => message.section !== 'SQUAD');

    set((state) => ({ messages: filteredMessages }));
  },
});

export const useChat = create<Chat>(ChatStore);
