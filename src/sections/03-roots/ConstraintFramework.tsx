// ═══════════════════════════════════════════════════════════════════
// ConstraintFramework — names the underlying process:
//   Constraint → Diverge → Converge → Test
// 4 stages displayed as a horizontal flow with light typography.
// ═══════════════════════════════════════════════════════════════════
import React from 'react';
import styles from './ConstraintFramework.module.scss';

interface Stage {
  number: string;
  titleHe: string;
  bodyHe: string;
}

const STAGES: Stage[] = [
  {
    number: '01',
    titleHe: 'מגבלה',
    bodyHe: 'מה אי אפשר? מה אסור? מה שינו? המגבלה היא נקודת ההתחלה — לא בעיה שצריך לפתור, אלא הפרמטר שמולו מעצבים.',
  },
  {
    number: '02',
    titleHe: 'הסתעפות',
    bodyHe: 'כמה אופציות שאפשר. מהר. בלי שיפוט. ארוך לפני שצר. רחב לפני שעמוק. שלב התפוח-וה-20-אסוציאציות.',
  },
  {
    number: '03',
    titleHe: 'התכנסות',
    bodyHe: 'בחירה אחת מתוך הרבות. לפי מה? לפי המגבלה. מה שעובד הכי טוב מולה — נשאר.',
  },
  {
    number: '04',
    titleHe: 'בדיקה',
    bodyHe: 'מנסים. רואים. כושלים מהר. למה כושלים? המידע הזה הופך לכניסה למחזור הבא — לא לסיום הרעיון.',
  },
];

const ConstraintFramework: React.FC = () => (
  <section className={styles.section}>
    <span className={styles.eyebrow}>התהליך שמתחת לכולם</span>
    <h2 className={styles.title}>ארבעה שלבים. אותם ארבעה, כל פעם.</h2>

    <ol className={styles.flow}>
      {STAGES.map((s, i) => (
        <li key={s.number} className={styles.stage}>
          <div className={styles.stageHead}>
            <span className={styles.num}>{s.number}</span>
            <h3 className={styles.stageTitle}>{s.titleHe}</h3>
          </div>
          <p className={styles.stageBody}>{s.bodyHe}</p>
          {i < STAGES.length - 1 && <span className={styles.arrow} aria-hidden>←</span>}
        </li>
      ))}
    </ol>

    <p className={styles.coda}>
      בכיתה: <strong>"אין לי זמן" / "אין לי תקציב" / "התלמידים לא מקשיבים" —</strong>
      הן לא בעיות. הן המגבלות שמולן השיעור הבא שלכם יצמח.
    </p>
  </section>
);

export default ConstraintFramework;