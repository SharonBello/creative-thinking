import React from 'react';
import ReactDOM from 'react-dom/client';
import App from './App';
import './styles/global.scss';

// Build ID — bump suffix on each deploy to guarantee a unique bundle hash.
// (Required after the M04 Cloudflare 502-mid-upload incident.)
console.log('M05 build 2026-05-19-1');

ReactDOM.createRoot(document.getElementById('root')!).render(
  <React.StrictMode>
    <App />
  </React.StrictMode>,
);