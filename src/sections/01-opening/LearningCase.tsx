// ═══════════════════════════════════════════════════════════════════
// LearningCase — three reasons creativity matters for student learning.
// Evidence-grounded, no AI-yet, builds the WHY before the HOW.
// ═══════════════════════════════════════════════════════════════════
import React from 'react';
import styles from './LearningCase.module.scss';

interface Reason {
  number: string;
  title: string;
  body: string;
  source: string;
}

const REASONS: Reason[] = [
  {
    number: '01',
    title: 'למידה עמוקה — לא רק שינון',
    body: 'תלמידים שצריכים להשתמש בידע בדרך יצירתית מפעילים את הקומה העליונה של פירמידת בלום: ניתוח, הערכה, יצירה. ידע משונן דועך תוך שבועות. ידע שהופעל ביצירתיות, נשאר.',
    source: "Bloom's revised taxonomy · Anderson & Krathwohl, 2001",
  },
  {
    number: '02',
    title: 'העברה — שימוש בידע מחוץ לכיתה',
    body: 'המנבא החזק ביותר לשאלה "האם התלמיד ישתמש במה שלמד גם מחוץ לבית הספר" — אינו ציון המבחן, אלא האם הוא נדרש להפעיל את הידע בדרכים יצירתיות כשלמד. זיכרון לא מועבר. יצירתיות כן.',
    source: 'Perkins & Salomon · transfer research',
  },
  {
    number: '03',
    title: 'המיומנות הראשונה לעשור הבא',
    body: 'דו"ח Future of Jobs של פורום העולמי, OECD, WEF — כולם מציבים חשיבה יצירתית ופתרון בעיות מורכבות בחמישייה הפותחת של מיומנויות הנדרשות לעובד של 2030. מיומנויות שגרתיות עוברות אוטומציה. יצירתיות לא.',
    source: 'WEF Future of Jobs 2025 · OECD Learning Compass 2030',
  },
];

const LearningCase: React.FC = () => (
  <section className={styles.section}>
    <header className={styles.head}>
      <span className={styles.eyebrow}>למה זה חשוב</span>
      <h2 className={styles.title}>שלוש סיבות פדגוגיות, בלי קשר ל-AI.</h2>
      <p className={styles.lede}>
        עוד לפני שנכניס כלי כלשהו לכיתה — שווה לעצור ולשאול מדוע יצירתיות
        אינה מותרות אלא <em>הכלי הלימודי החזק ביותר שיש לכם</em>.
      </p>
    </header>

    <ol className={styles.list}>
      {REASONS.map(r => (
        <li key={r.number} className={styles.item}>
          <span className={styles.num}>{r.number}</span>
          <div className={styles.text}>
            <h3 className={styles.itemTitle}>{r.title}</h3>
            <p className={styles.itemBody}>{r.body}</p>
            <p className={styles.itemSource}>{r.source}</p>
          </div>
        </li>
      ))}
    </ol>

    <aside className={styles.pull}>
      "תלמיד שזוכר עובדה ל-30 שנה הוא תלמיד שעשה איתה משהו יצירתי בפעם הראשונה
      שפגש בה."
    </aside>
  </section>
);

export default LearningCase;