// ═══════════════════════════════════════════════════════════════════
// ClosingHero — opening of Section 8. Quick summary of what was built.
// ═══════════════════════════════════════════════════════════════════
import React from 'react';
import styles from './ClosingHero.module.scss';

const STATS = [
  { value: '4', labelHe: 'שיעורים מוכנים' },
  { value: '5', labelHe: 'כרטיסיות פרומפט' },
  { value: '3', labelHe: 'שיטות חשיבה' },
];

const ClosingHero: React.FC = () => (
  <section className={styles.section}>
    <span className={styles.eyebrow}>סיכום</span>
    <h2 className={styles.title}>בשעתיים וחצי האחרונות בניתם משהו ממשי.</h2>
    <p className={styles.lede}>
      לא רק הקשבתם. לא רק "למדתם על". <em>תרגלתם בעצמכם</em> חשיבה מסתעפת.
      בניתם שיעור על נושא אמיתי בכיתה אמיתית. בחרתם שיטה. ניסחתם פרומפט.
      תיעדתם הרהור. הנה הקיט שלוקחים הביתה:
    </p>

    <dl className={styles.stats}>
      {STATS.map(s => (
        <div key={s.labelHe} className={styles.stat}>
          <dt className={styles.statValue}>{s.value}</dt>
          <dd className={styles.statLabel}>{s.labelHe}</dd>
        </div>
      ))}
    </dl>
  </section>
);

export default ClosingHero;