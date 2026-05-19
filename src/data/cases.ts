// ═══════════════════════════════════════════════════════════════════
// M05 · Case studies
// Four moments where a constraint forced — and rewarded — creative
// thinking. Used in Section 3.
// ═══════════════════════════════════════════════════════════════════

export interface CaseStudy {
  id:           string;
  brandHe:      string;
  yearStarted:  number;
  domainHe:     string;
  constraintHe: string;
  responseHe:   string;
  impactHe:     string;
  source?:      string;
}

export const CASES: CaseStudy[] = [
  {
    id: 'canva',
    brandHe: 'Canva',
    yearStarted: 2013,
    domainHe: 'עיצוב גרפי',
    constraintHe: 'מלאני פרקינס, מורה צעירה מאוסטרליה, לא ידעה להפעיל Photoshop ורצתה להוציא ספר מחזור מעוצב לבית הספר שלה.',
    responseHe: 'במקום ללמוד Photoshop, היא בנתה כלי שבו כל אחד יכול לעצב — בלי לדעת Photoshop. עיצוב בגרירה, תבניות, ספריית תמונות.',
    impactHe: 'מעל 220 מיליון משתמשים פעילים. שווי החברה: 26 מיליארד דולר.',
    source: 'Canva · 2024',
  },
  {
    id: 'musically',
    brandHe: 'Musical.ly · הבסיס ל-TikTok',
    yearStarted: 2014,
    domainHe: 'וידאו חברתי',
    constraintHe: 'משתמשים בערים קטנות בסין עם רוחב פס איטי לא הצליחו להעלות סרטונים ארוכים, ופלטפורמות כמו Vine היו מחוץ להישג ידם.',
    responseHe: 'המייסדים בנו אפליקציה שמטרתה היא דווקא סרטונים של 15 שניות. מה שהיה מגבלה, הפך לפורמט. מי שלא יכול היה לפרסם — הפך לכוכב.',
    impactHe: 'נמכרה ב-2017 בכמיליארד דולר. השלד שעליו נבנה TikTok.',
    source: 'ByteDance · 2017',
  },
  {
    id: 'waze',
    brandHe: 'Waze',
    yearStarted: 2008,
    domainHe: 'ניווט',
    constraintHe: 'מפות סטטיות לא ידעו על פקקים בזמן אמת. בתל אביב, פקק חדש כל יום.',
    responseHe: 'במקום מפה מעודכנת — קהילה. כל נהג הוא חיישן. הפקק "מספר את עצמו". המגבלה (אין נתונים מרכזיים) הפכה לעקרון העיצוב.',
    impactHe: 'נרכשה על ידי גוגל ב-2013 בכ-966 מיליון דולר. שינתה את Google Maps שאנחנו מכירים היום.',
    source: 'Google · 2013',
  },
  {
    id: 'mri-kids',
    brandHe: 'GE · MRI Adventure Series',
    yearStarted: 2012,
    domainHe: 'דימות רפואי',
    constraintHe: 'ילדים פחדו ממכשיר ה-MRI כל כך ש-80% נדרשו להרדמה כללית — סיכון רפואי מיותר ועלות גבוהה.',
    responseHe: 'דאג דייץ, מהנדס ב-GE שהבן שלו עבר MRI טראומטי, חזר עם רעיון אחר: לצבוע את המכשיר כספינת חלל. הילד "יוצא להרפתקה", לא נכנס למכונה.',
    impactHe: 'שיעור ההרדמה ירד ל-10%. שביעות הרצון של הילדים עלתה ב-90%. שוחזר מאז במאות בתי חולים.',
    source: 'IDEO · Stanford d.school',
  },
];

export const CASE_BY_ID: Record<string, CaseStudy> = CASES.reduce(
  (acc, c) => { acc[c.id] = c; return acc; },
  {} as Record<string, CaseStudy>,
);