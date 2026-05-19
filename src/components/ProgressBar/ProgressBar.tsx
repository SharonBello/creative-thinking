// ═══════════════════════════════════════════════════════════════════
// ProgressBar — horizontal pill stepper showing all 8 sections.
// Sticky below the app bar. Click any visited/current step to jump.
// ═══════════════════════════════════════════════════════════════════
import React from 'react';
import { NavLink, useLocation } from 'react-router-dom';
import { TbCheck } from 'react-icons/tb';
import { SECTIONS, getSectionIndex } from '@/data/sections';
import { useProgressCtx } from '@/components/ModuleShell/ModuleProgressContext';
import type { SectionId } from '@/types/module.types';
import styles from './ProgressBar.module.scss';

const ProgressBar: React.FC = () => {
  const { progress } = useProgressCtx();
  const location = useLocation();
  const currentId = (location.pathname.replace(/^\//, '') || 'opening') as SectionId;
  const currentIdx = getSectionIndex(currentId);

  return (
    <nav className={styles.bar} aria-label="התקדמות בהשתלמות">
      <ol className={styles.steps}>
        {SECTIONS.map((s, i) => {
          const state = progress.sections[s.id];
          const isCurrent = s.id === currentId;
          const isCompleted = state?.completed === true;
          const isVisited = state?.visited === true;
          const isAccessible = i <= currentIdx || isVisited;

          return (
            <li key={s.id} className={styles.stepItem}>
              <NavLink
                to={s.path}
                className={[
                  styles.step,
                  isCurrent && styles.stepCurrent,
                  isCompleted && styles.stepCompleted,
                  !isAccessible && styles.stepLocked,
                ].filter(Boolean).join(' ')}
                aria-current={isCurrent ? 'step' : undefined}
                onClick={(e) => { if (!isAccessible) e.preventDefault(); }}
              >
                <span className={styles.stepNum} aria-hidden>
                  {isCompleted ? <TbCheck /> : s.number}
                </span>
                <span className={styles.stepLabel}>{s.shortHe}</span>
              </NavLink>
            </li>
          );
        })}
      </ol>
    </nav>
  );
};

export default ProgressBar;