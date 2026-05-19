import React from 'react';
import { ALL_DEMOS } from '@/data/methods';
import type { TechniqueKey } from '@/types/module.types';
import styles from './MethodSelector.module.scss';

interface Props {
  selected: TechniqueKey | null;
  onSelect: (t: TechniqueKey) => void;
}

const MethodSelector: React.FC<Props> = ({ selected, onSelect }) => (
  <section className={styles.section}>
    <span className={styles.eyebrow}>שלב 1 · בחרו שיטה</span>
    <div className={styles.grid}>
      {ALL_DEMOS.map(d => {
        const isActive = selected === d.id;
        return (
          <button
            key={d.id}
            type="button"
            className={[styles.card, isActive && styles.cardActive].filter(Boolean).join(' ')}
            onClick={() => onSelect(d.id)}
            aria-pressed={isActive}
          >
            <h3 className={styles.name}>{d.nameHe}</h3>
            <p className={styles.tagline}>{d.taglineHe}</p>
            <p className={styles.when}>{d.whenToUseHe}</p>
          </button>
        );
      })}
    </div>
  </section>
);

export default MethodSelector;