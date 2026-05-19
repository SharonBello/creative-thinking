// ═══════════════════════════════════════════════════════════════════
// HookCard — the workshop's opening hook question.
// Speech-bubble style card with a giant question. Pop Studio aesthetic.
// ═══════════════════════════════════════════════════════════════════
import React from 'react';
import { TbBulb } from 'react-icons/tb';
import styles from './HookCard.module.scss';

const HookCard: React.FC = () => (
  <section className={styles.card}>
    <header className={styles.head}>
      <span className={styles.icon} aria-hidden><TbBulb /></span>
      <span className={styles.tag}>שאלת פתיחה</span>
    </header>

    <p className={styles.q}>
      אם יכולת להמציא משהו <span className={styles.qHighlight}>בלי מגבלות</span> — מה הוא היה?
    </p>

    <footer className={styles.foot}>
      <p className={styles.fact}>
        חשבו שתי דקות. כל מי שדיבר על Canva, TikTok או Waze — נחשו מה?{' '}
        <strong>שלושתם נולדו ממגבלה.</strong> Canva — אי אפשר לעצב בלי שמינית. TikTok —
        אינטרנט איטי בכפר בסין. Waze — פקקים בתל אביב.{' '}
        <em>היצירתיות הכי גדולה צומחת מהמגבלות, לא מהחופש.</em>
      </p>
    </footer>
  </section>
);

export default HookCard;