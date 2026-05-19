# ═══════════════════════════════════════════════════════════════════
# setup-m05-phase1.ps1
# M05 · Creative Thinking — Phase 1 scaffold + Section 1 (Opening)
#
# USAGE: create folder, place PS1 inside, then:
#   PS> cd C:\Users\sharo\OneDrive\מסמכים\sharon_workspace\creative-thinking
#   PS> Unblock-File .\setup-m05-phase1.ps1
#   PS> .\setup-m05-phase1.ps1
#   PS> npm install
#   PS> npm run dev
# ═══════════════════════════════════════════════════════════════════

$ErrorActionPreference = 'Stop'
$utf8NoBom = New-Object System.Text.UTF8Encoding($false)

function Write-Source {
    param([string]$Path, [string]$Body)
    $full = Join-Path -Path (Get-Location) -ChildPath $Path
    $dir  = Split-Path -Parent $full
    if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Path $dir -Force | Out-Null }
    [System.IO.File]::WriteAllText($full, $Body, $utf8NoBom)
    Write-Host "  + $Path" -ForegroundColor DarkGray
}

Write-Host ""
Write-Host "M05 Phase 1 - Pop Studio scaffold + Section 1" -ForegroundColor Magenta
Write-Host ""

Write-Source -Path '.gitignore' -Body @'
node_modules
dist
dist-ssr
*.local

