import React from 'react';
import styles from './MethodsIntro.module.scss';

const MethodsIntro: React.FC = () => (
  <section className={styles.section}>
    <span className={styles.eyebrow}>שלוש שיטות לכיתה</span>
    <h2 className={styles.title}>שיטות חשיבה יצירתית — שלוש שעובדות.</h2>
    <p className={styles.lede}>
      יש עשרות שיטות חשיבה יצירתית. את שלוש השיטות הבאות בחרנו כי הן <em>פותרות
      בעיות שונות</em> ויחד נותנות לכם כיסוי רחב. לכל אחת — אתגר כיתתי אמיתי,
      הפרומפט שמתאים לה, התוצאה ש-AI החזיר, ושיעור מוכן.
    </p>
    <ul className={styles.previewList}>
      <li><strong>SCAMPER</strong> · כשרוצים לרענן שיעור קיים.</li>
      <li><strong>Design Thinking · אמפתיה</strong> · כשרוצים להבין את התלמיד לפני שמתכננים.</li>
      <li><strong>"מה אם..."</strong> · כשרוצים לערער על משהו שתמיד היה.</li>
    </ul>
  </section>
);

export default MethodsIntro;