// ═══════════════════════════════════════════════════════════════════
// Section 04 — הפסקה + בחירת הכיתה (15 min)
// Short break + form to capture which class/topic the teacher will
// work on for the rest of the workshop. Gates Next button.
// ═══════════════════════════════════════════════════════════════════
import React, { useState } from 'react';
import SectionShell from '@/components/SectionShell/SectionShell';
import { useProgressCtx } from '@/components/ModuleShell/ModuleProgressContext';
import type { CustomTopic } from '@/types/module.types';
import ClassPicker from './ClassPicker';
import styles from './index.module.scss';

const BreakSection: React.FC = () => {
  const { progress, setCustomTopic } = useProgressCtx();
  const [topic, setTopic] = useState<CustomTopic | null>(progress.customTopic);

  const isValid = !!topic
    && topic.subject.trim() !== ''
    && topic.grade.trim() !== ''
    && topic.topic.trim() !== '';

  const handleChange = (next: CustomTopic) => {
    setTopic(next);
    setCustomTopic(next);
  };

  return (
    <SectionShell id="break" canAdvance={isValid}>
      <section className={styles.breakBanner}>
        <span className={styles.eyebrow}>הפסקה</span>
        <h2 className={styles.bannerTitle}>קחו 10 דקות.</h2>
        <p className={styles.bannerBody}>
          אוויר. מים. ארוחה קלה. כשתחזרו — נמלא יחד את הטופס למטה. הוא יקבע
          על איזו כיתה ועל איזה נושא תעבדו בחלק האחרון של ההשתלמות.
        </p>
      </section>

      <ClassPicker value={topic} onChange={handleChange} />

      {!isValid && (
        <p className={styles.gateHint}>
          ⌗ אי אפשר להתקדם בלי למלא את הטופס. שלושה שדות חובה: מקצוע, שכבה, ונושא.
        </p>
      )}
    </SectionShell>
  );
};

export default BreakSection;