// ═══════════════════════════════════════════════════════════════════
// OpeningHero — the visual signature of M05.
// Pop Studio aesthetic: heavy Bagel Fat One display, asymmetric
// colored shape decorations, vibrant accents.
// ═══════════════════════════════════════════════════════════════════
import React from 'react';
import styles from './OpeningHero.module.scss';

const OpeningHero: React.FC = () => (
  <section className={styles.hero} aria-label="פתיחה">
    {/* Decorative shapes — Pop Studio motifs */}
    <span className={styles.shapeCircle} aria-hidden />
    <span className={styles.shapeSquiggle} aria-hidden>
      <svg viewBox="0 0 120 20" fill="none" stroke="currentColor" strokeWidth="4" strokeLinecap="round">
        <path d="M2 10 Q 18 -2, 32 10 T 62 10 T 92 10 T 118 10" />
      </svg>
    </span>
    <span className={styles.shapeStar} aria-hidden>✱</span>
    <span className={styles.shapeBlob} aria-hidden />

    {/* Eyebrow */}
    <span className={styles.eyebrow}>השתלמות · 3 שעות</span>

    {/* Heavy display title */}
    <h1 className={styles.title}>
      חשיבה
      <br />
      <span className={styles.titleAccent}>יצירתית</span>
    </h1>

    {/* Lede */}
    <p className={styles.lede}>
      <strong>3 שעות. 3 טכניקות. 5 כרטיסיות פרומפט.</strong>{' '}
      AI לא מחליף את היצירתיות שלכם — הוא הופך אותה לזמינה{' '}
      <em>גם ביום שני בבוקר, בלי קפה.</em>
    </p>
  </section>
);

export default OpeningHero;