// ═══════════════════════════════════════════════════════════════════
// ClassPicker — minimal form to capture the teacher's class context.
// Persists via parent (useModuleProgress).
// ═══════════════════════════════════════════════════════════════════
import React from 'react';
import type { CustomTopic, AgeTier } from '@/types/module.types';
import styles from './ClassPicker.module.scss';

interface Props {
  value:    CustomTopic | null;
  onChange: (t: CustomTopic) => void;
}

const TIERS: { id: AgeTier; labelHe: string }[] = [
  { id: 'elementary', labelHe: 'יסודי · א-ו' },
  { id: 'middle',     labelHe: 'חט"ב · ז-ט' },
  { id: 'high',       labelHe: 'חט"ע · י-יב' },
];

const ClassPicker: React.FC<Props> = ({ value, onChange }) => {
  const v: CustomTopic = value ?? {
    subject: '', grade: '', ageTier: 'middle', topic: '', context: '',
  };

  const update = (patch: Partial<CustomTopic>) => onChange({ ...v, ...patch });

  return (
    <section className={styles.form}>
      <header className={styles.head}>
        <span className={styles.eyebrow}>איזה כיתה ואיזה נושא</span>
        <h2 className={styles.title}>על מה תעבדו בחלק האחרון?</h2>
      </header>

      <div className={styles.fields}>
        <label className={styles.field}>
          <span className={styles.label}>מקצוע <em>*</em></span>
          <input
            type="text"
            className={styles.input}
            value={v.subject}
            onChange={e => update({ subject: e.target.value })}
            placeholder="מתמטיקה, היסטוריה, תנ״ך..."
          />
        </label>

        <label className={styles.field}>
          <span className={styles.label}>שכבה <em>*</em></span>
          <input
            type="text"
            className={styles.input}
            value={v.grade}
            onChange={e => update({ grade: e.target.value })}
            placeholder="ה, ז, י..."
          />
        </label>

        <div className={[styles.field, styles.fieldWide].join(' ')}>
          <span className={styles.label}>שכבת גיל</span>
          <div className={styles.tiers}>
            {TIERS.map(t => (
              <button
                key={t.id}
                type="button"
                className={[styles.tier, v.ageTier === t.id && styles.tierActive].filter(Boolean).join(' ')}
                onClick={() => update({ ageTier: t.id })}
              >
                {t.labelHe}
              </button>
            ))}
          </div>
        </div>

        <label className={[styles.field, styles.fieldWide].join(' ')}>
          <span className={styles.label}>נושא ספציפי <em>*</em></span>
          <input
            type="text"
            className={styles.input}
            value={v.topic}
            onChange={e => update({ topic: e.target.value })}
            placeholder="מחזור המים, מלחמת ששת הימים, שייכות וקליקות..."
          />
        </label>

        <label className={[styles.field, styles.fieldWide].join(' ')}>
          <span className={styles.label}>הקשר נוסף <span className={styles.optional}>(לא חובה)</span></span>
          <textarea
            className={styles.textarea}
            rows={3}
            value={v.context ?? ''}
            onChange={e => update({ context: e.target.value })}
            placeholder="הכיתה ערה, התלמידים שונאים את הנושא, הורים מעורבים, איזשהו דבר שצריך לדעת..."
          />
        </label>
      </div>
    </section>
  );
};

export default ClassPicker;