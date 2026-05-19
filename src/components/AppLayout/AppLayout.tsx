// ═══════════════════════════════════════════════════════════════════
// AppLayout — outer chrome (top bar) wrapping everything.
// ═══════════════════════════════════════════════════════════════════
import React from 'react';
import { Outlet } from 'react-router-dom';
import { TbSparkles } from 'react-icons/tb';
import styles from './AppLayout.module.scss';

const AppLayout: React.FC = () => (
  <div className={styles.app}>
    <header className={styles.bar}>
      <div className={styles.barInner}>
        <span className={styles.brand}>
          <span className={styles.brandIcon} aria-hidden><TbSparkles /></span>
          <span className={styles.brandText}>BinAI</span>
          <span className={styles.brandModule}>· מודול 05</span>
        </span>
        <span className={styles.tagline}>חשיבה יצירתית עם AI</span>
      </div>
    </header>
    <main className={styles.main}>
      <Outlet />
    </main>
  </div>
);

export default AppLayout;