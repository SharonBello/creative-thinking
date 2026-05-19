// ═══════════════════════════════════════════════════════════════════
// MethodDemo — renders one complete method demonstration:
//   - Method name + when-to-use
//   - The challenge that prompted it
//   - The 4-part prompt (via PromptCard)
//   - The AI output rows
//   - The lesson plan (via LessonPlanCard)
//   - The teacher's reflection on what worked
// ═══════════════════════════════════════════════════════════════════
import React from 'react';
import type { MethodDemo as MethodDemoData } from '@/data/methods';
import PromptCard from '@/components/PromptCard/PromptCard';
import LessonPlanCard from '@/components/LessonPlanCard/LessonPlanCard';
import styles from './MethodDemo.module.scss';

interface Props {
  demo:  MethodDemoData;
  index: number;
}

const MethodDemo: React.FC<Props> = ({ demo, index }) => (
  <article className={styles.demo}>
    <header className={styles.head}>
      <span className={styles.num}>0{index}</span>
      <div className={styles.headBody}>
        <h2 className={styles.name}>{demo.nameHe}</h2>
        <p className={styles.tagline}>{demo.taglineHe}</p>
      </div>
    </header>

    <div className={styles.whenBox}>
      <span className={styles.whenLabel}>מתי להשתמש</span>
      <p className={styles.whenBody}>{demo.whenToUseHe}</p>
    </div>

    {/* CHALLENGE */}
    <section className={styles.beat}>
      <span className={styles.beatTag}>האתגר שלי</span>
      <p className={styles.challenge}>{demo.challengeHe}</p>
      <span className={styles.context}>{demo.gradeHe} · {demo.subjectHe}</span>
    </section>

    {/* PROMPT */}
    <section className={styles.beat}>
      <span className={styles.beatTag}>הפרומפט ששלחתי</span>
      <PromptCard prompt={demo.prompt} />
    </section>

    {/* OUTPUT */}
    <section className={styles.beat}>
      <span className={styles.beatTag}>מה ש-AI החזיר</span>
      <ul className={styles.outputs}>
        {demo.outputs.map((o, i) => (
          <li key={i} className={styles.output}>
            <span className={styles.outputLabel}>{o.labelHe}</span>
            <p className={styles.outputValue}>{o.valueHe}</p>
          </li>
        ))}
      </ul>
    </section>

    {/* LESSON */}
    <section className={styles.beat}>
      <span className={styles.beatTag}>השיעור שיצא</span>
      <LessonPlanCard
        titleHe={`${demo.nameHe} · ${demo.subjectHe}`}
        blocks={demo.lesson}
        classHe={demo.gradeHe}
      />
    </section>

    {/* REFLECTION */}
    <aside className={styles.reflection}>
      <span className={styles.reflectionLabel}>הרהור אחרי</span>
      <p>{demo.reflectionHe}</p>
    </aside>
  </article>
);

export default MethodDemo;