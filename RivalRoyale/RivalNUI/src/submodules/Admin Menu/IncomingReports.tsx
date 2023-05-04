import React, { useState, useEffect } from 'react';
import { RegisterCommand } from 'utils/CommandManager';
import { fetchClientData } from 'utils/DataHandler';
import { VideoModal } from './VideoModal';

interface Report {
  id: string;
  Name: string;
  UID: number;
  Reason: string;
  ReportedBy: string;
}

export const IncomingReports: React.FC = (props) => {
  const [modalDisplay, setModalDisplay] = useState<boolean>(false);
  const [reports, setReports] = useState<Report[]>([]);
  const [reportId, setReportId] = useState<string>('');

  useEffect(() => {
    fetchClientData('RIVAL::fetchCases').then(setReports);
  }, []);

  RegisterCommand('FORCE_NEW_CASES', setReports);

  return (
    <div className='reports-container'>
      <VideoModal id={reportId} display={modalDisplay} setDisplay={setModalDisplay} />
      {reports.map((report: Report, index: number) => (
        <div className='report-card' key={index}>
          <section>
            <label id='title'>{report.Name}</label>
            <label id='uid'>
              UID <span>{report.UID}</span>
            </label>
            <label id='reason'>
              REASON <span>{report.Reason}</span>
            </label>
            <label id='reported-by'>
              REPORTED BY <span>{report.ReportedBy}</span>
            </label>
          </section>
          <button
            onClick={() => {
              setReportId(report.id);
              setModalDisplay(true);
            }}>
            SHOW EVIDENCE
          </button>
        </div>
      ))}
    </div>
  );
};