.vscode/*
!.vscode/extensions.json
.idea
.DS_Store
*.log
'@
Write-Source -Path 'index.html' -Body @'
<!DOCTYPE html>
<html lang="he" dir="rtl">
  <head>
    <meta charset="UTF-8" />
    <link rel="icon" type="image/svg+xml" href="/favicon.svg" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta name="theme-color" content="#FCFBF8" />

    <!-- Heebo (Hebrew + Latin, light/regular/medium) + IBM Plex Mono (eyebrow tags) -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Heebo:wght@300;400;500&family=IBM+Plex+Mono:wght@400;500&display=swap"
      rel="stylesheet"
    />

    <title>חשיבה יצירתית בכיתה</title>
  </head>
  <body>
    <div id="root"></div>
    <script type="module" src="/src/main.tsx"></script>
  </body>
</html>
'@
Write-Source -Path 'package.json' -Body @'
{
  "name": "m05-creative-thinking",
  "private": true,
  "version": "0.1.0",
  "type": "module",
  "scripts": {
    "dev": "vite",
    "build": "tsc -b && vite build",
    "preview": "vite preview"
  },
  "dependencies": {
    "react": "^18.3.1",
    "react-dom": "^18.3.1",
    "react-icons": "^5.3.0",
    "react-router-dom": "^6.27.0"
  },
  "devDependencies": {
    "@types/node": "^22.7.0",
    "@types/react": "^18.3.12",
    "@types/react-dom": "^18.3.1",
    "@vitejs/plugin-react": "^4.3.3",
    "sass": "^1.80.0",
    "typescript": "^5.6.0",
    "vite": "^5.4.21"
  }
}
'@
Write-Source -Path 'public/favicon.svg' -Body @'
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32">
  <circle cx="16" cy="16" r="14" fill="#534AB7"/>
  <path d="M16 6 L18 14 L26 16 L18 18 L16 26 L14 18 L6 16 L14 14 Z" fill="#F4D55A"/>
  <circle cx="22" cy="10" r="2" fill="#FF6B9D"/>
</svg>
'@
Write-Source -Path 'src/App.tsx' -Body @'
import React from 'react';
import ModuleRouter from '@/router/ModuleRouter';

const App: React.FC = () => <ModuleRouter />;
export default App;
'@
Write-Source -Path 'src/components/ModuleShell/ModuleProgressContext.tsx' -Body @'
// ═══════════════════════════════════════════════════════════════════
// ModuleProgressContext — exposes useModuleProgress to all sections
// without prop drilling.
// ═══════════════════════════════════════════════════════════════════
import { createContext, useContext } from 'react';
import { useModuleProgress } from '@/hooks/useModuleProgress';

type Ctx = ReturnType<typeof useModuleProgress>;

export const ModuleProgressContext = createContext<Ctx | null>(null);

export function useProgressCtx() {
  const ctx = useContext(ModuleProgressContext);
  if (!ctx) throw new Error('useProgressCtx must be inside a ModuleProgressContext.Provider');
  return ctx;
}
'@
Write-Source -Path 'src/components/ModuleShell/ModuleShell.module.scss' -Body @'
.shell {
  min-height: 100vh;
  background: $bg-canvas;
}

.main {
  max-width: $content-base;
  margin: 0 auto;
  padding: $space-7 $space-5 $space-9;

  @include respond-to(md) {
    padding: $space-8 $space-6 $space-10;
  }
}
'@
Write-Source -Path 'src/components/ModuleShell/ModuleShell.tsx' -Body @'
// ═══════════════════════════════════════════════════════════════════
// ModuleShell — common wrapper around every section.
// Provides ModuleProgressContext + renders the ProgressBar + Outlet.
// ═══════════════════════════════════════════════════════════════════
import React from 'react';
import { Outlet } from 'react-router-dom';
import { useModuleProgress } from '@/hooks/useModuleProgress';
import { ModuleProgressContext } from './ModuleProgressContext';
import ProgressBar from '@/components/ProgressBar/ProgressBar';
import styles from './ModuleShell.module.scss';

const ModuleShell: React.FC = () => {
  const progress = useModuleProgress();

  return (
    <ModuleProgressContext.Provider value={progress}>
      <div className={styles.shell}>
        <ProgressBar />
        <div className={styles.main}>
          <Outlet />
        </div>
      </div>
    </ModuleProgressContext.Provider>
  );
};

export default ModuleShell;
'@
Write-Source -Path 'src/components/Placeholder/Placeholder.module.scss' -Body @'
.box {
  @include flex-col;
  align-items: center;
  gap: $space-3;
  padding: $space-7 $space-5;
  background: $accent-faint;
  border-radius: $radius-md;
  text-align: center;
}

.icon {
  @include flex-center;
  width: 36px; height: 36px;
  border-radius: 50%;
  background: $accent-soft;
  color: $accent;
  font-size: 18px;
}

.text {
  font-family: $font-body;
  font-weight: $weight-light;
  font-size: $text-md;
  color: $ink-mid;
  max-width: 320px;
  line-height: $leading-loose;
}
'@
Write-Source -Path 'src/components/Placeholder/Placeholder.tsx' -Body @'
// ═══════════════════════════════════════════════════════════════════
// Placeholder — used by ModuleRouter for sections that haven't been
// implemented yet. Goes away in Phase 2.
// ═══════════════════════════════════════════════════════════════════
import React from 'react';
import { TbBulb } from 'react-icons/tb';
import SectionShell from '@/components/SectionShell/SectionShell';
import type { SectionId } from '@/types/module.types';
import styles from './Placeholder.module.scss';

interface Props { id: SectionId; }

const Placeholder: React.FC<Props> = ({ id }) => (
  <SectionShell id={id}>
    <div className={styles.box}>
      <span className={styles.icon} aria-hidden><TbBulb /></span>
      <p className={styles.text}>החלק הזה ייבנה בשלב הבא של ההשתלמות.</p>
    </div>
  </SectionShell>
);

export default Placeholder;
'@
Write-Source -Path 'src/components/ProgressBar/ProgressBar.module.scss' -Body @'
// ───────────────────────────────────────────────────────────────
// Quiet Minimal progress bar
// A thin row of section numbers + a hairline rule beneath the
// active one. No pills, no badges, no colored chunks.
// ───────────────────────────────────────────────────────────────
.bar {
  position: sticky;
  top: 0;
  z-index: 40;
  background: rgba(252, 251, 248, 0.92);
  backdrop-filter: blur(8px);
  -webkit-backdrop-filter: blur(8px);
  border-bottom: $border-subtle;
  padding: $space-3 0;

  @media print { display: none; }
}

.steps {
  max-width: $content-wide;
  margin: 0 auto;
  padding: 0 $space-5;
  list-style: none;
  display: flex;
  align-items: center;
  gap: $space-1;
  overflow-x: auto;
  scrollbar-width: thin;
}

.stepItem { flex-shrink: 0; }

.step {
  @include focus-ring;
  display: inline-flex;
  align-items: baseline;
  gap: $space-2;
  padding: $space-2 $space-3;
  background: transparent;
  border: none;
  border-radius: $radius-sm;
  text-decoration: none;
  color: $ink-soft;
  font-family: $font-body;
  font-size: $text-sm;
  font-weight: $weight-regular;
  cursor: pointer;
  white-space: nowrap;
  transition: color $dur-fast $ease-out;

  &:hover:not(.stepLocked) {
    color: $ink;
  }
}

.stepNum {
  font-family: $font-mono;
  font-size: 11px;
  color: $ink-faint;
  letter-spacing: 0.04em;

  svg { font-size: 12px; }
}

.stepLabel { line-height: 1; }

// ── STATES ─────────────────────────────────────────────────────
.stepCurrent {
  color: $ink !important;
  font-weight: $weight-medium;
  position: relative;

  .stepNum { color: $accent; }

  &::after {
    content: '';
    position: absolute;
    inset-inline: $space-3;
    bottom: -$space-3;
    height: 1px;
    background: $accent;
  }
}

.stepCompleted:not(.stepCurrent) {
  color: $ink-mid;

  .stepNum {
    color: $success;
    svg { font-size: 12px; }
  }
}

.stepLocked {
  opacity: 0.45;
  cursor: not-allowed;
}
'@
Write-Source -Path 'src/components/ProgressBar/ProgressBar.tsx' -Body @'
// ═══════════════════════════════════════════════════════════════════
// ProgressBar — horizontal pill stepper showing all 8 sections.
// Sticky below the app bar. Click any visited/current step to jump.
// ═══════════════════════════════════════════════════════════════════
import React from 'react';
import { NavLink, useLocation } from 'react-router-dom';
import { TbCheck } from 'react-icons/tb';
import { SECTIONS, getSectionIndex } from '@/data/sections';
import { useProgressCtx } from '@/components/ModuleShell/ModuleProgressContext';
import type { SectionId } from '@/types/module.types';
import styles from './ProgressBar.module.scss';

const ProgressBar: React.FC = () => {
  const { progress } = useProgressCtx();
  const location = useLocation();
  const currentId = (location.pathname.replace(/^\//, '') || 'opening') as SectionId;
  const currentIdx = getSectionIndex(currentId);

  return (
    <nav className={styles.bar} aria-label="התקדמות בהשתלמות">
      <ol className={styles.steps}>
        {SECTIONS.map((s, i) => {
          const state = progress.sections[s.id];
          const isCurrent = s.id === currentId;
          const isCompleted = state?.completed === true;
          const isVisited = state?.visited === true;
          const isAccessible = i <= currentIdx || isVisited;

          return (
            <li key={s.id} className={styles.stepItem}>
              <NavLink
                to={s.path}
                className={[
                  styles.step,
                  isCurrent && styles.stepCurrent,
                  isCompleted && styles.stepCompleted,
                  !isAccessible && styles.stepLocked,
                ].filter(Boolean).join(' ')}
                aria-current={isCurrent ? 'step' : undefined}
                onClick={(e) => { if (!isAccessible) e.preventDefault(); }}
              >
                <span className={styles.stepNum} aria-hidden>
                  {isCompleted ? <TbCheck /> : s.number}
                </span>
                <span className={styles.stepLabel}>{s.shortHe}</span>
              </NavLink>
            </li>
          );
        })}
      </ol>
    </nav>
  );
};

export default ProgressBar;
'@
Write-Source -Path 'src/components/SectionShell/SectionShell.module.scss' -Body @'
// ───────────────────────────────────────────────────────────────
// SectionShell — editorial column.
// Section opens with a meta line + light-weight headline + lede.
// Body flows below in the same narrow column. Bottom: prev/next.
// ───────────────────────────────────────────────────────────────
.section {
  @include column-base;
  @include flex-col;
  gap: $space-7;
}

// ── HEAD ───────────────────────────────────────────────────────
.head {
  @include flex-col;
  gap: $space-3;
  padding-bottom: $space-5;
  border-bottom: $border-subtle;
}

.num {
  @include section-number;
}

.title {
  @include headline-hero;
}

.subtitle {
  @include lede;
  margin-top: $space-1;
  max-width: $content-narrow;
}

// ── BODY ───────────────────────────────────────────────────────
.body {
  @include flex-col;
  gap: $space-7;
}

// ── NAV ────────────────────────────────────────────────────────
.nav {
  @include flex-between;
  gap: $space-3;
  padding-top: $space-6;
  margin-top: $space-5;
  border-top: $border-subtle;

  @media print { display: none; }
}

.navSpacer { flex: 1; }

.btnPrev {
  @include btn-secondary;
  @include flex-start;
  gap: $space-2;

  svg { font-size: 16px; }
}

.btnNext {
  @include btn-primary;
  @include flex-start;
  gap: $space-2;

  svg { font-size: 16px; }

  &:disabled { background: $line-strong; border-color: $line-strong; }
}
'@
Write-Source -Path 'src/components/SectionShell/SectionShell.tsx' -Body @'
// ═══════════════════════════════════════════════════════════════════
// SectionShell — wraps every section. Renders:
//   - Title block (number, title, subtitle)
//   - Children
//   - Prev/Next nav
// Optional `canAdvance` prop gates the next button (e.g. break form).
// On mount, marks section as visited.
// ═══════════════════════════════════════════════════════════════════
import React, { useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { TbArrowRight, TbArrowLeft } from 'react-icons/tb';
import { SECTION_BY_ID, getNextSection, getPrevSection } from '@/data/sections';
import { useProgressCtx } from '@/components/ModuleShell/ModuleProgressContext';
import type { SectionId } from '@/types/module.types';
import styles from './SectionShell.module.scss';

interface Props {
  id: SectionId;
  children: React.ReactNode;
  canAdvance?: boolean;
}

const SectionShell: React.FC<Props> = ({ id, children, canAdvance = true }) => {
  const navigate = useNavigate();
  const { visit, complete } = useProgressCtx();
  const section = SECTION_BY_ID[id];
  const next = getNextSection(id);
  const prev = getPrevSection(id);

  useEffect(() => { visit(id); }, [id, visit]);

  const goNext = () => {
    if (!canAdvance) return;
    complete(id);
    if (next) navigate(next.path);
  };

  const goPrev = () => {
    if (prev) navigate(prev.path);
  };

  return (
    <article className={styles.section}>
      {/* TITLE BLOCK */}
      <header className={styles.head}>
        <span className={styles.num}>{section.number} / 8</span>
        <h1 className={styles.title}>{section.titleHe}</h1>
        <p className={styles.subtitle}>{section.subtitleHe}</p>
      </header>

      {/* CONTENT */}
      <div className={styles.body}>{children}</div>

      {/* NAV */}
      <nav className={styles.nav} aria-label="ניווט בין חלקים">
        {prev && (
          <button type="button" className={styles.btnPrev} onClick={goPrev}>
            <TbArrowRight aria-hidden />
            <span>{prev.shortHe}</span>
          </button>
        )}
        <div className={styles.navSpacer} />
        {next && (
          <button
            type="button"
            className={styles.btnNext}
            onClick={goNext}
            disabled={!canAdvance}
            title={!canAdvance ? 'יש להשלים את הפעולה הנדרשת בחלק הזה לפני המעבר הלאה' : undefined}
          >
            <span>{next.shortHe}</span>
            <TbArrowLeft aria-hidden />
          </button>
        )}
      </nav>
    </article>
  );
};

