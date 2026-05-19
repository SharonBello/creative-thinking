// ═══════════════════════════════════════════════════════════════════
// AIReframe — explicit two-column contrast:
//   What AI WON'T know (you stay irreplaceable)
//   What AI WILL help with (the leverage)
// ═══════════════════════════════════════════════════════════════════
import React from 'react';
import styles from './AIReframe.module.scss';

const CANNOT = [
  'את שמות התלמידים שלכם, את הסיפור של כל אחד',
  'איזה משפט עבד בשבוע שעבר ואיזה צרם',
  'את האנרגיה של כיתה ערה שעה אחרי הצהריים',
  'מי קם הבוקר בלי ארוחת בוקר ולמה',
  'את ההומור הספציפי שלכם, את מה שמרגיש כמוכם',
];

const CAN = [
  'לייצר 50 וריאציות של פתיחה לשיעור בשתי דקות',
  'להציע אנלוגיות שלא היו עולות לכם בראש',
  'להחזיק כמה רעיונות במקביל בלי לאבד אף אחד',
  'לעזור לכם לראות את השיעור מנקודת המבט של תלמיד',
  'לתכנן "תכנית כישלון" — איך זה יקרוס, ומה לעשות אז',
];

const AIReframe: React.FC = () => (
  <section className={styles.section}>
    <header className={styles.head}>
      <span className={styles.eyebrow}>עכשיו AI נכנס</span>
      <h2 className={styles.title}>לא <em>במקומכם</em>. <em>איתכם</em>.</h2>
      <p className={styles.lede}>
        בארבעת החלקים הקודמים תרגלתם חשיבה יצירתית — לבד. עכשיו נראה איך כלי
        אחד יכול להכפיל את היכולת הזאת. אבל לפני שמתחילים, חשוב להיות ברור על
        מה הוא <em>לא</em> ידע ומה הוא <em>כן</em>.
      </p>
    </header>

    <div className={styles.split}>
      <div className={styles.col}>
        <span className={styles.colTag}>AI לא ידע</span>
        <ul className={styles.list}>
          {CANNOT.map((t, i) => <li key={i}>{t}</li>)}
        </ul>
        <p className={styles.colCoda}>
          לכן <strong>אתם</strong> חייבים להישאר בלולאה. הוא לא יחליף אתכם —
          הוא יציע, ואתם תבחרו.
        </p>
      </div>

      <div className={styles.divider} aria-hidden />

      <div className={styles.col}>
        <span className={[styles.colTag, styles.colTagAccent].join(' ')}>AI יעזור עם</span>
        <ul className={styles.list}>
          {CAN.map((t, i) => <li key={i}>{t}</li>)}
        </ul>
        <p className={styles.colCoda}>
          <strong>זה החלק שעוצר אתכם עכשיו</strong> כשהדף לבן. בדיוק שם הוא
          הכי שימושי.
        </p>
      </div>
    </div>
  </section>
);

export default AIReframe;