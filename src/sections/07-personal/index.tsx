// ═══════════════════════════════════════════════════════════════════
// Section 07 — השיעור היצירתי שלכם (30 min)
// Teacher picks one method + applies it to their own class topic.
// Outputs: a prompt template they can copy + their lesson notes.
// ═══════════════════════════════════════════════════════════════════
import React from 'react';
import SectionShell from '@/components/SectionShell/SectionShell';
import { useProgressCtx } from '@/components/ModuleShell/ModuleProgressContext';
import MethodSelector from './MethodSelector';
import PersonalPromptBuilder from './PersonalPromptBuilder';
import PersonalNotes from './PersonalNotes';
import styles from './index.module.scss';

const PersonalSection: React.FC = () => {
  const { progress, setPersonalTechnique } = useProgressCtx();
  const tech  = progress.personalTechnique;
  const topic = progress.customTopic;

  return (
    <SectionShell id="personal">
      <header className={styles.head}>
        <span className={styles.eyebrow}>החלק שלכם · 30 דקות</span>
        <h2 className={styles.title}>השיעור היצירתי שלכם — לכיתה שלכם, על הנושא שבחרתם.</h2>
        <p className={styles.lede}>
          בחרו שיטה אחת מהשלוש. הפרומפט יבנה אוטומטית סביב הנושא שלכם.
          העתיקו אותו. הריצו אותו במודל AI שאתם משתמשים בו. רשמו פה מה יצא ומה
          אתם רוצים לעשות עם זה בכיתה.
        </p>
      </header>

      {!topic && (
        <p className={styles.warn}>
          חסר נושא לכיתה שלכם. חזרו לחלק 4 (הפסקה) ומלאו את הטופס.
        </p>
      )}

      <MethodSelector
        selected={tech}
        onSelect={setPersonalTechnique}
      />

      {tech && topic && (
        <>
          <PersonalPromptBuilder technique={tech} topic={topic} />
          <PersonalNotes />
        </>
      )}
    </SectionShell>
  );
};

export default PersonalSection;