export default SectionShell;
'@
Write-Source -Path 'src/data/sections.ts' -Body @'
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
'@
Write-Source -Path 'src/hooks/useModuleProgress.ts' -Body @'
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
'@
Write-Source -Path 'src/main.tsx' -Body @'
import React from 'react';
import ReactDOM from 'react-dom/client';
import App from './App';
import './styles/global.scss';

// Build ID — bump suffix on each deploy to guarantee unique bundle hash
console.log('M05 build 2026-05-18-1');

ReactDOM.createRoot(document.getElementById('root')!).render(
  <React.StrictMode>
    <App />
  </React.StrictMode>,
);
'@
Write-Source -Path 'src/router/ModuleRouter.tsx' -Body @'
// ═══════════════════════════════════════════════════════════════════
// ModuleRouter — hash routing for iframe-safety.
// No AppLayout. Module sits directly inside the iframe via ModuleShell.
// Phase 1: only Section 1 (Opening) implemented. Others = Placeholder.
// ═══════════════════════════════════════════════════════════════════
import React, { lazy, Suspense } from 'react';
import { createHashRouter, Navigate, RouterProvider } from 'react-router-dom';
import ModuleShell from '@/components/ModuleShell/ModuleShell';
import Placeholder from '@/components/Placeholder/Placeholder';

