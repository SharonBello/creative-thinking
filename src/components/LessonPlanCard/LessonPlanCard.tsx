// ═══════════════════════════════════════════════════════════════════
// LessonPlanCard — reusable time-blocks display for a lesson plan.
// Used by Section 6 (each demo) and Section 7 (personal lesson),
// and rendered in print form by Section 8.
// ═══════════════════════════════════════════════════════════════════
import React from 'react';
import { TbClock } from 'react-icons/tb';
import type { LessonBlock } from '@/data/methods';
import styles from './LessonPlanCard.module.scss';

interface Props {
  titleHe:   string;
  blocks:    LessonBlock[];
  classHe?:  string;
  topicHe?:  string;
  variant?:  'screen' | 'print';
}

const LessonPlanCard: React.FC<Props> = ({
  titleHe, blocks, classHe, topicHe, variant = 'screen',
}) => {
  const totalMin = blocks.reduce((sum, b) => sum + b.durationMin, 0);
  const isPrint = variant === 'print';

  return (
    <article className={[styles.card, isPrint && styles.cardPrint].filter(Boolean).join(' ')}>
      <header className={styles.head}>
        <h3 className={styles.title}>{titleHe}</h3>
        <div className={styles.meta}>
          {classHe && <span>{classHe}</span>}
          {topicHe && <span>· {topicHe}</span>}
          <span className={styles.totalTime}>
            <TbClock aria-hidden /> {totalMin} דק׳
          </span>
        </div>
      </header>

      <ol className={styles.blocks}>
        {blocks.map((b, i) => (
          <li key={i} className={styles.block}>
            <span className={styles.duration}>{b.durationMin}</span>
            <div className={styles.body}>
              <h4 className={styles.blockTitle}>{b.titleHe}</h4>
              <p className={styles.blockDesc}>{b.descriptionHe}</p>
            </div>
          </li>
        ))}
      </ol>
    </article>
  );
};

export default LessonPlanCard;