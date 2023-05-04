export const DownloadResource = (relativePath: string): string => {
  const loadedAsset = require('../' + relativePath);
  return './' + loadedAsset.default;
};
