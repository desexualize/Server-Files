import React from 'react';
import { DefaultLayout } from 'layouts';
import { DownloadResource } from 'utils/Resource';
import { PageComponent } from 'types';
import './DiscordWidget.scss';

const DiscordLogo = DownloadResource('resources/photos/DiscordLogo.png');
const DiscordWidget: PageComponent<{}> = () => {
  return (
    <DefaultLayout className='discord-widget'>
      <div className='widget-banner'>
        <img alt='' src={DiscordLogo} />
      </div>
      <h1>HEY! WE NOTICE YOU ARE NOT APART OF OUR DISCORD!</h1>
      <label>JOIN HERE</label>

      {/* @ts-ignore */}
      <button onClick={() => window.invokeNative('openUrl', 'https://discord.gg/z2BVCQ8ruy')}>
        CONNECT
      </button>
    </DefaultLayout>
  );
};

export default DiscordWidget;
