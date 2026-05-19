import React from 'react';
import styles from './AppleIntro.module.scss';

const AppleIntro: React.FC = () => (
  <section className={styles.section}>
    <span className={styles.eyebrow}>תרגיל חי · ⌗ 1</span>
    <h2 className={styles.title}>
      התרגיל הקלאסי של סטנפורד d.school. מתפוח — אל כסא חדש.
    </h2>
    <p className={styles.lede}>
      שלושה שלבים. כל שלב מתקתק כשעון. <em>אל תחשבו טוב מדי.</em> אם תחשבו טוב,
      תקבלו בדיוק את התשובה שכל מורה אחר בארץ נותן. אם תחשבו <em>מהר</em>, תקבלו
      את שלכם.
    </p>

    <ol className={styles.steps}>
      <li><span>שלב 1</span> 20 אסוציאציות לתפוח, בשתי דקות. בלי לסנן.</li>
      <li><span>שלב 2</span> תבחרו אחת. הכי מפתיעה. הכי שלכם.</li>
      <li><span>שלב 3</span> תכננו כסא בהשראת האסוציאציה הזאת.</li>
    </ol>
  </section>
);

export default AppleIntro;