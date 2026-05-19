// ═══════════════════════════════════════════════════════════════════
// M05 · Type definitions
// ═══════════════════════════════════════════════════════════════════

export type SectionId =
  | 'opening'
  | 'apple'
  | 'roots'
  | 'break'
  | 'ai'
  | 'methods'
  | 'personal'
  | 'closing';

export interface SectionMeta {
  id:          SectionId;
  number:      number;
  path:        string;
  shortHe:     string;
  titleHe:     string;
  subtitleHe:  string;
  minutes:     number;
}

/** The 3 creative methods the workshop teaches */
export type TechniqueKey = 'scamper' | 'design' | 'whatif';

/** Age tier for the teacher's own class (used in Break section) */
export type AgeTier = 'elementary' | 'middle' | 'high';

export interface CustomTopic {
  subject:  string;
  grade:    string;
  ageTier:  AgeTier;
  topic:    string;
  context?: string;
}

export interface SectionProgress {
  visited:     boolean;
  completed:   boolean;
  completedAt: number | null;
}

export interface ModuleProgress {
  sections:           Record<SectionId, SectionProgress>;
  customTopic:        CustomTopic | null;
  personalTechnique:  TechniqueKey | null;
}