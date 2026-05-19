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
    <meta name="theme-color" content="#534AB7" />

    <!-- Fonts: Bagel Fat One (Pop display, Hebrew) + Rubik (rounded sans, Hebrew) + Assistant (body, Hebrew) + IBM Plex Mono (tags) -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Assistant:wght@400;500;700&family=Bagel+Fat+One&family=IBM+Plex+Mono:wght@400;500;700&family=Rubik:wght@400;500;700;900&display=swap"
      rel="stylesheet"
    />

    <title>M05 · חשיבה יצירתית</title>
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
Write-Source -Path 'src/components/AppLayout/AppLayout.module.scss' -Body @'
.app {
  min-height: 100vh;
  background: $purple-mist;
}

.bar {
  background: $purple;
  color: $paper-white;
  position: sticky;
  top: 0;
  z-index: 50;
  box-shadow: 0 2px 0 0 $purple-dark, 0 4px 12px rgba(83, 74, 183, 0.15);
}

.barInner {
  max-width: 1080px;
  margin: 0 auto;
  padding: $space-3 $space-5;
  @include flex-between;
  gap: $space-4;

  @include respond-to(md) { padding: $space-4 $space-6; }
}

.brand {
  @include flex-start;
  gap: $space-2;
  font-family: $font-secondary;
  font-weight: $weight-black;
  font-size: $text-lg;
  color: $paper-white;
  letter-spacing: -0.01em;
}

.brandIcon {
  @include flex-center;
  width: 32px; height: 32px;
  border-radius: $radius-full;
  background: $yellow;
  color: $ink-black;
  font-size: 18px;
  box-shadow: 0 2px 0 0 $yellow-dark;
}

.brandText { line-height: 1; }

.brandModule {
  font-family: $font-mono;
  font-size: $text-xs;
  font-weight: $weight-medium;
  opacity: 0.85;
  letter-spacing: 0.04em;
}

.tagline {
  font-family: $font-secondary;
  font-size: $text-sm;
  font-weight: $weight-medium;
  color: rgba($paper-white, 0.85);
  display: none;

  @include respond-to(md) { display: inline; }
}

.main {
  // Outlet content; ModuleShell handles its own width
}
'@
Write-Source -Path 'src/components/AppLayout/AppLayout.tsx' -Body @'
// ═══════════════════════════════════════════════════════════════════
// AppLayout — outer chrome (top bar) wrapping everything.
// ═══════════════════════════════════════════════════════════════════
import React from 'react';
import { Outlet } from 'react-router-dom';
import { TbSparkles } from 'react-icons/tb';
import styles from './AppLayout.module.scss';

const AppLayout: React.FC = () => (
  <div className={styles.app}>
    <header className={styles.bar}>
      <div className={styles.barInner}>
        <span className={styles.brand}>
          <span className={styles.brandIcon} aria-hidden><TbSparkles /></span>
          <span className={styles.brandText}>BinAI</span>
          <span className={styles.brandModule}>· מודול 05</span>
        </span>
        <span className={styles.tagline}>חשיבה יצירתית עם AI</span>
      </div>
    </header>
    <main className={styles.main}>
      <Outlet />
    </main>
  </div>
);

export default AppLayout;
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
  min-height: calc(100vh - 64px); // minus app bar
}

.main {
  max-width: 920px;
  margin: 0 auto;
  padding: $space-6 $space-4 $space-8;

  @include respond-to(md) { padding: $space-7 $space-6 $space-9; }
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
  @include pop-card($bg: $paper-white);
  @include flex-center;
  flex-direction: column;
  gap: $space-3;
  padding: $space-8 $space-5;
  text-align: center;
  border: 2px dashed $purple-pale;
}

.icon {
  @include flex-center;
  width: 64px; height: 64px;
  border-radius: $radius-full;
  background: $yellow-pale;
  color: $yellow-dark;
  font-size: 32px;
}

