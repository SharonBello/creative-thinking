// ═══════════════════════════════════════════════════════════════════
// LessonPDFSet — 4 printable lesson plans:
//   - 3 demo lessons (SCAMPER · Design Thinking · What If)
//   - 1 personal lesson (built from teacher's customTopic + technique
//     + personalNotes textarea contents)
//
// Print isolation: each print renders ONE lesson via React portal
// mounted to document.body with class "m05-print-host". global.scss
// rules hide #root and show .m05-print-host only during print.
// ═══════════════════════════════════════════════════════════════════
import React, { useEffect, useMemo, useState } from 'react';
import { createPortal } from 'react-dom';
import { TbDownload } from 'react-icons/tb';
import LessonPlanCard from '@/components/LessonPlanCard/LessonPlanCard';
import { useProgressCtx } from '@/components/ModuleShell/ModuleProgressContext';
import { ALL_DEMOS, DEMO_BY_ID } from '@/data/methods';
import type { LessonBlock } from '@/data/methods';
import styles from './LessonPDFSet.module.scss';

const NOTES_KEY = 'binai.m05.personalNotes.v1';

interface PrintLesson {
  id:       string;
  titleHe:  string;
  classHe?: string;
  topicHe?: string;
  blocks:   LessonBlock[];
  notesHe?: string;
}

function loadNotes(): string {
  try { return localStorage.getItem(NOTES_KEY) ?? ''; } catch { return ''; }
}

const LessonPDFSet: React.FC = () => {
  const { progress } = useProgressCtx();
  const [printing, setPrinting] = useState<string | null>(null);
  const [host, setHost] = useState<HTMLElement | null>(null);

  // Ensure the print-host element exists on body before portaling into it
  useEffect(() => {
    let el = document.querySelector<HTMLElement>('.m05-print-host');
    if (!el) {
      el = document.createElement('div');
      el.className = 'm05-print-host';
      document.body.appendChild(el);
    }
    setHost(el);
  }, []);

  // Build the lessons list (3 demo + maybe 1 personal)
  const lessons: PrintLesson[] = useMemo(() => {
    const list: PrintLesson[] = ALL_DEMOS.map(d => ({
      id:      `demo-${d.id}`,
      titleHe: `${d.nameHe} · ${d.subjectHe}`,
      classHe: d.gradeHe,
      topicHe: d.challengeHe.split('.')[0],
      blocks:  d.lesson,
    }));

    if (progress.customTopic && progress.personalTechnique) {
      const demo = DEMO_BY_ID[progress.personalTechnique];
      const notes = loadNotes();
      list.push({
        id:      'personal',
        titleHe: `השיעור שלי · ${demo.nameHe}`,
        classHe: `${progress.customTopic.subject} · כיתה ${progress.customTopic.grade}`,
        topicHe: progress.customTopic.topic,
        // Use the demo's lesson as scaffold the teacher will adapt; notes appended below
        blocks:  demo.lesson,
        notesHe: notes,
      });
    }
    return list;
  }, [progress.customTopic, progress.personalTechnique]);

  const handlePrint = (id: string) => {
    setPrinting(id);
    requestAnimationFrame(() => {
      window.print();
      // Clear shortly after the print dialog opens — printing already snapshotted DOM
      setTimeout(() => setPrinting(null), 200);
    });
  };

  const currentLesson = lessons.find(l => l.id === printing);

  return (
    <section className={styles.section}>
      <span className={styles.eyebrow}>הקיט · {lessons.length} שיעורים</span>
      <h2 className={styles.title}>שיעורים מוכנים לעבודה — להוריד כ-PDF.</h2>
      <p className={styles.note}>
        כל לחיצה פותחת תיבת הדפסה של הדפדפן. <strong>בחרו "שמור כ-PDF"</strong>
        כיעד. ההדפסה מבודדת — רק השיעור הנבחר ייצא, לא הממשק.
      </p>

      <ul className={styles.grid}>
        {lessons.map(l => (
          <li key={l.id} className={styles.card}>
            <h3 className={styles.cardTitle}>{l.titleHe}</h3>
            <p className={styles.cardMeta}>
              {l.classHe}{l.topicHe ? ` · ${l.topicHe}` : ''}
            </p>
            <button
              type="button"
              className={styles.btn}
              onClick={() => handlePrint(l.id)}
            >
              <TbDownload aria-hidden /> שמרו כ-PDF
            </button>
          </li>
        ))}
        {!progress.customTopic && (
          <li className={[styles.card, styles.cardEmpty].join(' ')}>
            <h3 className={styles.cardTitleEmpty}>השיעור האישי שלכם</h3>
            <p className={styles.cardMetaEmpty}>
              כדי לקבל גם את השיעור האישי כ-PDF — מלאו את טופס הכיתה בחלק 4.
            </p>
          </li>
        )}
      </ul>

      {/* Portal: only renders into body during a print action */}
      {host && currentLesson && createPortal(
        <div className={styles.printPage}>
          <header className={styles.printHeader}>
            <span className={styles.printTag}>BinAI · חשיבה יצירתית</span>
            <h1 className={styles.printTitle}>{currentLesson.titleHe}</h1>
            {currentLesson.classHe && (
              <p className={styles.printMeta}>{currentLesson.classHe}{currentLesson.topicHe ? ` · ${currentLesson.topicHe}` : ''}</p>
            )}
          </header>

          <LessonPlanCard
            titleHe="מערך השיעור"
            blocks={currentLesson.blocks}
            variant="print"
          />

          {currentLesson.notesHe && currentLesson.notesHe.trim().length > 0 && (
            <section className={styles.printNotes}>
              <h2 className={styles.printNotesTitle}>הערות שלי</h2>
              <pre className={styles.printNotesBody}>{currentLesson.notesHe}</pre>
            </section>
          )}

          <footer className={styles.printFooter}>
            BinAI · שיעור 5 · חשיבה יצירתית עם AI
          </footer>
        </div>,
        host,
      )}
    </section>
  );
};

export default LessonPDFSet;