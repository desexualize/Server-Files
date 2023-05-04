import React, { useRef } from 'react';
import { createGameView } from 'utils/GameView';

export const useRecording = () => {
  const canvasRef = useRef<HTMLCanvasElement>(null);

  const handleRecord = async (time: number): Promise<any> => {
    if (!canvasRef) return;
    createGameView(canvasRef.current);

    const stream: MediaStream | undefined = canvasRef?.current?.captureStream(25);
    if (!stream) {
      return;
    }

    return new Promise((resolve, reject) => {
      const mediaRecorder: MediaRecorder = new MediaRecorder(stream);
      const chunks: Blob[] = [];

      mediaRecorder.ondataavailable = (e: BlobEvent) => e.data.size > 0 && chunks.push(e.data);

      mediaRecorder.onstop = (e: Event) => {
        const completeBlob = new Blob(chunks, { type: chunks[0].type });

        resolve(completeBlob);
      };

      mediaRecorder.start();

      setTimeout(() => {
        mediaRecorder.stop();
      }, time || 0); // Wait x seconds and then stop recording
    });
  };

  const VideoElement: React.FC = () => {
    return (
      <canvas
        ref={canvasRef}
        style={{ display: 'none' }}
        width={window.innerWidth + 'px'}
        height={window.innerHeight + 'px'}
      />
    );
  };

  return { VideoElement, handleRecord };
};
