// ═══════════════════════════════════════════════════════════════════
// CaseStudies — 4 brands, 4 constraints, 4 creative responses.
// ═══════════════════════════════════════════════════════════════════
import React from 'react';
import { CASES } from '@/data/cases';
import styles from './CaseStudies.module.scss';

const CaseStudies: React.FC = () => (
  <section className={styles.section}>
    <header className={styles.head}>
      <span className={styles.eyebrow}>מאיפה זה צומח, באמת</span>
      <h2 className={styles.title}>יצירתיות מתעוררת ממגבלה, לא ממרחב פתוח.</h2>
      <p className={styles.lede}>
        ארבעה מקרים שכמעט לא היו נולדים בלי המגבלה שלהם. <em>אותה לוגיקה</em>
        עובדת בכיתה — שלכם.
      </p>
    </header>

    <div className={styles.grid}>
      {CASES.map(c => (
        <article key={c.id} className={styles.case}>
          <header className={styles.caseHead}>
            <h3 className={styles.brand}>{c.brandHe}</h3>
            <span className={styles.year}>{c.yearStarted}</span>
          </header>
          <span className={styles.domain}>{c.domainHe}</span>

          <div className={styles.row}>
            <span className={styles.rowLabel}>המגבלה</span>
            <p className={styles.rowBody}>{c.constraintHe}</p>
          </div>
          <div className={styles.row}>
            <span className={styles.rowLabel}>התגובה</span>
            <p className={styles.rowBody}>{c.responseHe}</p>
          </div>
          <div className={styles.row}>
            <span className={styles.rowLabel}>התוצאה</span>
            <p className={styles.rowImpact}>{c.impactHe}</p>
          </div>

          {c.source && <p className={styles.source}>{c.source}</p>}
        </article>
      ))}
    </div>
  </section>
);

export default CaseStudies;