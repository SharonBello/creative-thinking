// ═══════════════════════════════════════════════════════════════════
// PersonalNotes — open scratchpad for the teacher to capture what AI
// returned + how they'd actually run the lesson. localStorage-backed.
// ═══════════════════════════════════════════════════════════════════
import React, { useEffect, useState } from 'react';
import styles from './PersonalNotes.module.scss';

const KEY = 'binai.m05.personalNotes.v1';

function load(): string {
  try { return localStorage.getItem(KEY) ?? ''; } catch { return ''; }
}
function save(value: string): void {
  try { localStorage.setItem(KEY, value); } catch { /* noop */ }
}

const PersonalNotes: React.FC = () => {
  const [text, setText] = useState<string>(() => load());

  useEffect(() => { save(text); }, [text]);

  return (
    <section className={styles.section}>
      <span className={styles.eyebrow}>שלב 3 · רושמים את השיעור שיצא</span>
      <h3 className={styles.title}>
        כאן רושמים מה AI החזיר, מה לקחתי, ומה אני באמת אעשה בכיתה.
      </h3>
      <textarea
        className={styles.textarea}
        value={text}
        onChange={e => setText(e.target.value)}
        placeholder={'מה AI החזיר:\n— ...\n\nמה אקח לשיעור:\n— ...\n\nמה אעשה אחרת מהמומלץ:\n— ...'}
        rows={12}
      />
      <p className={styles.tip}>
        הטקסט נשמר אוטומטית. בחלק הסיום תוכלו להוריד אותו כ-PDF.
      </p>
    </section>
  );
};

export default PersonalNotes;