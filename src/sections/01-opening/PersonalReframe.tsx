// ═══════════════════════════════════════════════════════════════════
// PersonalReframe — second beat of Section 1.
// Reframes "creativity" from artistic talent to a skill the teacher
// already exercises every week. Names everyday classroom moves as
// the creative thinking they actually are.
// ═══════════════════════════════════════════════════════════════════
import React from 'react';
import styles from './PersonalReframe.module.scss';

const MOMENTS: string[] = [
  'מתי תכננתם פתאום שיעור בלי דף עבודה כי הילדים נראו עייפים?',
  'מתי הסברתם פעם שלישית — אחרת — לתלמיד שעדיין לא הבין, ומצאתם בדיוק את האנלוגיה שלו?',
  'מתי תיווכתם בין הורה כועס לבין הצוות ומצאתם מילים שאף אחד לא חיכה להן?',
  'מתי המצאתם "משחק" שעבד טוב יותר מהמערך המקורי?',
];

const PersonalReframe: React.FC = () => (
  <section className={styles.section}>
    <header className={styles.head}>
      <span className={styles.eyebrow}>אתם כבר עושים את זה</span>
      <h2 className={styles.title}>
        יצירתיות היא לא <em>כישרון</em>. היא מיומנות שתרגלתם השבוע.
      </h2>
      <p className={styles.lede}>
        רוב המורים והמורות שאני פוגשת חוששים שהם "לא יצירתיים". זה כמעט תמיד
        לא נכון. הנה ארבעה רגעים שכנראה היו לכם בחודש האחרון:
      </p>
    </header>

    <ul className={styles.moments}>
      {MOMENTS.map((m, i) => (
        <li key={i} className={styles.moment}>
          <span className={styles.dot} aria-hidden />
          <span>{m}</span>
        </li>
      ))}
    </ul>

    <div className={styles.bridge}>
      <hr className={styles.rule} aria-hidden />
      <p className={styles.bridgeText}>
        כל אלה — חשיבה יצירתית. בשעתיים וחצי הבאות ניתן לזה שם, נראה איפה היא
        עובדת הכי טוב, ורק אז — נכניס AI כמכפיל. <strong>לא במקומכם. איתכם.</strong>
      </p>
      <p className={styles.bridgeNext}>
        בחלק הבא נתחיל לתרגל. מתחילים בתפוח.
      </p>
    </div>
  </section>
);

export default PersonalReframe;