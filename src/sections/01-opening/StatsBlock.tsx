// ═══════════════════════════════════════════════════════════════════
// StatsBlock — what teachers leave with. Three big colored blocks.
// Pop Studio: each block its own bold color, stacked shadow.
// ═══════════════════════════════════════════════════════════════════
import React from 'react';
import { TbToolsKitchen3, TbCards, TbConfetti } from 'react-icons/tb';
import styles from './StatsBlock.module.scss';

const STATS = [
  {
    icon: <TbToolsKitchen3 aria-hidden />,
    big: '3',
    label: 'מהלכי יצירתיות',
    sub: 'SCAMPER · Design Thinking · "מה אם..."',
    tint: 'purple',
  },
  {
    icon: <TbConfetti aria-hidden />,
    big: '4',
    label: 'שיעורים מוכנים',
    sub: '3 דמו + השיעור שלכם, כל אחד PDF נפרד',
    tint: 'coral',
  },
  {
    icon: <TbCards aria-hidden />,
    big: '5',
    label: 'כרטיסיות פרומפט',
    sub: 'מודפסות לשולחן, מוכנות לכל שיעור',
    tint: 'mint',
  },
] as const;

const StatsBlock: React.FC = () => (
  <section className={styles.block} aria-label="מה ייצא לכם מההשתלמות">
    <ul className={styles.grid}>
      {STATS.map((s, i) => (
        <li key={i} className={[styles.stat, styles[`tint-${s.tint}`]].join(' ')}>
          <span className={styles.icon}>{s.icon}</span>
          <span className={styles.big}>{s.big}</span>
          <span className={styles.label}>{s.label}</span>
          <span className={styles.sub}>{s.sub}</span>
        </li>
      ))}
    </ul>
  </section>
);

export default StatsBlock;