const OpeningSection = lazy(() => import('@/sections/01-opening'));

const withSuspense = (el: React.ReactNode) => (
  <Suspense fallback={null}>{el}</Suspense>
);

const router = createHashRouter([
  {
    path: '/',
    element: <ModuleShell />,
    children: [
      { index: true,       element: <Navigate to="/opening" replace /> },
      { path: 'opening',   element: withSuspense(<OpeningSection />) },
      { path: 'apple',     element: <Placeholder id="apple"    /> },
      { path: 'roots',     element: <Placeholder id="roots"    /> },
      { path: 'break',     element: <Placeholder id="break"    /> },
      { path: 'ai',        element: <Placeholder id="ai"       /> },
      { path: 'methods',   element: <Placeholder id="methods"  /> },
      { path: 'personal',  element: <Placeholder id="personal" /> },
      { path: 'closing',   element: <Placeholder id="closing"  /> },
      { path: '*',         element: <Navigate to="/opening" replace /> },
    ],
  },
]);

const ModuleRouter: React.FC = () => <RouterProvider router={router} />;
export default ModuleRouter;
'@
Write-Source -Path 'src/sections/01-opening/LearningCase.module.scss' -Body @'
.section {
  @include flex-col;
  gap: $space-6;
}

// ── HEAD ───────────────────────────────────────────────────────
.head {
  @include flex-col;
  gap: $space-3;
}

.eyebrow {
  @include eyebrow;
}

.title {
  @include headline-section;
}

.lede {
  @include lede;
  max-width: $content-narrow;

  em {
    @include accent-underline;
    font-style: normal;
  }
}

// ── LIST OF REASONS ────────────────────────────────────────────
.list {
  list-style: none;
  margin: 0;
  padding: 0;
  @include flex-col;
  gap: $space-6;
}

.item {
  display: grid;
  grid-template-columns: 36px 1fr;
  gap: $space-4;
  padding-bottom: $space-5;
  border-bottom: $border-subtle;

  &:last-child { border-bottom: none; padding-bottom: 0; }
}

.num {
  font-family: $font-mono;
  font-size: $text-md;
  font-weight: $weight-regular;
  color: $accent;
  letter-spacing: 0.02em;
  padding-top: 2px;
}

.text {
  @include flex-col;
  gap: $space-2;
  min-width: 0;
}

.itemTitle {
  @include headline-subsection;
  font-weight: $weight-regular;
}

.itemBody {
  @include body-paragraph;
}

.itemSource {
  @include eyebrow;
  margin-top: $space-1;
  color: $ink-soft;
  font-size: 11px;
  text-transform: none;
  letter-spacing: 0.02em;
}

// ── PULL QUOTE ─────────────────────────────────────────────────
.pull {
  @include pull-quote;
  padding: $space-5 $space-6;
  border-inline-start: 2px solid $accent;
  background: $accent-faint;
  font-style: italic;
  margin-top: $space-3;
}
'@
Write-Source -Path 'src/sections/01-opening/LearningCase.tsx' -Body @'
// ═══════════════════════════════════════════════════════════════════
// LearningCase — three reasons creativity matters for student learning.
// Evidence-grounded, no AI-yet, builds the WHY before the HOW.
// ═══════════════════════════════════════════════════════════════════
import React from 'react';
import styles from './LearningCase.module.scss';

interface Reason {
  number: string;
  title: string;
  body: string;
  source: string;
}

