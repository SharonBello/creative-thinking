// ═══════════════════════════════════════════════════════════════════
// Section 08 — סיכום (15 min)
// Closing summary + 4 downloadable lesson PDFs + 5-card printable deck
// + a commitment field. Marks module complete on submit.
// ═══════════════════════════════════════════════════════════════════
import React, { useEffect, useState } from 'react';
import SectionShell from '@/components/SectionShell/SectionShell';
import { useProgressCtx } from '@/components/ModuleShell/ModuleProgressContext';
import ClosingHero from './ClosingHero';
import LessonPDFSet from './LessonPDFSet';
import PromptCardsPrintable from './PromptCardsPrintable';
import styles from './index.module.scss';

const KEY_COMMIT = 'binai.m05.commit.v1';

function loadCommit(): string {
  try { return localStorage.getItem(KEY_COMMIT) ?? ''; } catch { return ''; }
}
function saveCommit(value: string): void {
  try { localStorage.setItem(KEY_COMMIT, value); } catch { /* noop */ }
}

const ClosingSection: React.FC = () => {
  const { complete } = useProgressCtx();
  const [commit, setCommit] = useState<string>(() => loadCommit());
  const [done, setDone] = useState(false);

  useEffect(() => { saveCommit(commit); }, [commit]);

  const handleComplete = () => {
    complete('closing');
    setDone(true);
  };

  return (
    <SectionShell id="closing">
      <ClosingHero />
      <LessonPDFSet />
      <PromptCardsPrintable />

      <section className={styles.commit}>
        <span className={styles.eyebrow}>צעד אחד · השבוע</span>
        <h2 className={styles.title}>
          מה אתם הולכים <em>באמת לנסות</em> השבוע?
        </h2>
        <p className={styles.lede}>
          לא מערכת שיעורים שלמה. דבר אחד. שיטה אחת על שיעור אחד. אם תכתבו את
          זה — סיכוי גבוה יותר שזה יקרה.
        </p>
        <textarea
          className={styles.textarea}
          value={commit}
          onChange={e => setCommit(e.target.value)}
          placeholder="ביום שלישי, בשיעור הראשון של כיתה ז, אנסה..."
          rows={4}
        />

        <button
          type="button"
          className={styles.completeBtn}
          onClick={handleComplete}
          disabled={done || commit.trim().length < 10}
        >
          {done ? 'סומן כהושלם ✓' : 'סיימתי את ההשתלמות'}
        </button>

        {done && (
          <p className={styles.thanks}>
            תודה שלמדתם איתנו. השיעורים, הכרטיסיות, וההתחייבות שלכם — שמורים אצלכם.
            חזרו לכאן בכל זמן.
          </p>
        )}
      </section>
    </SectionShell>
  );
};

export default ClosingSection;