.text {
  margin: 0;
  font-family: $font-secondary;
  font-size: $text-md;
  font-weight: $weight-medium;
  color: $ink-soft;
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
.bar {
  position: sticky;
  top: 64px;             // sits under app bar
  z-index: 40;
  background: $purple-mist;
  border-bottom: 2px solid $purple-pale;
  padding: $space-3 0;

  @media print { display: none; }
}

.steps {
  max-width: 1080px;
  margin: 0 auto;
  padding: 0 $space-5;
  list-style: none;
  display: flex;
  align-items: center;
  gap: $space-2;
  overflow-x: auto;
  scrollbar-width: thin;
  scroll-behavior: smooth;

  // Hide scrollbar on Webkit
  &::-webkit-scrollbar { height: 4px; }
  &::-webkit-scrollbar-thumb { background: $purple-pale; border-radius: $radius-full; }
}

.stepItem {
  flex-shrink: 0;
}

.step {
  @include focus-ring;
  display: inline-flex;
  align-items: center;
  gap: $space-2;
  padding: $space-2 $space-3 $space-2 $space-4;
  background: $paper-white;
  border: 2px solid $purple-pale;
  border-radius: $radius-full;
  text-decoration: none;
  color: $ink-soft;
  font-family: $font-secondary;
  font-size: $text-sm;
  font-weight: $weight-bold;
  cursor: pointer;
  white-space: nowrap;
  transition: all $dur-fast $ease-out;

  &:hover:not(.stepLocked) {
    border-color: $purple;
    color: $ink-black;
    transform: translateY(-1px);
  }
}

.stepNum {
  @include flex-center;
  width: 24px; height: 24px;
  border-radius: $radius-full;
  background: $purple-pale;
  color: $ink-soft;
  font-family: $font-display;
  font-size: $text-sm;
  font-weight: $weight-bold;
  transition: all $dur-fast $ease-out;

  svg { font-size: 14px; }
}

.stepLabel { line-height: 1; }

// ── STATES ─────────────────────────────────────────────────────
.stepCurrent {
  background: $ink-black !important;
  border-color: $ink-black !important;
  color: $paper-white !important;
  box-shadow: 0 3px 0 0 $coral, 0 6px 12px rgba(83, 74, 183, 0.15);

  .stepNum {
    background: $yellow;
    color: $ink-black;
  }
}

.stepCompleted {
  background: $mint-pale;
  border-color: $mint;
  color: $mint-dark;

  .stepNum {
    background: $mint;
    color: $paper-white;
  }
}

.stepCompleted.stepCurrent {
  // current overrides completed visually
  .stepNum { background: $yellow; color: $ink-black; }
}

.stepLocked {
  opacity: 0.5;
  cursor: not-allowed;

  &:hover { transform: none; }
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
.section {
  @include flex-col;
  gap: $space-6;
}

// ── HEAD ───────────────────────────────────────────────────────
.head {
  @include flex-col;
  gap: $space-2;
  padding-bottom: $space-4;
  border-bottom: 3px solid $purple-pale;
  position: relative;
}

.num {
  font-family: $font-mono;
  font-size: $text-xs;
  font-weight: $weight-bold;
  letter-spacing: 0.14em;
  text-transform: uppercase;
  color: $coral;
}

.title {
  font-family: $font-display;
  font-weight: $weight-normal;          // Bagel Fat One has only 400 — it's already heavy
  font-size: $text-2xl;
  color: $ink-black;
  margin: 0;
  line-height: 1.05;
  letter-spacing: -0.01em;

  @include respond-to(md) { font-size: $text-3xl; }
}

.subtitle {
  font-family: $font-secondary;
  font-size: $text-md;
  font-weight: $weight-medium;
  color: $ink-soft;
  margin: 0;
}

// ── BODY ───────────────────────────────────────────────────────
.body {
  @include flex-col;
  gap: $space-6;
}

// ── NAV ────────────────────────────────────────────────────────
.nav {
  display: flex;
  align-items: center;
  gap: $space-3;
  margin-top: $space-4;
  padding-top: $space-5;
  border-top: 2px dashed $purple-pale;

  @media print { display: none; }
}

.navSpacer { flex: 1; }

.btnPrev,
.btnNext {
  @include focus-ring;
  display: inline-flex;
  align-items: center;
  gap: $space-2;
  padding: $space-3 $space-5;
  border-radius: $radius-full;
  font-family: $font-secondary;
  font-size: $text-md;
  font-weight: $weight-bold;
  cursor: pointer;
  transition: all $dur-fast $ease-pop;

  svg { font-size: 18px; }
}

.btnPrev {
  background: transparent;
  border: 2px solid $purple-pale;
  color: $ink-soft;

  &:hover {
    border-color: $purple;
    color: $ink-black;
    transform: translateY(-1px);
  }
}

.btnNext {
  background: $ink-black;
  border: 2px solid $ink-black;
  color: $paper-white;
  box-shadow: 0 3px 0 0 $coral, 0 6px 12px rgba(83, 74, 183, 0.15);

  &:hover:not(:disabled) {
    transform: translateY(-2px);
    box-shadow: 0 5px 0 0 $coral, 0 10px 18px rgba(83, 74, 183, 0.2);
  }

  &:active:not(:disabled) {
    transform: translateY(1px);
    box-shadow: 0 1px 0 0 $coral, 0 3px 8px rgba(83, 74, 183, 0.15);
  }

  &:disabled {
    opacity: 0.45;
    cursor: not-allowed;
    box-shadow: none;
  }
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
// M05 · Sections — מבנה ההשתלמות
// 8 חלקים · 180 דק׳ סה״כ
// ═══════════════════════════════════════════════════════════════════
import type { SectionId } from '@/types/module.types';

export interface SectionDef {
  id:         SectionId;
  number:     number;        // 1-8
  shortHe:    string;        // breadcrumb / progress label
  titleHe:    string;        // section main title
  subtitleHe: string;        // section subtitle (h2 below)
  minutes:    number;
  path:       string;        // hash route
}

export const SECTIONS: SectionDef[] = [
  {
    id: 'opening',
    number: 1,
    shortHe: 'פתיחה',
    titleHe: 'חשיבה יצירתית',
    subtitleHe: 'ללא מגבלות · 15 דק׳',
    minutes: 15,
    path: '/opening',
  },
  {
    id: 'theory',
    number: 2,
    shortHe: 'תיאוריה',
    titleHe: 'יצירתיות נלמדת',
    subtitleHe: 'מסתעף ↔ מתכנס · שלושה מהלכים · 20 דק׳',
    minutes: 20,
    path: '/theory',
  },
  {
    id: 'scamper',
    number: 3,
    shortHe: 'מהלך 1',
    titleHe: 'SCAMPER',
    subtitleHe: 'שיפוץ רעיון קיים · 25 דק׳',
    minutes: 25,
    path: '/scamper',
  },
  {
    id: 'break',
    number: 4,
    shortHe: 'הפסקה',
    titleHe: 'הפסקה',
    subtitleHe: 'בחירת הכיתה שלך · 15 דק׳',
    minutes: 15,
    path: '/break',
  },
  {
    id: 'design',
    number: 5,
    shortHe: 'מהלך 2',
    titleHe: 'Design Thinking',
    subtitleHe: 'חמישה שלבים · אמפתיה לפתרון · 25 דק׳',
    minutes: 25,
    path: '/design',
  },
  {
    id: 'whatif',
    number: 6,
    shortHe: 'מהלך 3',
    titleHe: 'מה אם...',
    subtitleHe: 'היפוך הגבלות · רעיונות מקוריים · 25 דק׳',
    minutes: 25,
    path: '/whatif',
  },
  {
    id: 'personal',
    number: 7,
    shortHe: 'השיעור שלך',
    titleHe: 'השיעור היצירתי שלך',
    subtitleHe: 'מהלך אחד · הכיתה שלך · 30 דק׳',
    minutes: 30,
    path: '/personal',
  },
  {
    id: 'closing',
    number: 8,
    shortHe: 'סיכום',
    titleHe: 'סיכום',
    subtitleHe: '4 שיעורים + 5 כרטיסיות פרומפט · 25 דק׳',
    minutes: 25,
    path: '/closing',
  },
];

export const TOTAL_MINUTES = SECTIONS.reduce((sum, s) => sum + s.minutes, 0); // 180

export const SECTION_BY_ID: Record<SectionId, SectionDef> = SECTIONS.reduce(
  (acc, s) => { acc[s.id] = s; return acc; },
  {} as Record<SectionId, SectionDef>,
);

export function getSectionIndex(id: SectionId): number {
  return SECTIONS.findIndex(s => s.id === id);
}

export function getNextSection(id: SectionId): SectionDef | null {
  const i = getSectionIndex(id);
  return i >= 0 && i < SECTIONS.length - 1 ? SECTIONS[i + 1] : null;
}

export function getPrevSection(id: SectionId): SectionDef | null {
  const i = getSectionIndex(id);
  return i > 0 ? SECTIONS[i - 1] : null;
}
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
// Phase 1: only Section 1 (Opening) is implemented. Others use Placeholder.
// ═══════════════════════════════════════════════════════════════════
import React, { lazy, Suspense } from 'react';
import { createHashRouter, Navigate, RouterProvider } from 'react-router-dom';
import AppLayout from '@/components/AppLayout/AppLayout';
import ModuleShell from '@/components/ModuleShell/ModuleShell';
import Placeholder from '@/components/Placeholder/Placeholder';

const OpeningSection = lazy(() => import('@/sections/01-opening'));

const withSuspense = (el: React.ReactNode) => (
  <Suspense fallback={null}>{el}</Suspense>
);

const router = createHashRouter([
  {
    path: '/',
    element: <AppLayout />,
    children: [
      {
        path: '',
        element: <ModuleShell />,
        children: [
          { index: true,        element: <Navigate to="/opening" replace /> },
          { path: 'opening',    element: withSuspense(<OpeningSection />) },
          { path: 'theory',     element: <Placeholder id="theory"   /> },
          { path: 'scamper',    element: <Placeholder id="scamper"  /> },
          { path: 'break',      element: <Placeholder id="break"    /> },
          { path: 'design',     element: <Placeholder id="design"   /> },
          { path: 'whatif',     element: <Placeholder id="whatif"   /> },
          { path: 'personal',   element: <Placeholder id="personal" /> },
          { path: 'closing',    element: <Placeholder id="closing"  /> },
          { path: '*',          element: <Navigate to="/opening" replace /> },
        ],
      },
    ],
  },
]);

const ModuleRouter: React.FC = () => <RouterProvider router={router} />;
export default ModuleRouter;
'@
Write-Source -Path 'src/sections/01-opening/HookCard.module.scss' -Body @'
.card {
  @include speech-bubble($bg: $yellow-pale, $accent: $yellow-dark);
  @include flex-col;
  gap: $space-4;
  padding: $space-6 $space-5;
}

// ── HEAD ───────────────────────────────────────────────────────
.head {
  @include flex-start;
  gap: $space-3;
}

.icon {
  @include flex-center;
  width: 44px; height: 44px;
  border-radius: $radius-full;
  background: $yellow;
  color: $ink-black;
  font-size: 22px;
  box-shadow: 0 3px 0 0 $yellow-dark;
}

.tag {
  font-family: $font-mono;
  font-size: $text-xs;
  font-weight: $weight-bold;
  letter-spacing: 0.14em;
  text-transform: uppercase;
  color: $ink-soft;
}

// ── QUESTION ───────────────────────────────────────────────────
.q {
  margin: 0;
  font-family: $font-secondary;
  font-size: $text-xl;
  font-weight: $weight-bold;
  line-height: 1.2;
  color: $ink-black;
  letter-spacing: -0.01em;

  @include respond-to(md) { font-size: $text-2xl; }
}

.qHighlight {
  display: inline-block;
  background: $coral;
  color: $paper-white;
  padding: 0 $space-3;
  border-radius: $radius-sm;
  transform: rotate(-1deg);
}

// ── FOOTER FACT ────────────────────────────────────────────────
.foot {
  padding-top: $space-3;
  border-top: 2px dashed $yellow-dark;
}

.fact {
  margin: 0;
  font-family: $font-body;
  font-size: $text-base;
  line-height: $leading-loose;
  color: $ink-soft;

  strong {
    color: $ink-black;
    font-weight: $weight-bold;
  }

  em {
    font-style: normal;
    color: $purple;
    font-weight: $weight-bold;
    @include pop-highlight($mint-pale);
  }
}
'@
Write-Source -Path 'src/sections/01-opening/HookCard.tsx' -Body @'
// ═══════════════════════════════════════════════════════════════════
// HookCard — the workshop's opening hook question.
// Speech-bubble style card with a giant question. Pop Studio aesthetic.
// ═══════════════════════════════════════════════════════════════════
import React from 'react';
import { TbBulb } from 'react-icons/tb';
import styles from './HookCard.module.scss';

const HookCard: React.FC = () => (
  <section className={styles.card}>
    <header className={styles.head}>
      <span className={styles.icon} aria-hidden><TbBulb /></span>
      <span className={styles.tag}>שאלת פתיחה</span>
    </header>

    <p className={styles.q}>
      אם יכולת להמציא משהו <span className={styles.qHighlight}>בלי מגבלות</span> — מה הוא היה?
    </p>

    <footer className={styles.foot}>
      <p className={styles.fact}>
        חשבו שתי דקות. כל מי שדיבר על Canva, TikTok או Waze — נחשו מה?{' '}
        <strong>שלושתם נולדו ממגבלה.</strong> Canva — אי אפשר לעצב בלי שמינית. TikTok —
        אינטרנט איטי בכפר בסין. Waze — פקקים בתל אביב.{' '}
        <em>היצירתיות הכי גדולה צומחת מהמגבלות, לא מהחופש.</em>
      </p>
    </footer>
  </section>
);

export default HookCard;
'@
Write-Source -Path 'src/sections/01-opening/OpeningHero.module.scss' -Body @'
.hero {
  position: relative;
  padding: $space-6 0 $space-4;
  overflow: visible;

  @include respond-to(md) {
    padding: $space-7 0 $space-5;
  }
}

// ── DECORATIVE SHAPES (Pop Studio signature) ───────────────────
.shapeCircle {
  position: absolute;
  top: 8px;
  inset-inline-end: 16px;
  width: 88px; height: 88px;
  border-radius: $radius-full;
  background: $yellow;
  box-shadow: 0 4px 0 0 $yellow-dark;
  z-index: 0;

  @include respond-to(md) {
    width: 120px; height: 120px;
    top: 32px;
    inset-inline-end: 32px;
  }
}

.shapeSquiggle {
  position: absolute;
  bottom: 32px;
  inset-inline-end: 100px;
  width: 100px;
  color: $coral;
  z-index: 0;
  transform: rotate(-8deg);

  svg { width: 100%; height: 18px; }

  @include respond-to(md) {
    bottom: 48px;
    inset-inline-end: 160px;
    width: 140px;
  }
}

.shapeStar {
  position: absolute;
  top: 100px;
  inset-inline-end: 132px;
  font-family: $font-display;
  font-size: 56px;
  line-height: 1;
  color: $pink;
  z-index: 0;
  transform: rotate(8deg);

  @include respond-to(md) {
    top: 140px;
    inset-inline-end: 180px;
    font-size: 72px;
  }
}

.shapeBlob {
  position: absolute;
  bottom: 0;
  inset-inline-start: 0;
  width: 64px; height: 64px;
  border-radius: 60% 40% 50% 50% / 50%;
  background: $mint;
  box-shadow: 0 4px 0 0 $mint-dark;
  transform: rotate(-12deg);
  z-index: 0;

  @include respond-to(md) {
    width: 96px; height: 96px;
    bottom: 8px;
  }
}

// ── EYEBROW ────────────────────────────────────────────────────
.eyebrow {
  position: relative;
  z-index: 1;
  display: inline-block;
  font-family: $font-mono;
  font-size: $text-sm;
  font-weight: $weight-bold;
  letter-spacing: 0.14em;
  text-transform: uppercase;
  color: $coral;
  padding: $space-2 $space-3;
  background: $coral-pale;
  border-radius: $radius-full;
  margin-bottom: $space-4;
}

// ── TITLE ──────────────────────────────────────────────────────
.title {
  position: relative;
  z-index: 1;
  font-family: $font-display;        // Bagel Fat One — naturally super heavy
  font-weight: $weight-normal;
  font-size: 64px;
  line-height: 0.95;
  letter-spacing: -0.02em;
  color: $ink-black;
  margin: 0 0 $space-5;

  @include respond-to(md) {
    font-size: $text-hero;
  }
}

.titleAccent {
  color: $purple;
  display: inline-block;
  position: relative;

  &::after {
    content: '';
    position: absolute;
    inset-inline-start: -4px;
    inset-inline-end: -4px;
    bottom: 6px;
    height: 14px;
    background: $yellow;
    z-index: -1;
    border-radius: 4px;
  }
}

// ── LEDE ───────────────────────────────────────────────────────
.lede {
  position: relative;
  z-index: 1;
  font-family: $font-secondary;
  font-size: $text-md;
  line-height: $leading-loose;
  color: $ink-soft;
  margin: 0;
  max-width: 580px;

  strong {
    color: $ink-black;
    font-weight: $weight-bold;
  }

  em {
    font-style: italic;
    color: $coral;
    font-weight: $weight-medium;
  }

  @include respond-to(md) { font-size: $text-lg; }
}
'@
Write-Source -Path 'src/sections/01-opening/OpeningHero.tsx' -Body @'
// ═══════════════════════════════════════════════════════════════════
// OpeningHero — the visual signature of M05.
// Pop Studio aesthetic: heavy Bagel Fat One display, asymmetric
// colored shape decorations, vibrant accents.
// ═══════════════════════════════════════════════════════════════════
import React from 'react';
import styles from './OpeningHero.module.scss';

const OpeningHero: React.FC = () => (
  <section className={styles.hero} aria-label="פתיחה">
    {/* Decorative shapes — Pop Studio motifs */}
    <span className={styles.shapeCircle} aria-hidden />
    <span className={styles.shapeSquiggle} aria-hidden>
      <svg viewBox="0 0 120 20" fill="none" stroke="currentColor" strokeWidth="4" strokeLinecap="round">
        <path d="M2 10 Q 18 -2, 32 10 T 62 10 T 92 10 T 118 10" />
      </svg>
    </span>
    <span className={styles.shapeStar} aria-hidden>✱</span>
    <span className={styles.shapeBlob} aria-hidden />

    {/* Eyebrow */}
    <span className={styles.eyebrow}>השתלמות · 3 שעות</span>

    {/* Heavy display title */}
    <h1 className={styles.title}>
      חשיבה
      <br />
      <span className={styles.titleAccent}>יצירתית</span>
    </h1>

    {/* Lede */}
    <p className={styles.lede}>
      <strong>3 שעות. 3 טכניקות. 5 כרטיסיות פרומפט.</strong>{' '}
      AI לא מחליף את היצירתיות שלכם — הוא הופך אותה לזמינה{' '}
      <em>גם ביום שני בבוקר, בלי קפה.</em>
    </p>
  </section>
);

export default OpeningHero;
'@
Write-Source -Path 'src/sections/01-opening/StatsBlock.module.scss' -Body @'
.grid {
  list-style: none;
  margin: 0;
  padding: 0;
  display: grid;
  gap: $space-4;
  grid-template-columns: 1fr;

  @include respond-to(md) {
    grid-template-columns: repeat(3, 1fr);
  }
}

.stat {
  @include flex-col;
  gap: $space-2;
  padding: $space-5 $space-5 $space-4;
  border-radius: $radius-lg;
  position: relative;
  overflow: hidden;
  min-height: 200px;
}

// Tint variants — each stat its own bold color
.tint-purple {
  background: $purple;
  color: $paper-white;
  box-shadow: 0 4px 0 0 $purple-dark, 0 8px 20px rgba(83, 74, 183, 0.16);

  .icon { background: $purple-soft; }
}

.tint-coral {
  background: $coral;
  color: $paper-white;
  box-shadow: 0 4px 0 0 $coral-dark, 0 8px 20px rgba(216, 90, 48, 0.16);

  .icon { background: $coral-soft; }
}

.tint-mint {
  background: $mint;
  color: $paper-white;
  box-shadow: 0 4px 0 0 $mint-dark, 0 8px 20px rgba(0, 199, 160, 0.16);

  .icon { background: rgba(0, 0, 0, 0.15); }
}

// ── ICON ───────────────────────────────────────────────────────
.icon {
  @include flex-center;
  width: 44px; height: 44px;
  border-radius: $radius-full;
  color: $paper-white;
  font-size: 22px;
  align-self: flex-start;
}

// ── BIG NUMBER ─────────────────────────────────────────────────
.big {
  font-family: $font-display;
  font-weight: $weight-normal;
  font-size: 76px;
  line-height: 0.9;
  letter-spacing: -0.04em;
  color: $paper-white;
  margin-top: $space-2;
}

// ── LABEL ──────────────────────────────────────────────────────
.label {
  font-family: $font-secondary;
  font-size: $text-lg;
  font-weight: $weight-bold;
  line-height: 1.15;
  color: $paper-white;
}

.sub {
  font-family: $font-body;
  font-size: $text-sm;
  line-height: $leading-body;
  color: rgba(255, 255, 255, 0.85);
}
'@
Write-Source -Path 'src/sections/01-opening/StatsBlock.tsx' -Body @'
// ═══════════════════════════════════════════════════════════════════
// StatsBlock — what teachers leave with. Three big colored blocks.
// Pop Studio: each block its own bold color, stacked shadow.
// ═══════════════════════════════════════════════════════════════════
import React from 'react';
import { TbToolsKitchen3, TbCards, TbConfetti } from 'react-icons/tb';
import styles from './StatsBlock.module.scss';

const STATS = [
  {
    icon: <TbToolsKitchen3 aria-hidden />,
    big: '3',
    label: 'מהלכי יצירתיות',
    sub: 'SCAMPER · Design Thinking · "מה אם..."',
    tint: 'purple',
  },
  {
    icon: <TbConfetti aria-hidden />,
    big: '4',
    label: 'שיעורים מוכנים',
    sub: '3 דמו + השיעור שלכם, כל אחד PDF נפרד',
    tint: 'coral',
  },
  {
    icon: <TbCards aria-hidden />,
    big: '5',
    label: 'כרטיסיות פרומפט',
    sub: 'מודפסות לשולחן, מוכנות לכל שיעור',
    tint: 'mint',
  },
] as const;

const StatsBlock: React.FC = () => (
  <section className={styles.block} aria-label="מה ייצא לכם מההשתלמות">
    <ul className={styles.grid}>
      {STATS.map((s, i) => (
        <li key={i} className={[styles.stat, styles[`tint-${s.tint}`]].join(' ')}>
          <span className={styles.icon}>{s.icon}</span>
          <span className={styles.big}>{s.big}</span>
          <span className={styles.label}>{s.label}</span>
          <span className={styles.sub}>{s.sub}</span>
        </li>
      ))}
    </ul>
  </section>
);

export default StatsBlock;
'@
Write-Source -Path 'src/sections/01-opening/index.tsx' -Body @'
// ═══════════════════════════════════════════════════════════════════
// Section 01 — פתיחה (Opening · 15 min)
// "חשיבה יצירתית · ללא מגבלות"
// ═══════════════════════════════════════════════════════════════════
import React from 'react';
import SectionShell from '@/components/SectionShell/SectionShell';
import OpeningHero from './OpeningHero';
import HookCard from './HookCard';
import StatsBlock from './StatsBlock';

const OpeningSection: React.FC = () => (
  <SectionShell id="opening">
    <OpeningHero />
    <HookCard />
    <StatsBlock />
  </SectionShell>
);

export default OpeningSection;
'@
Write-Source -Path 'src/styles/_mixins.scss' -Body @'
// ═══════════════════════════════════════════════════════════════════
// M05 · Pop Studio Mixins
// ═══════════════════════════════════════════════════════════════════

// ── LAYOUT HELPERS ─────────────────────────────────────────────
@mixin flex-center      { display: flex; align-items: center; justify-content: center; }
@mixin flex-between     { display: flex; align-items: center; justify-content: space-between; }
@mixin flex-start       { display: flex; align-items: center; justify-content: flex-start; }
@mixin flex-col         { display: flex; flex-direction: column; }

@mixin respond-to($bp) {
  @if $bp == sm { @media (min-width: $bp-sm) { @content; } }
  @if $bp == md { @media (min-width: $bp-md) { @content; } }
  @if $bp == lg { @media (min-width: $bp-lg) { @content; } }
  @if $bp == xl { @media (min-width: $bp-xl) { @content; } }
}

// ── POP STUDIO SIGNATURE: Big rounded card with stacked shadow ─
// Optional $shadow lets you pick which color the "pop" layer is.
@mixin pop-card($bg: $paper-white, $shadow: $shadow-card) {
  background: $bg;
  border-radius: $radius-lg;
  box-shadow: $shadow;
}

// Pop card with the colorful stacked shadow effect
@mixin pop-card-stacked($bg: $paper-white, $shadow: $shadow-pop-purple) {
  background: $bg;
  border-radius: $radius-lg;
  box-shadow: $shadow;
  transition: transform $dur-base $ease-pop, box-shadow $dur-base $ease-out;
}

// ── BIG COLOR BLOCK — solid color section with bold heading ────
// Used for hero & feature sections. No border, no shadow — just color.
@mixin color-block($bg, $text: $paper-white) {
  background: $bg;
  color: $text;
  border-radius: $radius-xl;
  padding: $space-7;
}

// ── PILL — rounded full pill for badges, tags, buttons ─────────
@mixin pill($bg: $purple, $text: $paper-white) {
  display: inline-flex;
  align-items: center;
  gap: $space-2;
  padding: $space-2 $space-4;
  background: $bg;
  color: $text;
  border-radius: $radius-full;
  font-family: $font-body;
  font-size: $text-sm;
  font-weight: $weight-bold;
  line-height: 1;
}

// ── SPEECH BUBBLE — asymmetric rounded card with tail ──────────
// For "ideas," prompts, quotes. The tail is a CSS shape on the corner.
@mixin speech-bubble($bg: $yellow-pale, $accent: $yellow-dark) {
  position: relative;
  background: $bg;
  border: 2px solid $accent;
  border-radius: $radius-lg;
  padding: $space-4 $space-5;

  &::after {
    content: '';
    position: absolute;
    bottom: -10px;
    inset-inline-start: 32px;
    width: 24px; height: 24px;
    background: $bg;
    border-inline-end: 2px solid $accent;
    border-bottom: 2px solid $accent;
    border-bottom-right-radius: 4px;
    transform: rotate(45deg);
  }
}

// ── SQUIGGLE UNDERLINE — Pop accent under text ─────────────────
// Uses SVG bg image for a hand-drawn squiggle.
@mixin squiggle-underline($color: $coral) {
  position: relative;
  display: inline-block;

  &::after {
    content: '';
    position: absolute;
    left: 0; right: 0; bottom: -8px;
    height: 8px;
    background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 80 8' fill='none' stroke='#{rgba($color, 1)}' stroke-width='2.5' stroke-linecap='round'%3E%3Cpath d='M0,4 Q 10,0 20,4 T 40,4 T 60,4 T 80,4'/%3E%3C/svg%3E");
    background-repeat: repeat-x;
    background-size: auto 8px;
  }
}

// ── HIGHLIGHTED TEXT — bold marker swipe in a color ────────────
@mixin pop-highlight($color: $yellow) {
  background: linear-gradient(180deg, transparent 0%, transparent 50%, $color 50%, $color 90%, transparent 90%);
  padding: 0 4px;
  border-radius: 4px;
}

// ── BIG ROUND BUTTON — Pop Studio primary action ───────────────
@mixin pop-button($bg: $purple, $text: $paper-white) {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  gap: $space-2;
  padding: $space-3 $space-6;
  background: $bg;
  color: $text;
  border: none;
  border-radius: $radius-full;
  font-family: $font-secondary;
  font-size: $text-md;
  font-weight: $weight-bold;
  cursor: pointer;
  transition: transform $dur-fast $ease-pop, box-shadow $dur-fast $ease-out;
  box-shadow: $shadow-card;

  &:hover:not(:disabled) {
    transform: translateY(-2px);
    box-shadow: $shadow-lift;
  }

  &:active:not(:disabled) {
    transform: translateY(0);
    box-shadow: $shadow-press;
  }

  &:disabled {
    opacity: 0.5;
    cursor: not-allowed;
  }
}

// ── FOCUS RING — accessible keyboard focus ─────────────────────
@mixin focus-ring($color: $purple) {
  &:focus-visible {
    outline: 3px solid rgba($color, 0.4);
    outline-offset: 2px;
  }
}

// ── DOT PATTERN — Pop Studio background texture ────────────────
@mixin dot-pattern($color: $purple-pale, $size: 24px) {
  background-image: radial-gradient(circle, $color 1.5px, transparent 1.5px);
  background-size: $size $size;
}
'@
Write-Source -Path 'src/styles/_tokens.scss' -Body @'
// ═══════════════════════════════════════════════════════════════════
// M05 · Pop Studio Design Tokens
// Bold rounded shapes · big color blocks · vibrant accents.
// Purple/coral foundation extended with yellow + pink + mint pops.
// ═══════════════════════════════════════════════════════════════════

// ── PALETTE ────────────────────────────────────────────────────
// Primary — purple (deep, bold)
$purple:           #534AB7;
$purple-dark:      #3D3590;
$purple-soft:      #7C73E0;
$purple-pale:      #E8E5FF;
$purple-mist:      #F5F3FF;     // page bg

// Accent 1 — coral (warm punch)
$coral:            #D85A30;
$coral-dark:       #B04220;
$coral-soft:       #E88560;
$coral-pale:       #FAD5C5;

// Accent 2 — sunny yellow (energy)
$yellow:           #F4D55A;
$yellow-dark:      #C9A91D;
$yellow-pale:      #FBEBC2;

// Accent 3 — hot pink (pop)
$pink:             #FF6B9D;
$pink-dark:        #E84D7E;
$pink-pale:        #FFD5E3;

// Accent 4 — mint (fresh)
$mint:             #00C7A0;
$mint-dark:        #00A085;
$mint-pale:        #C5F5E8;

// Neutrals
$ink-black:        #1A1830;     // primary text (slightly purple-tinted black)
$ink-soft:         #4A4566;
$ink-mist:         #8B85A3;
$paper-white:      #FFFFFF;
$paper-cream:      #FFF8F0;     // alt surface
$paper-line:       rgba(83, 74, 183, 0.12);
$paper-line-bold:  rgba(83, 74, 183, 0.24);

// Semantic
$success:          #00A085;
$success-pale:     #C5F5E8;
$error:            #E84D7E;
$error-pale:       #FFD5E3;

// ── TYPOGRAPHY ─────────────────────────────────────────────────
// Display fonts — heavy + rounded for that Pop punch
$font-display:     'Bagel Fat One', 'Heebo', sans-serif;   // hero stunners
$font-secondary:   'Rubik', 'Heebo', sans-serif;           // section headers
$font-body:        'Assistant', 'Heebo', sans-serif;       // body
$font-mono:        'IBM Plex Mono', 'Courier New', monospace;

// Sizes — slightly bigger than M04 to feel Pop
$text-xs:    12px;
$text-sm:    13px;
$text-base:  15px;
$text-md:    17px;
$text-lg:    22px;
$text-xl:    28px;
$text-2xl:   38px;
$text-3xl:   52px;
$text-hero:  72px;        // Pop hero size

$weight-normal:    400;
$weight-medium:    500;
$weight-bold:      700;
$weight-black:     900;

$leading-tight:  1.1;
$leading-body:   1.55;
$leading-loose:  1.7;

// ── SPACING ────────────────────────────────────────────────────
$space-0:    0;
$space-1:    4px;
$space-2:    8px;
$space-3:    12px;
$space-4:    16px;
$space-5:    24px;
$space-6:    32px;
$space-7:    48px;
$space-8:    64px;
$space-9:    96px;

// ── SHAPES — Pop Studio = big rounded ──────────────────────────
$radius-sm:        12px;
$radius-md:        20px;
$radius-lg:        28px;
$radius-xl:        40px;
$radius-2xl:       56px;
$radius-full:      999px;

// ── SHADOWS — playful stacked + soft drop ─────────────────────
$shadow-pop-purple: 0 4px 0 0 $purple-pale,      0 8px 16px rgba(83, 74, 183, 0.10);
$shadow-pop-coral:  0 4px 0 0 $coral-pale,        0 8px 16px rgba(216, 90, 48, 0.10);
$shadow-pop-yellow: 0 4px 0 0 $yellow-pale,       0 8px 16px rgba(244, 213, 90, 0.18);
$shadow-pop-pink:   0 4px 0 0 $pink-pale,         0 8px 16px rgba(255, 107, 157, 0.10);
$shadow-pop-mint:   0 4px 0 0 $mint-pale,         0 8px 16px rgba(0, 199, 160, 0.10);

$shadow-card:       0 2px 4px rgba(83, 74, 183, 0.08), 0 8px 24px rgba(83, 74, 183, 0.04);
$shadow-lift:       0 6px 12px rgba(83, 74, 183, 0.14), 0 16px 32px rgba(83, 74, 183, 0.06);
$shadow-press:      0 1px 2px rgba(83, 74, 183, 0.10);

// ── MOTION ─────────────────────────────────────────────────────
$dur-fast:    0.15s;
$dur-base:    0.25s;
$dur-slow:    0.4s;

$ease-out:    cubic-bezier(0.22, 1, 0.36, 1);
$ease-pop:    cubic-bezier(0.34, 1.56, 0.64, 1);  // springy pop

// ── BREAKPOINTS ────────────────────────────────────────────────
$bp-sm:  480px;
$bp-md:  768px;
$bp-lg:  1024px;
$bp-xl:  1280px;
'@
Write-Source -Path 'src/styles/global.scss' -Body @'
// ═══════════════════════════════════════════════════════════════════
// M05 · Global styles
// Base reset + Pop Studio body + print isolation (portal-based).
// ═══════════════════════════════════════════════════════════════════

*, *::before, *::after { box-sizing: border-box; }

html, body, #root { height: 100%; }

body {
  margin: 0;
  font-family: $font-body;
  font-size: $text-base;
  line-height: $leading-body;
  color: $ink-black;
  background: $purple-mist;
  direction: rtl;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-rendering: optimizeLegibility;
}

button { font: inherit; }

a {
  color: $purple;
  text-decoration: underline;
  text-decoration-thickness: 1.5px;
  text-underline-offset: 3px;

  &:hover { color: $coral; }
}

img, svg, video { max-width: 100%; display: block; }

// ═══════════════════════════════════════════════════════════════════
// PRINT — Section 8 PDFs use a React portal mounted to <body>.
// In print we hide the app root and show only the portal.
// ═══════════════════════════════════════════════════════════════════
@page {
  size: A4;
  margin: 20mm 18mm;
}

.m05-print-host {
  display: none;
}

@media print {
  body {
    background: white !important;
    background-image: none !important;
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
  | 'theory'
  | 'scamper'
  | 'break'
  | 'design'
  | 'whatif'
  | 'personal'
  | 'closing';

/** The 3 creative techniques the workshop teaches */
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
  sections: Record<SectionId, SectionProgress>;
  customTopic: CustomTopic | null;
  personalTechnique: TechniqueKey | null;
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
