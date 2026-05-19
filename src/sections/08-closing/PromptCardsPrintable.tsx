// ═══════════════════════════════════════════════════════════════════
// PromptCardsPrintable — prints all 5 prompt cards as a single deck.
// One page per card via CSS page-break-after.
// ═══════════════════════════════════════════════════════════════════
import React, { useEffect, useState } from 'react';
import { createPortal } from 'react-dom';
import { TbDownload } from 'react-icons/tb';
import { PROMPT_CARDS } from '@/data/promptCards';
import styles from './PromptCardsPrintable.module.scss';

const PromptCardsPrintable: React.FC = () => {
  const [printing, setPrinting] = useState(false);
  const [host, setHost] = useState<HTMLElement | null>(null);

  useEffect(() => {
    let el = document.querySelector<HTMLElement>('.m05-print-host');
    if (!el) {
      el = document.createElement('div');
      el.className = 'm05-print-host';
      document.body.appendChild(el);
    }
    setHost(el);
  }, []);

  const handlePrint = () => {
    setPrinting(true);
    requestAnimationFrame(() => {
      window.print();
      setTimeout(() => setPrinting(false), 200);
    });
  };

  return (
    <section className={styles.section}>
      <span className={styles.eyebrow}>הקיט · 5 כרטיסיות פרומפט</span>
      <h2 className={styles.title}>הדק כרטיסיות הפרומפט — שיהיה תלוי במסך שלכם.</h2>
      <p className={styles.note}>
        חבילה אחת. 5 דפים. כדאי להדפיס דו-צדדי על דף A4 ולגזור — או לשמור כ-PDF
        ולחפש בו לפי מצב.
      </p>

      <button
        type="button"
        className={styles.btn}
        onClick={handlePrint}
      >
        <TbDownload aria-hidden /> שמרו את כל הכרטיסיות כ-PDF
      </button>

      {host && printing && createPortal(
        <div className={styles.deck}>
          {PROMPT_CARDS.map((c, i) => (
            <article
              key={c.id}
              className={styles.card}
              style={i < PROMPT_CARDS.length - 1 ? { pageBreakAfter: 'always' } : undefined}
            >
              <header className={styles.cardHeader}>
                <span className={styles.cardNum}>{c.number}</span>
                <span className={styles.cardKit}>BinAI · קיט יצירתיות</span>
              </header>

              <h1 className={styles.cardName}>{c.nameHe}</h1>
              <p className={styles.cardTag}>{c.taglineHe}</p>

              <section className={styles.cardWhen}>
                <h2>מתי</h2>
                <p>{c.whenToUseHe}</p>
              </section>

              <section className={styles.cardPrompt}>
                <h2>הפרומפט · 4 חלקים</h2>

                <div className={styles.partRow}>
                  <span className={styles.partLabel}>תפקיד</span>
                  <p>{c.roleHe}</p>
                </div>
                <div className={styles.partRow}>
                  <span className={styles.partLabel}>הקשר</span>
                  <p>{c.contextHe}</p>
                </div>
                <div className={styles.partRow}>
                  <span className={styles.partLabel}>משימה</span>
                  <p>{c.taskHe}</p>
                </div>
                <div className={styles.partRow}>
                  <span className={styles.partLabel}>מגבלות</span>
                  <p>{c.constraintsHe}</p>
                </div>
              </section>

              <section className={styles.cardExample}>
                <h2>דוגמה</h2>
                <p>{c.exampleHe}</p>
              </section>

              <footer className={styles.cardFooter}>
                BinAI · שיעור 5 · חשיבה יצירתית עם AI · כרטיסייה {c.number} מתוך 05
              </footer>
            </article>
          ))}
        </div>,
        host,
      )}
    </section>
  );
};

export default PromptCardsPrintable;