const REASONS: Reason[] = [
  {
    number: '01',
    title: 'למידה עמוקה — לא רק שינון',
    body: 'תלמידים שצריכים להשתמש בידע בדרך יצירתית מפעילים את הקומה העליונה של פירמידת בלום: ניתוח, הערכה, יצירה. ידע משונן דועך תוך שבועות. ידע שהופעל ביצירתיות, נשאר.',
    source: "Bloom's revised taxonomy · Anderson & Krathwohl, 2001",
  },
  {
    number: '02',
    title: 'העברה — שימוש בידע מחוץ לכיתה',
    body: 'המנבא החזק ביותר לשאלה "האם התלמיד ישתמש במה שלמד גם מחוץ לבית הספר" — אינו ציון המבחן, אלא האם הוא נדרש להפעיל את הידע בדרכים יצירתיות כשלמד. זיכרון לא מועבר. יצירתיות כן.',
    source: 'Perkins & Salomon · transfer research',
  },
  {
    number: '03',
    title: 'המיומנות הראשונה לעשור הבא',
    body: 'דו"ח Future of Jobs של פורום העולמי, OECD, WEF — כולם מציבים חשיבה יצירתית ופתרון בעיות מורכבות בחמישייה הפותחת של מיומנויות הנדרשות לעובד של 2030. מיומנויות שגרתיות עוברות אוטומציה. יצירתיות לא.',
    source: 'WEF Future of Jobs 2025 · OECD Learning Compass 2030',
  },
];

const LearningCase: React.FC = () => (
  <section className={styles.section}>
    <header className={styles.head}>
      <span className={styles.eyebrow}>למה זה חשוב</span>
      <h2 className={styles.title}>שלוש סיבות פדגוגיות, בלי קשר ל-AI.</h2>
      <p className={styles.lede}>
        עוד לפני שנכניס כלי כלשהו לכיתה — שווה לעצור ולשאול מדוע יצירתיות
        אינה מותרות אלא <em>הכלי הלימודי החזק ביותר שיש לכם</em>.
      </p>
    </header>

    <ol className={styles.list}>
      {REASONS.map(r => (
        <li key={r.number} className={styles.item}>
          <span className={styles.num}>{r.number}</span>
          <div className={styles.text}>
            <h3 className={styles.itemTitle}>{r.title}</h3>
            <p className={styles.itemBody}>{r.body}</p>
            <p className={styles.itemSource}>{r.source}</p>
          </div>
        </li>
      ))}
    </ol>

    <aside className={styles.pull}>
      "תלמיד שזוכר עובדה ל-30 שנה הוא תלמיד שעשה איתה משהו יצירתי בפעם הראשונה
      שפגש בה."
    </aside>
  </section>
);

export default LearningCase;
'@
Write-Source -Path 'src/sections/01-opening/PersonalReframe.module.scss' -Body @'
.section {
  @include flex-col;
  gap: $space-5;
}

// ── HEAD ───────────────────────────────────────────────────────
.head {
  @include flex-col;
  gap: $space-3;
}

.eyebrow {
  @include eyebrow;
}

.title {
  @include headline-section;

  em {
    @include accent-underline;
    font-style: normal;
  }
}

.lede {
  @include lede;
  max-width: $content-narrow;
}

// ── MOMENTS LIST ───────────────────────────────────────────────
.moments {
  list-style: none;
  margin: 0;
  padding: 0;
  @include flex-col;
  gap: $space-3;
}

.moment {
  display: grid;
  grid-template-columns: 8px 1fr;
  gap: $space-4;
  align-items: baseline;
  padding: $space-3 0;
  font-family: $font-body;
  font-size: $text-base;
  line-height: $leading-loose;
  color: $ink-mid;
  font-weight: $weight-light;
}

.dot {
  width: 4px;
  height: 4px;
  margin-top: 10px;
  border-radius: 50%;
  background: $accent;
}

// ── BRIDGE ─────────────────────────────────────────────────────
.bridge {
  @include flex-col;
  gap: $space-3;
  margin-top: $space-4;
  padding-top: $space-5;
}

.rule {
  @include micro-rule(48px);
}

.bridgeText {
  @include body-paragraph;
  max-width: $content-narrow;

  strong {
    color: $ink;
    font-weight: $weight-medium;
  }
}

.bridgeNext {
  font-family: $font-display;
  font-size: $text-md;
  font-weight: $weight-light;
  color: $ink;
  font-style: italic;
}
'@
Write-Source -Path 'src/sections/01-opening/PersonalReframe.tsx' -Body @'
// ═══════════════════════════════════════════════════════════════════
// PersonalReframe — second beat of Section 1.
// Reframes "creativity" from artistic talent to a skill the teacher
// already exercises every week. Names everyday classroom moves as
// the creative thinking they actually are.
// ═══════════════════════════════════════════════════════════════════
import React from 'react';
import styles from './PersonalReframe.module.scss';

const MOMENTS: string[] = [
  'מתי תכננתם פתאום שיעור בלי דף עבודה כי הילדים נראו עייפים?',
  'מתי הסברתם פעם שלישית — אחרת — לתלמיד שעדיין לא הבין, ומצאתם בדיוק את האנלוגיה שלו?',
  'מתי תיווכתם בין הורה כועס לבין הצוות ומצאתם מילים שאף אחד לא חיכה להן?',
  'מתי המצאתם "משחק" שעבד טוב יותר מהמערך המקורי?',
];

