import React, { useState, useRef, useEffect } from 'react';
import { Modal } from 'components';
import { sendClientData } from 'utils/DataHandler';

interface VideoProps {
  display: boolean;
  id: string;
  setDisplay: (value: boolean) => void;
}

export const VideoModal: React.FC<VideoProps> = ({ id, display, setDisplay }) => {
  const [paused, setPaused] = useState<boolean>(false);
  const videoRef = useRef<HTMLVideoElement>(null);

  if (!display) {
    return null;
  }

  const handleEvidence = (cheating: boolean): void => {
    setDisplay(false);
    sendClientData('RIVAL::registerAdminOpinion', { id: id, cheating: cheating });
  };

  const handlePauseState = (): void => {
    const pauseState = !paused;
    setPaused(pauseState);

    if (videoRef.current) {
      pauseState ? videoRef.current.pause() : videoRef.current.play();
    }
  };

  return (
    <Modal setDisplay={setDisplay} width='66.6666%' height='66.6666%'>
      <video autoPlay controls controlsList='nodownload' ref={videoRef} onClick={handlePauseState}>
        <source src={`http://localhost:5050/recording/${id}.webm`} />
      </video>
      <button style={{ background: '#48DD69' }} onClick={() => handleEvidence(false)}>
        NO EVIDENCE
      </button>
      <button style={{ background: '#EC3535' }} onClick={() => handleEvidence(true)}>
        EVIDENCE
      </button>
    </Modal>
  );
};
