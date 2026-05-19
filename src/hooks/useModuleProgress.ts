// ═══════════════════════════════════════════════════════════════════
// useModuleProgress — localStorage-backed state for module progress.
// Tracks visited/completed per section + custom topic + chosen technique.
// ═══════════════════════════════════════════════════════════════════
import { useCallback, useEffect, useState } from 'react';
import { SECTIONS } from '@/data/sections';
import type {
  CustomTopic,
  ModuleProgress,
  SectionId,
  SectionProgress,
  TechniqueKey,
} from '@/types/module.types';

const STORAGE_KEY = 'binai.m05.progress.v1';
const TOPIC_KEY   = 'binai.m05.topic.v1';

function emptyProgress(): ModuleProgress {
  const sections: Record<SectionId, SectionProgress> = {} as Record<SectionId, SectionProgress>;
  SECTIONS.forEach(s => {
    sections[s.id] = { visited: false, completed: false, completedAt: null };
  });
  return { sections, customTopic: null, personalTechnique: null };
}

function loadProgress(): ModuleProgress {
  try {
    const raw = localStorage.getItem(STORAGE_KEY);
    if (!raw) return emptyProgress();
    const parsed = JSON.parse(raw) as Partial<ModuleProgress>;
    const base = emptyProgress();
    if (parsed.sections) {
      Object.keys(parsed.sections).forEach(k => {
        const id = k as SectionId;
        if (base.sections[id]) {
          base.sections[id] = { ...base.sections[id], ...parsed.sections![id] };
        }
      });
    }
    if (parsed.customTopic) base.customTopic = parsed.customTopic;
    if (parsed.personalTechnique) base.personalTechnique = parsed.personalTechnique;
    return base;
  } catch {
    return emptyProgress();
  }
}

function saveProgress(p: ModuleProgress): void {
  try { localStorage.setItem(STORAGE_KEY, JSON.stringify(p)); } catch { /* private mode */ }
}

function saveTopic(t: CustomTopic | null): void {
  try {
    if (t) localStorage.setItem(TOPIC_KEY, JSON.stringify(t));
    else localStorage.removeItem(TOPIC_KEY);
  } catch { /* noop */ }
}

export function useModuleProgress() {
  const [progress, setProgress] = useState<ModuleProgress>(loadProgress);

  useEffect(() => { saveProgress(progress); }, [progress]);

  const visit = useCallback((id: SectionId) => {
    setProgress(prev => {
      if (prev.sections[id]?.visited) return prev;
      return {
        ...prev,
        sections: {
          ...prev.sections,
          [id]: { ...prev.sections[id], visited: true },
        },
      };
    });
  }, []);

  const complete = useCallback((id: SectionId) => {
    setProgress(prev => ({
      ...prev,
      sections: {
        ...prev.sections,
        [id]: { ...prev.sections[id], visited: true, completed: true, completedAt: Date.now() },
      },
    }));
  }, []);

  const setCustomTopic = useCallback((topic: CustomTopic | null) => {
    setProgress(prev => ({ ...prev, customTopic: topic }));
    saveTopic(topic);
  }, []);

  const setPersonalTechnique = useCallback((tech: TechniqueKey | null) => {
    setProgress(prev => ({ ...prev, personalTechnique: tech }));
  }, []);

  const reset = useCallback(() => {
    const fresh = emptyProgress();
    setProgress(fresh);
    saveTopic(null);
  }, []);

  return {
    progress,
    visit,
    complete,
    setCustomTopic,
    setPersonalTechnique,
    reset,
  };
}