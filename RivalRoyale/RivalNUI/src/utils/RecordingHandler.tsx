import React, { useCallback } from 'react';
import { useRecording } from 'utils/hooks';
import { RegisterCommand } from 'utils/CommandManager';

const RecordingHandler: React.FC = () => {
  const { VideoElement, handleRecord } = useRecording();

  const handleFileUpload = useCallback((blob: Blob, data: any): void => {
    const reader: FileReader = new FileReader();

    reader.onload = (event) => {
      if (!event.target) {
        return;
      }

      const base64: ArrayBuffer | string | null = event.target.result;

      if (base64) {
        fetch('http://localhost:5050/recording/upload', {
          headers: {
            Accept: 'application/json',
            'Content-Type': 'application/json',
          },
          method: 'POST',
          body: JSON.stringify({ base64: base64, data: data }),
        });
      }
    };

    reader.readAsDataURL(blob);
  }, []);

  RegisterCommand('START_CLIENT_RECORD', (data) => {
    handleRecord(2500).then((blob) => {
      handleFileUpload(blob, data);
    });
  });

  return <VideoElement />;
};

export default RecordingHandler;
