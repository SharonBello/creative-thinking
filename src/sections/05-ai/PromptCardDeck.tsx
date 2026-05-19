// ═══════════════════════════════════════════════════════════════════
// PromptCardDeck — introduces the 5-card prompt toolkit.
//   - List of 5 with name + tagline + when-to-use
//   - Card 1 ("First Pass") shown fully via PromptCard component
// ═══════════════════════════════════════════════════════════════════
import React from 'react';
import { PROMPT_CARDS, PROMPT_CARD_BY_ID } from '@/data/promptCards';
import PromptCard from '@/components/PromptCard/PromptCard';
import styles from './PromptCardDeck.module.scss';

const PromptCardDeck: React.FC = () => {
  const firstPass = PROMPT_CARD_BY_ID['firstpass'];

  return (
    <section className={styles.section}>
      <header className={styles.head}>
        <span className={styles.eyebrow}>הקיט · חמש כרטיסיות</span>
        <h2 className={styles.title}>חמש כרטיסיות פרומפט. הקיט הבסיסי.</h2>
        <p className={styles.lede}>
          כל כרטיסייה — מבנה של פרומפט אחד שמכוסה לסיטואציה ספציפית.
          ארבע מהן יעלו בחלק הבא דרך השיטות. את הראשונה — נצלול לתוכה עכשיו.
        </p>
      </header>

      <ul className={styles.deck}>
        {PROMPT_CARDS.map(c => (
          <li key={c.id} className={styles.deckItem}>
            <span className={styles.deckNum}>{c.number}</span>
            <div className={styles.deckBody}>
              <h3 className={styles.deckName}>{c.nameHe}</h3>
              <p className={styles.deckTag}>{c.taglineHe}</p>
              <p className={styles.deckWhen}>{c.whenToUseHe}</p>
            </div>
          </li>
        ))}
      </ul>

      <div className={styles.full}>
        <span className={styles.fullEyebrow}>כרטיסייה 01 · במלואה</span>
        <PromptCard
          prompt={{
            roleHe: firstPass.roleHe,
            contextHe: firstPass.contextHe,
            taskHe: firstPass.taskHe,
            constraintsHe: firstPass.constraintsHe,
          }}
          nameHe={firstPass.nameHe}
          exampleHe={firstPass.exampleHe}
        />
      </div>

      <p className={styles.bridge}>
        בחלק הבא — שלוש מתוך ארבע הכרטיסיות הנותרות, כל אחת על אתגר כיתתי
        אמיתי. כדי להבין איך הן עובדות בשטח.
      </p>
    </section>
  );
};

export default PromptCardDeck;