// ═══════════════════════════════════════════════════════════════════
// PersonalPromptBuilder — composes a 4-part prompt for the teacher's
// own class using the selected method's template, substituting their
// subject/grade/topic/context where placeholders exist.
// ═══════════════════════════════════════════════════════════════════
import React from 'react';
import PromptCard from '@/components/PromptCard/PromptCard';
import { DEMO_BY_ID } from '@/data/methods';
import type { TechniqueKey, CustomTopic } from '@/types/module.types';
import styles from './PersonalPromptBuilder.module.scss';

interface Props {
  technique: TechniqueKey;
  topic:     CustomTopic;
}

// Method-specific personalization. Each builds a 4-part prompt that
// references the teacher's class instead of the demo's placeholder.
function buildPrompt(tech: TechniqueKey, t: CustomTopic) {
  const demo = DEMO_BY_ID[tech];
  const ctx = t.context ? ` ${t.context}` : '';

  if (tech === 'scamper') {
    return {
      ...demo.prompt,
      contextHe: `אני מורה ל${t.subject} בכיתה ${t.grade}. יש לי שיעור קיים בנושא "${t.topic}".${ctx} המבנה הנוכחי: [תיאור קצר של איך השיעור עובד היום].`,
      taskHe: `הפעילי SCAMPER על השיעור הזה. לכל אחת משבע האותיות — תני רעיון קונקרטי אחד לשינוי. בטבלה: אות, רעיון, השפעה צפויה על התלמידים.`,
    };
  }

  if (tech === 'design') {
    return {
      ...demo.prompt,
      contextHe: `אני מתכננת יחידה בנושא "${t.topic}" ל${t.subject}, כיתה ${t.grade}.${ctx} התלמיד הטיפוסי שבראש שלי: [תיאור קצר — סוציאלי, אקדמי, רגשי].`,
    };
  }

  // whatif
  return {
    ...demo.prompt,
    contextHe: `אני מורה ל${t.subject} בכיתה ${t.grade}. ההנחה שאני רוצה להפוך בנושא "${t.topic}": [נסחו את ההנחה — לדוגמה: "הילדים צריכים ללמוד את הנושא לפני שדנים בו"].${ctx}`,
  };
}

const PersonalPromptBuilder: React.FC<Props> = ({ technique, topic }) => {
  const demo   = DEMO_BY_ID[technique];
  const prompt = buildPrompt(technique, topic);

  return (
    <section className={styles.section}>
      <span className={styles.eyebrow}>שלב 2 · הפרומפט שלכם</span>
      <h3 className={styles.title}>
        {demo.nameHe} · עבור <em>"{topic.topic}"</em>, כיתה {topic.grade}
      </h3>
      <p className={styles.note}>
        השלימו את החלקים בסוגריים מרובעים, העתיקו את הפרומפט, הריצו אותו במודל
        שאתם משתמשים בו. המודל אנונימי כברירת מחדל — אבל אם הוספתם פרטים על
        תלמיד ספציפי, התייעצו לפני הריצה.
      </p>
      <PromptCard prompt={prompt} />
    </section>
  );
};

export default PersonalPromptBuilder;