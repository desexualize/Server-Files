export function sendClientData<T>(eventName: string, content?: T): void {
  fetch(`https://RivalCore/${eventName}`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: JSON.stringify(content),
  });
}

export function fetchClientData<T>(eventName: string, content?: T): any {
  return new Promise((resolve, reject) => {
    fetch(`https://RivalCore/${eventName}`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: JSON.stringify(content || {}),
    })
      .then((res) => res.json())
      .then((res) => {
        if (res !== 'error') {
          resolve(res);
        } else {
          reject(res);
        }
      })
      .catch((err) => reject(err));
  });
}
