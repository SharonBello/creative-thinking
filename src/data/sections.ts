// ═══════════════════════════════════════════════════════════════════
// M05 · Section flow
//
// First three sections build the TEACHER's own creative thinking,
// with no AI involved. AI is introduced in Section 5 only after the
// teacher has personally experienced creative thinking — explicitly
// framed as "creativity amplifier", not replacement.
// ═══════════════════════════════════════════════════════════════════
import type { SectionId, SectionMeta } from '@/types/module.types';

export const SECTIONS: SectionMeta[] = [
  {
    id: 'opening',
    number: 1,
    path: '/opening',
    shortHe: 'פתיחה',
    titleHe: 'יצירתיות בכיתה',
    subtitleHe: 'למה זה חשוב לתלמידים — ולמה אתם כבר עושים את זה',
    minutes: 25,
  },
  {
    id: 'apple',
    number: 2,
    path: '/apple',
    shortHe: 'תפוח → כסא',
    titleHe: 'חשיבה מסתעפת',
    subtitleHe: 'תרגיל חי — מתפוח, דרך 20 אסוציאציות, אל כסא חדש',
    minutes: 20,
  },
  {
    id: 'roots',
    number: 3,
    path: '/roots',
    shortHe: 'מאיפה צומחת',
    titleHe: 'מאיפה צומחת יצירתיות?',
    subtitleHe: 'מגבלות כדלק. ארבעה מקרים שתשנו את הדרך בה אתם מסתכלים על הכיתה',
    minutes: 15,
  },
  {
    id: 'break',
    number: 4,
    path: '/break',
    shortHe: 'הפסקה',
    titleHe: 'הפסקה · בחירת הכיתה שלכם',
    subtitleHe: 'אוויר, מים, ואז — מי אתם, ועל מה תעבדו בחלק האחרון',
    minutes: 15,
  },
  {
    id: 'ai',
    number: 5,
    path: '/ai',
    shortHe: 'AI נכנס',
    titleHe: 'AI נכנס למשחק',
    subtitleHe: 'לא במקומכם. איתכם. חמש כרטיסיות פרומפט — הקיט הבסיסי',
    minutes: 25,
  },
  {
    id: 'methods',
    number: 6,
    path: '/methods',
    shortHe: 'שלוש שיטות',
    titleHe: 'שלוש שיטות עבודה',
    subtitleHe: 'SCAMPER · Design Thinking · "מה אם...". כל אחת על אתגר כיתתי אמיתי',
    minutes: 35,
  },
  {
    id: 'personal',
    number: 7,
    path: '/personal',
    shortHe: 'השיעור שלכם',
    titleHe: 'השיעור היצירתי שלכם',
    subtitleHe: 'שיטה אחת. הכיתה שלכם. שיעור מוכן',
    minutes: 30,
  },
  {
    id: 'closing',
    number: 8,
    path: '/closing',
    shortHe: 'סיכום',
    titleHe: 'סיכום',
    subtitleHe: 'ארבעה שיעורים + חמש כרטיסיות. הקיט שלכם',
    minutes: 15,
  },
];

export const SECTION_BY_ID: Record<SectionId, SectionMeta> = SECTIONS.reduce(
  (acc, s) => { acc[s.id] = s; return acc; },
  {} as Record<SectionId, SectionMeta>,
);

export function getSectionIndex(id: SectionId): number {
  return SECTIONS.findIndex(s => s.id === id);
}

export function getNextSection(id: SectionId): SectionMeta | null {
  const i = getSectionIndex(id);
  return i >= 0 && i < SECTIONS.length - 1 ? SECTIONS[i + 1] : null;
}

export function getPrevSection(id: SectionId): SectionMeta | null {
  const i = getSectionIndex(id);
  return i > 0 ? SECTIONS[i - 1] : null;
}

export const TOTAL_MINUTES = SECTIONS.reduce((sum, s) => sum + s.minutes, 0);