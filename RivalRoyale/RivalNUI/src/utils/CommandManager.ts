const cmdCache = {};

export const RegisterCommand = (commandName: string, callbackHandler: <T>(T) => void): void => {
  cmdCache[commandName] = callbackHandler;
};

export const CMDHandler = <T>(commandName: string, data: T): void => {
  if (cmdCache[commandName]) {
    cmdCache[commandName](data);
  }
};