const PersonalReframe: React.FC = () => (
  <section className={styles.section}>
    <header className={styles.head}>
      <span className={styles.eyebrow}>אתם כבר עושים את זה</span>
      <h2 className={styles.title}>
        יצירתיות היא לא <em>כישרון</em>. היא מיומנות שתרגלתם השבוע.
      </h2>
      <p className={styles.lede}>
        רוב המורים והמורות שאני פוגשת חוששים שהם "לא יצירתיים". זה כמעט תמיד
        לא נכון. הנה ארבעה רגעים שכנראה היו לכם בחודש האחרון:
      </p>
    </header>

    <ul className={styles.moments}>
      {MOMENTS.map((m, i) => (
        <li key={i} className={styles.moment}>
          <span className={styles.dot} aria-hidden />
          <span>{m}</span>
        </li>
      ))}
    </ul>

    <div className={styles.bridge}>
      <hr className={styles.rule} aria-hidden />
      <p className={styles.bridgeText}>
        כל אלה — חשיבה יצירתית. בשעתיים וחצי הבאות ניתן לזה שם, נראה איפה היא
        עובדת הכי טוב, ורק אז — נכניס AI כמכפיל. <strong>לא במקומכם. איתכם.</strong>
      </p>
      <p className={styles.bridgeNext}>
        בחלק הבא נתחיל לתרגל. מתחילים בתפוח.
      </p>
    </div>
  </section>
);

export default PersonalReframe;
'@
Write-Source -Path 'src/sections/01-opening/index.tsx' -Body @'
// ═══════════════════════════════════════════════════════════════════
// Section 01 — יצירתיות בכיתה (25 min)
//
// Pedagogical arc:
//   1. Why creativity matters for STUDENT learning (evidence)
//   2. The teacher already does this — reframe
//
// AI is not mentioned in this section. It enters in Section 5.
// ═══════════════════════════════════════════════════════════════════
import React from 'react';
import SectionShell from '@/components/SectionShell/SectionShell';
import LearningCase from './LearningCase';
import PersonalReframe from './PersonalReframe';

const OpeningSection: React.FC = () => (
  <SectionShell id="opening">
    <LearningCase />
    <PersonalReframe />
  </SectionShell>
);

export default OpeningSection;
'@
Write-Source -Path 'src/styles/_mixins.scss' -Body @'
// ═══════════════════════════════════════════════════════════════════
// M05 · Quiet Minimal Mixins
// Few, deliberate. No "pop" tricks.
// ═══════════════════════════════════════════════════════════════════
@use "tokens" as *;

// ── LAYOUT HELPERS ─────────────────────────────────────────────
@mixin flex-row       { display: flex; flex-direction: row; }
@mixin flex-col       { display: flex; flex-direction: column; }
@mixin flex-center    { display: flex; align-items: center; justify-content: center; }
@mixin flex-start     { display: flex; align-items: center; justify-content: flex-start; }
@mixin flex-between   { display: flex; align-items: center; justify-content: space-between; }
@mixin flex-end       { display: flex; align-items: center; justify-content: flex-end; }

// ── CONTENT COLUMN ─────────────────────────────────────────────
// The editorial column. Narrow and centered.
@mixin column-narrow {
  max-width: $content-narrow;
  margin-inline: auto;
}

@mixin column-base {
  max-width: $content-base;
  margin-inline: auto;
}

@mixin column-wide {
  max-width: $content-wide;
  margin-inline: auto;
}

// ── TYPOGRAPHY ─────────────────────────────────────────────────
// Eyebrow: tiny monospace, very muted, letter-spaced.
@mixin eyebrow {
  font-family: $font-mono;
  font-size: $text-xs;
  font-weight: $weight-regular;
  letter-spacing: 0.14em;
  text-transform: uppercase;
  color: $ink-faint;
}

// Section number — meta label
@mixin section-number {
  font-family: $font-mono;
  font-size: $text-sm;
  color: $ink-soft;
  letter-spacing: 0.04em;
}

// Headline — large, light weight
@mixin headline-hero {
  font-family: $font-display;
  font-weight: $weight-light;
  font-size: $text-3xl;
  line-height: $leading-tight;
  letter-spacing: -0.02em;
  color: $ink;

  @media (min-width: $bp-md) { font-size: $text-4xl; }
}

@mixin headline-section {
  font-family: $font-display;
  font-weight: $weight-light;
  font-size: $text-2xl;
  line-height: $leading-tight;
  letter-spacing: -0.015em;
  color: $ink;

  @media (min-width: $bp-md) { font-size: $text-3xl; }
}

@mixin headline-subsection {
  font-family: $font-display;
  font-weight: $weight-regular;
  font-size: $text-xl;
  line-height: $leading-tight;
  color: $ink;
}

// Body paragraph
@mixin body-paragraph {
  font-family: $font-body;
  font-weight: $weight-regular;
  font-size: $text-base;
  line-height: $leading-loose;
  color: $ink-mid;
}

// Lede (intro paragraph under a headline)
@mixin lede {
  font-family: $font-body;
  font-weight: $weight-light;
  font-size: $text-md;
  line-height: $leading-loose;
  color: $ink-mid;
}

// Pull quote (the workshop's voice)
@mixin pull-quote {
  font-family: $font-display;
  font-weight: $weight-light;
  font-size: $text-lg;
  line-height: $leading-body;
  color: $ink;
}

// ── ACCENT TREATMENTS ──────────────────────────────────────────
// Single underline accent — terracotta, just under one phrase.
@mixin accent-underline {
  color: $accent;
  border-bottom: 1px solid $accent;
  padding-bottom: 1px;
}

