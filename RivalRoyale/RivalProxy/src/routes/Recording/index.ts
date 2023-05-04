import express, { Request, Response } from 'express';

const path = require('path');
const router = express.Router();
const fs = require('fs');
const connection = require('../../mysql');
const { v4: uuidv4 } = require('uuid');

// Upload the recording
router.post('/upload', (req: Request, res: Response) => {
  const dataUrl = req.body.base64;
  const data = req.body.data;
  const id = uuidv4();
  const base64Video = dataUrl.split(';base64,').pop();

  // Write the file to the directory
  fs.writeFile(`stream/${id}.webm`, base64Video, { encoding: 'base64' }, (err: Error) => {
    if (err) {
      return res.sendStatus(404);
    }

    res.sendStatus(200);

    // Insert data into database
    const query = `INSERT INTO rival_cases (UID, id, Name, Reason, ReportedBy) VALUES (${data.uid}, "${id}", "${data.name}", "${data.reason}", "${data.reportedBy}")`;
    connection.query(query);
  });
});

router.get('/:id', (req: Request, res: Response) => {
  // Fixes cors issue
  res.header('Access-Control-Allow-Origin', '*');

  const videoId = req.params.id;
  const absolutePath = path.join(__dirname, '../../../');
  const filePath = `stream/${videoId}`;

  // Sends video if it exists
  if (fs.existsSync(filePath)) {
    return res.sendFile(path.join(absolutePath, filePath));
  }

  res.sendStatus(404);
});

module.exports = router;
