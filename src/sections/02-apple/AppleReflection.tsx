// ═══════════════════════════════════════════════════════════════════
// AppleReflection — names what the exercise just demonstrated.
// Two opposite cognitive moves: divergent (the 20 associations) +
// convergent (picking ONE and building from it).
// ═══════════════════════════════════════════════════════════════════
import React from 'react';
import styles from './AppleReflection.module.scss';

const AppleReflection: React.FC = () => (
  <section className={styles.section}>
    <span className={styles.eyebrow}>מה עכשיו עשיתם, באמת</span>
    <h2 className={styles.title}>
      שני מצבי חשיבה הפוכים — בעשר דקות אחת.
    </h2>

    <div className={styles.split}>
      <div className={styles.col}>
        <h3 className={styles.colTitle}>
          <span className={styles.colNum}>01</span>
          חשיבה מסתעפת
        </h3>
        <p className={styles.colSub}>Divergent thinking</p>
        <p className={styles.colBody}>
          זה היה השלב הראשון. הרבה אופציות. בלי שיפוט. הראש פתוח. ככל שהרשימה
          ארוכה יותר, ככל שהיא <em>פראית יותר</em> — כך עלתה ההסתברות שתמצאו רעיון
          שאף מורה אחר בארץ לא יקבל.
        </p>
      </div>

      <div className={styles.col}>
        <h3 className={styles.colTitle}>
          <span className={styles.colNum}>02</span>
          חשיבה מתכנסת
        </h3>
        <p className={styles.colSub}>Convergent thinking</p>
        <p className={styles.colBody}>
          זה היה השלב השני והשלישי. בחירה אחת. בנייה ממנה. שיפוט חוזר. זה השלב
          שבו אנחנו, מורים, רגילים לחיות. אנחנו <em>מצוינים בו</em>. אבל בלי
          השלב הראשון, אין ממה לבחור.
        </p>
      </div>
    </div>

    <aside className={styles.takeaway}>
      <hr className={styles.rule} aria-hidden />
      <p>
        <strong>הטעות הנפוצה ביותר</strong> שאני רואה אצל מורים: לקפוץ ישר לבחירה.
        להציע פתרון אחד ולעבוד עליו. כשאתם לא יודעים מה לעשות בכיתה — זה כי
        קפצתם לבחירה מבלי לעבור קודם דרך הסתעפות. AI יקל בדיוק על השלב הזה.
        על להסתעף מהר. על להציע 50 רעיונות לפני שאתם בוחרים אחד.
      </p>
    </aside>
  </section>
);

export default AppleReflection;