// Tiny terracotta rule — divider with breathing room.
@mixin micro-rule($w: 32px) {
  width: $w;
  height: 1px;
  background: $accent;
  border: none;
  margin: 0;
}

// ── BUTTONS ────────────────────────────────────────────────────
// Primary — solid navy, used for the main forward action only.
@mixin btn-primary {
  font-family: $font-body;
  font-weight: $weight-regular;
  font-size: $text-sm;
  padding: 10px 28px;
  background: $ink;
  color: $bg-canvas;
  border: 1px solid $ink;
  border-radius: $radius-pill;
  cursor: pointer;
  transition: background $dur-fast $ease-out;

  &:hover:not(:disabled) { background: lighten($ink, 6%); }
  &:disabled { opacity: 0.4; cursor: not-allowed; }
}

// Secondary — outline, used for back / cancel.
@mixin btn-secondary {
  font-family: $font-body;
  font-weight: $weight-regular;
  font-size: $text-sm;
  padding: 10px 24px;
  background: transparent;
  color: $ink-mid;
  border: 1px solid $line-strong;
  border-radius: $radius-pill;
  cursor: pointer;
  transition: all $dur-fast $ease-out;

  &:hover { border-color: $ink; color: $ink; }
  &:disabled { opacity: 0.4; cursor: not-allowed; }
}

// Quiet — text-only link
@mixin btn-link {
  background: none;
  border: none;
  padding: 0;
  font-family: $font-body;
  font-size: $text-sm;
  color: $accent;
  text-decoration: underline;
  cursor: pointer;

  &:hover { color: $accent-deep; }
}

// ── INPUTS ─────────────────────────────────────────────────────
@mixin field-base {
  font-family: $font-body;
  font-size: $text-base;
  line-height: $leading-body;
  color: $ink;
  background: $bg-surface;
  border: 1px solid $line;
  border-radius: $radius-md;
  padding: 10px 14px;
  transition: border-color $dur-fast $ease-out;

  &::placeholder { color: $ink-soft; font-weight: $weight-light; }

  &:focus {
    outline: none;
    border-color: $ink;
  }
}

// ── FOCUS ──────────────────────────────────────────────────────
@mixin focus-ring {
  &:focus-visible {
    outline: 2px solid $accent;
    outline-offset: 2px;
    border-radius: $radius-sm;
  }
}

// ── RESPONSIVE ─────────────────────────────────────────────────
@mixin respond-to($bp) {
  @if $bp == sm { @media (min-width: $bp-sm) { @content; } }
  @else if $bp == md { @media (min-width: $bp-md) { @content; } }
  @else if $bp == lg { @media (min-width: $bp-lg) { @content; } }
  @else if $bp == xl { @media (min-width: $bp-xl) { @content; } }
}
'@
Write-Source -Path 'src/styles/_tokens.scss' -Body @'
// ═══════════════════════════════════════════════════════════════════
// M05 · Quiet Minimal Design Tokens
// Almost monochrome. Restrained. Typography-led.
// One accent (terracotta) used sparingly. No pop colors.
// ═══════════════════════════════════════════════════════════════════

// ── PALETTE ────────────────────────────────────────────────────
$bg-canvas:        #FCFBF8;
$bg-surface:       #FFFFFF;
$bg-subtle:        #F4F0E8;
$bg-deep:          #2A2E3D;

$ink:              #1A2332;
$ink-mid:          #4A4F5C;
$ink-soft:         #6E727F;
$ink-faint:        #999482;

$line:             #E5E0D2;
$line-soft:        rgba(26, 35, 50, 0.08);
$line-strong:      rgba(26, 35, 50, 0.18);

$accent:           #B45A3C;
$accent-deep:      #8A3F26;
$accent-soft:      rgba(180, 90, 60, 0.10);
$accent-faint:     rgba(180, 90, 60, 0.04);

$success:          #4A8F3F;
$success-soft:     rgba(74, 143, 63, 0.08);

// ── TYPOGRAPHY ─────────────────────────────────────────────────
$font-display:     'Heebo', system-ui, sans-serif;
$font-body:        'Heebo', system-ui, sans-serif;
$font-mono:        'IBM Plex Mono', ui-monospace, monospace;

$weight-light:     300;
$weight-regular:   400;
$weight-medium:    500;

$text-xs:          12px;
$text-sm:          14px;
$text-base:        15px;
$text-md:          17px;
$text-lg:          20px;
$text-xl:          26px;
$text-2xl:         32px;
$text-3xl:         42px;
$text-4xl:         56px;

$leading-tight:    1.15;
$leading-body:     1.6;
$leading-loose:    1.75;

// ── SPACING ────────────────────────────────────────────────────
$space-0:          0;
$space-1:          4px;
$space-2:          8px;
$space-3:          12px;
$space-4:          16px;
$space-5:          24px;
$space-6:          32px;
$space-7:          48px;
$space-8:          64px;
$space-9:          96px;
$space-10:         128px;

// ── SHAPES ─────────────────────────────────────────────────────
$radius-sm:        4px;
$radius-md:        6px;
$radius-lg:        8px;
$radius-pill:      999px;

// ── BORDERS ────────────────────────────────────────────────────
$border-hair:      1px solid $line;
$border-subtle:    0.5px solid $line;

