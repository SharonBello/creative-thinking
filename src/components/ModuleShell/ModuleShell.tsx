// ═══════════════════════════════════════════════════════════════════
// ModuleShell — common wrapper around every section.
// Provides ModuleProgressContext + renders the ProgressBar + Outlet.
// ═══════════════════════════════════════════════════════════════════
import React from 'react';
import { Outlet } from 'react-router-dom';
import { useModuleProgress } from '@/hooks/useModuleProgress';
import { ModuleProgressContext } from './ModuleProgressContext';
import ProgressBar from '@/components/ProgressBar/ProgressBar';
import styles from './ModuleShell.module.scss';

const ModuleShell: React.FC = () => {
  const progress = useModuleProgress();

  return (
    <ModuleProgressContext.Provider value={progress}>
      <div className={styles.shell}>
        <ProgressBar />
        <div className={styles.main}>
          <Outlet />
        </div>
      </div>
    </ModuleProgressContext.Provider>
  );
};

export default ModuleShell;