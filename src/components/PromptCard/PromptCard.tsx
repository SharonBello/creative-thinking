// ═══════════════════════════════════════════════════════════════════
// PromptCard — reusable 4-part prompt display.
// Used by Section 5 (Card 1), Section 6 (each method demo),
// Section 7 (personal lesson), Section 8 (printable deck).
// ═══════════════════════════════════════════════════════════════════
import React, { useState } from 'react';
import { TbCopy, TbCheck } from 'react-icons/tb';
import type { FourPartPrompt } from '@/data/methods';
import styles from './PromptCard.module.scss';

interface Props {
  prompt:     FourPartPrompt;
  nameHe?:    string;
  exampleHe?: string;
}

function joinPrompt(p: FourPartPrompt): string {
  return [
    'תפקיד:',  p.roleHe,        '',
    'הקשר:',   p.contextHe,     '',
    'משימה:',  p.taskHe,        '',
    'מגבלות:', p.constraintsHe,
  ].join('\n');
}

const PromptCard: React.FC<Props> = ({ prompt, nameHe, exampleHe }) => {
  const [copied, setCopied] = useState(false);

  const handleCopy = async () => {
    try {
      await navigator.clipboard.writeText(joinPrompt(prompt));
      setCopied(true);
      setTimeout(() => setCopied(false), 2000);
    } catch { /* no clipboard, ignore */ }
  };

  return (
    <article className={styles.card}>
      <header className={styles.head}>
        {nameHe && <h3 className={styles.name}>{nameHe}</h3>}
        <button
          type="button"
          className={styles.copy}
          onClick={handleCopy}
          aria-label="העתק את הפרומפט"
        >
          {copied ? (<><TbCheck aria-hidden /><span>הועתק</span></>)
                  : (<><TbCopy  aria-hidden /><span>העתק</span></>)}
        </button>
      </header>

      <dl className={styles.parts}>
        <div className={styles.part}>
          <dt>תפקיד</dt>
          <dd>{prompt.roleHe}</dd>
        </div>
        <div className={styles.part}>
          <dt>הקשר</dt>
          <dd>{prompt.contextHe}</dd>
        </div>
        <div className={styles.part}>
          <dt>משימה</dt>
          <dd>{prompt.taskHe}</dd>
        </div>
        <div className={styles.part}>
          <dt>מגבלות</dt>
          <dd>{prompt.constraintsHe}</dd>
        </div>
      </dl>

      {exampleHe && (
        <div className={styles.example}>
          <span className={styles.exampleLabel}>דוגמה ממולאת:</span>
          <p>{exampleHe}</p>
        </div>
      )}
    </article>
  );
};

export default PromptCard;