// ── SHADOWS ────────────────────────────────────────────────────
$shadow-none:      none;
$shadow-hairline:  0 1px 0 rgba(26, 35, 50, 0.04);
$shadow-card:      0 1px 2px rgba(26, 35, 50, 0.04);

// ── MOTION ─────────────────────────────────────────────────────
$dur-fast:         0.15s;
$dur-base:         0.25s;
$dur-slow:         0.45s;

$ease-out:         cubic-bezier(0.22, 1, 0.36, 1);
$ease-in-out:      cubic-bezier(0.65, 0, 0.35, 1);

// ── BREAKPOINTS ────────────────────────────────────────────────
$bp-sm:            480px;
$bp-md:            768px;
$bp-lg:            1024px;
$bp-xl:            1280px;

// ── LAYOUT WIDTHS ──────────────────────────────────────────────
// Narrow editorial column. Workshop book reads narrow.
$content-narrow:   620px;
$content-base:     720px;
$content-wide:     880px;
'@
Write-Source -Path 'src/styles/global.scss' -Body @'
// ═══════════════════════════════════════════════════════════════════
// M05 · Global Styles
// Quiet Minimal · embedded in BinAI iframe (no own header)
// ═══════════════════════════════════════════════════════════════════
@use "tokens" as *;
@use "mixins" as *;

*, *::before, *::after { box-sizing: border-box; }

html { -webkit-text-size-adjust: 100%; }

body {
  margin: 0;
  font-family: $font-body;
  font-size: $text-base;
  font-weight: $weight-regular;
  line-height: $leading-body;
  color: $ink-mid;
  background: $bg-canvas;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-rendering: optimizeLegibility;
}

a { color: $accent; text-decoration: underline; text-underline-offset: 2px; }
a:hover { color: $accent-deep; }

h1, h2, h3, h4, h5, h6 { margin: 0; font-weight: $weight-light; color: $ink; }
p { margin: 0; }
ul, ol { margin: 0; padding-inline-start: 1.25em; }
button { font-family: inherit; }
input, textarea, select { font-family: inherit; }

::selection { background: $accent-soft; color: $ink; }

#root { min-height: 100vh; display: flex; flex-direction: column; }

// ═══════════════════════════════════════════════════════════════
// PRINT — Section 8 uses a React portal mounted to <body>.
// In print we hide #root entirely and show only the portal.
// ═══════════════════════════════════════════════════════════════
@page { size: A4; margin: 20mm 18mm; }

.m05-print-host { display: none; }

@media print {
  body {
    background: white !important;
    color: black !important;
    margin: 0 !important;
    padding: 0 !important;
    -webkit-print-color-adjust: exact;
    print-color-adjust: exact;
  }
  #root { display: none !important; }
  .m05-print-host {
    display: block !important;
    margin: 0;
    padding: 0;
    width: 100%;
  }
  .m05-print-field {
    page-break-inside: avoid;
    break-inside: avoid;
  }
  a[href]::after { content: '' !important; }
}
'@
Write-Source -Path 'src/types/module.types.ts' -Body @'
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
'@
Write-Source -Path 'tsconfig.app.json' -Body @'
{
  "compilerOptions": {
    "target": "ES2022",
    "useDefineForClassFields": true,
    "lib": ["ES2022", "DOM", "DOM.Iterable"],
    "module": "ESNext",
    "skipLibCheck": true,
    "moduleResolution": "bundler",
    "allowImportingTsExtensions": true,
    "isolatedModules": true,
    "moduleDetection": "force",
    "noEmit": true,
    "jsx": "react-jsx",
    "strict": true,
    "noUnusedLocals": true,
    "noUnusedParameters": true,
    "noFallthroughCasesInSwitch": true,
    "noUncheckedSideEffectImports": true,
    "baseUrl": ".",
    "paths": { "@/*": ["src/*"] }
  },
  "include": ["src"]
}
'@
Write-Source -Path 'tsconfig.json' -Body @'
{
  "files": [],
  "references": [
    { "path": "./tsconfig.app.json" },
    { "path": "./tsconfig.node.json" }
  ]
}
'@
Write-Source -Path 'tsconfig.node.json' -Body @'
{
  "compilerOptions": {
    "target": "ES2022",
    "lib": ["ES2023"],
    "module": "ESNext",
    "skipLibCheck": true,
    "moduleResolution": "bundler",
    "allowImportingTsExtensions": true,
    "isolatedModules": true,
    "moduleDetection": "force",
    "noEmit": true,
    "types": ["node"],
    "strict": true,
    "noUnusedLocals": true,
    "noUnusedParameters": true
  },
  "include": ["vite.config.ts"]
}
'@
Write-Source -Path 'vite.config.ts' -Body @'
import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';
import path from 'node:path';

// https://vite.dev/config/
export default defineConfig({
  plugins: [react()],
  resolve: {
    alias: { '@': path.resolve(__dirname, './src') },
  },
  css: {
    preprocessorOptions: {
      scss: {
        api: 'modern',
        additionalData: `@use "@/styles/_tokens" as *; @use "@/styles/_mixins" as *;`,
      },
    },
  },
});
'@

Write-Host ""
Write-Host "Done. Run: npm install, then npm run dev" -ForegroundColor Green
Write-Host ""
