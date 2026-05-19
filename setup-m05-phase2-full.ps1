# ═══════════════════════════════════════════════════════════════════
# setup-m05-phase2.ps1
# M05 · Creative Thinking — Phase 1 scaffold + Section 1 (Opening)
#
# USAGE: create folder, place PS1 inside, then:
#   PS> cd C:\Users\sharo\OneDrive\מסמכים\sharon_workspace\creative-thinking
#   PS> Unblock-File .\setup-m05-phase2.ps1
#   PS> .\setup-m05-phase2.ps1
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
Write-Host "M05 Phase 2 - full module (8 sections)" -ForegroundColor Magenta
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
Write-Source -Path 'src/components/LessonPlanCard/LessonPlanCard.module.scss' -Body @'
.card {
  @include flex-col;
  gap: $space-4;
  padding: $space-5;
  background: $bg-surface;
  border: $border-hair;
  border-radius: $radius-md;
}

// Print variant — flatter, lighter, no border
.cardPrint {
  border: none;
  padding: 0;
  background: transparent;
}

// ── HEAD ───────────────────────────────────────────────────────
.head {
  @include flex-col;
  gap: $space-2;
  padding-bottom: $space-3;
  border-bottom: $border-subtle;
}

.title {
  @include headline-subsection;
  font-weight: $weight-regular;
}

.meta {
  display: inline-flex;
  align-items: center;
  gap: $space-2;
  flex-wrap: wrap;
  font-family: $font-mono;
  font-size: 11px;
  color: $ink-soft;
  letter-spacing: 0.04em;

  span:not(.totalTime) { line-height: 1; }
}

.totalTime {
  display: inline-flex;
  align-items: center;
  gap: 4px;
  margin-inline-start: auto;
  color: $accent;

  svg { font-size: 12px; }
}

// ── BLOCKS ─────────────────────────────────────────────────────
.blocks {
  list-style: none;
  margin: 0;
  padding: 0;
  @include flex-col;
  gap: $space-4;
}

.block {
  display: grid;
  grid-template-columns: 48px 1fr;
  gap: $space-4;
  align-items: baseline;
}

.duration {
  font-family: $font-mono;
  font-size: $text-sm;
  font-weight: $weight-medium;
  color: $accent;
  text-align: end;
  padding-top: 3px;

  &::after {
    content: '׳';
    margin-inline-start: 2px;
    color: $ink-faint;
    font-weight: $weight-regular;
  }
}

.body { @include flex-col; gap: $space-1; min-width: 0; }

.blockTitle {
  font-family: $font-body;
  font-size: $text-base;
  font-weight: $weight-medium;
  color: $ink;
  line-height: $leading-tight;
}

.blockDesc {
  @include body-paragraph;
  font-size: $text-sm;
}
'@
Write-Source -Path 'src/components/LessonPlanCard/LessonPlanCard.tsx' -Body @'
// ═══════════════════════════════════════════════════════════════════
// LessonPlanCard — reusable time-blocks display for a lesson plan.
// Used by Section 6 (each demo) and Section 7 (personal lesson),
// and rendered in print form by Section 8.
// ═══════════════════════════════════════════════════════════════════
import React from 'react';
import { TbClock } from 'react-icons/tb';
import type { LessonBlock } from '@/data/methods';
import styles from './LessonPlanCard.module.scss';

interface Props {
  titleHe:   string;
  blocks:    LessonBlock[];
  classHe?:  string;
  topicHe?:  string;
  variant?:  'screen' | 'print';
}

const LessonPlanCard: React.FC<Props> = ({
  titleHe, blocks, classHe, topicHe, variant = 'screen',
}) => {
  const totalMin = blocks.reduce((sum, b) => sum + b.durationMin, 0);
  const isPrint = variant === 'print';

  return (
    <article className={[styles.card, isPrint && styles.cardPrint].filter(Boolean).join(' ')}>
      <header className={styles.head}>
        <h3 className={styles.title}>{titleHe}</h3>
        <div className={styles.meta}>
          {classHe && <span>{classHe}</span>}
          {topicHe && <span>· {topicHe}</span>}
          <span className={styles.totalTime}>
            <TbClock aria-hidden /> {totalMin} דק׳
          </span>
        </div>
      </header>

      <ol className={styles.blocks}>
        {blocks.map((b, i) => (
          <li key={i} className={styles.block}>
            <span className={styles.duration}>{b.durationMin}</span>
            <div className={styles.body}>
              <h4 className={styles.blockTitle}>{b.titleHe}</h4>
              <p className={styles.blockDesc}>{b.descriptionHe}</p>
            </div>
          </li>
        ))}
      </ol>
    </article>
  );
};

export default LessonPlanCard;
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
Write-Source -Path 'src/components/PromptCard/PromptCard.module.scss' -Body @'
.card {
  @include flex-col;
  gap: $space-4;
  padding: $space-5 $space-5;
  background: $bg-surface;
  border: $border-hair;
  border-radius: $radius-md;
}

// ── HEAD ───────────────────────────────────────────────────────
.head {
  @include flex-between;
  gap: $space-3;
  padding-bottom: $space-3;
  border-bottom: $border-subtle;
}

.name {
  @include headline-subsection;
  font-weight: $weight-regular;
  flex: 1;
  min-width: 0;
}

.copy {
  @include btn-secondary;
  display: inline-flex;
  align-items: center;
  gap: $space-2;
  padding: 6px 14px;
  font-size: $text-xs;

  svg { font-size: 14px; }
}

// ── PARTS ──────────────────────────────────────────────────────
.parts {
  @include flex-col;
  gap: $space-3;
  margin: 0;
}

.part {
  display: grid;
  grid-template-columns: 80px 1fr;
  gap: $space-3;
  align-items: baseline;

  @media (max-width: $bp-sm) {
    grid-template-columns: 1fr;
    gap: $space-1;
  }

  dt {
    @include eyebrow;
    margin: 0;
    padding-top: 3px;
    color: $accent;
  }

  dd {
    margin: 0;
    @include body-paragraph;
    color: $ink;
    font-weight: $weight-regular;
  }
}

// ── EXAMPLE ────────────────────────────────────────────────────
.example {
  padding: $space-4 $space-4;
  background: $accent-faint;
  border-radius: $radius-sm;
  font-size: $text-sm;
  line-height: $leading-loose;
  color: $ink-mid;
  font-style: italic;

  p { margin: 0; }
}

.exampleLabel {
  display: block;
  @include eyebrow;
  margin-bottom: $space-1;
  color: $ink-soft;
  font-style: normal;
}
'@
Write-Source -Path 'src/components/PromptCard/PromptCard.tsx' -Body @'
// ═══════════════════════════════════════════════════════════════════
// PromptCard — reusable 4-part prompt display.
// Used by Section 5 (Card 1), Section 6 (each method demo),
// Section 7 (personal lesson), Section 8 (printable deck).
// ═══════════════════════════════════════════════════════════════════
import React, { useState } from 'react';
import { TbCopy, TbCheck } from 'react-icons/tb';
import type { FourPartPrompt } from '@/data/methods';
import styles from './PromptCard.module.scss';

interface Props {
  prompt:     FourPartPrompt;
  nameHe?:    string;
  exampleHe?: string;
}

function joinPrompt(p: FourPartPrompt): string {
  return [
    'תפקיד:',  p.roleHe,        '',
    'הקשר:',   p.contextHe,     '',
    'משימה:',  p.taskHe,        '',
    'מגבלות:', p.constraintsHe,
  ].join('\n');
}

const PromptCard: React.FC<Props> = ({ prompt, nameHe, exampleHe }) => {
  const [copied, setCopied] = useState(false);

  const handleCopy = async () => {
    try {
      await navigator.clipboard.writeText(joinPrompt(prompt));
      setCopied(true);
      setTimeout(() => setCopied(false), 2000);
    } catch { /* no clipboard, ignore */ }
  };

  return (
    <article className={styles.card}>
      <header className={styles.head}>
        {nameHe && <h3 className={styles.name}>{nameHe}</h3>}
        <button
          type="button"
          className={styles.copy}
          onClick={handleCopy}
          aria-label="העתק את הפרומפט"
        >
          {copied ? (<><TbCheck aria-hidden /><span>הועתק</span></>)
                  : (<><TbCopy  aria-hidden /><span>העתק</span></>)}
        </button>
      </header>

      <dl className={styles.parts}>
        <div className={styles.part}>
          <dt>תפקיד</dt>
          <dd>{prompt.roleHe}</dd>
        </div>
        <div className={styles.part}>
          <dt>הקשר</dt>
          <dd>{prompt.contextHe}</dd>
        </div>
        <div className={styles.part}>
          <dt>משימה</dt>
          <dd>{prompt.taskHe}</dd>
        </div>
        <div className={styles.part}>
          <dt>מגבלות</dt>
          <dd>{prompt.constraintsHe}</dd>
        </div>
      </dl>

      {exampleHe && (
        <div className={styles.example}>
          <span className={styles.exampleLabel}>דוגמה ממולאת:</span>
          <p>{exampleHe}</p>
        </div>
      )}
    </article>
  );
};

export default PromptCard;
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
Write-Source -Path 'src/data/cases.ts' -Body @'
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
'@
Write-Source -Path 'src/data/methods.ts' -Body @'
// ═══════════════════════════════════════════════════════════════════
// M05 · Method demos
// Three creative-thinking methods, each demonstrated on a real
// classroom challenge: SCAMPER, Design Thinking, "What If".
// ═══════════════════════════════════════════════════════════════════
import type { TechniqueKey } from '@/types/module.types';

export interface FourPartPrompt {
  roleHe:        string;
  contextHe:     string;
  taskHe:        string;
  constraintsHe: string;
}

export interface OutputRow {
  labelHe: string;
  valueHe: string;
}

export interface LessonBlock {
  durationMin:    number;
  titleHe:        string;
  descriptionHe:  string;
}

export interface MethodDemo {
  id:             TechniqueKey;
  nameHe:         string;
  taglineHe:      string;
  whenToUseHe:    string;
  challengeHe:    string;
  gradeHe:        string;
  subjectHe:      string;
  prompt:         FourPartPrompt;
  outputs:        OutputRow[];
  lesson:         LessonBlock[];
  reflectionHe:   string;
}

// ── SCAMPER ────────────────────────────────────────────────────
export const SCAMPER_DEMO: MethodDemo = {
  id: 'scamper',
  nameHe: 'SCAMPER',
  taglineHe: 'שבע דרכים לרענן שיעור קיים',
  whenToUseHe: 'יש לך שיעור שעובד "ברגיל" ואתה רוצה לרענן. או שיעור שלא עובד ואתה לא יודע איפה לתפוס אותו.',
  challengeHe: 'שיעור מחזור המים שלימדתי כבר עשר שנים. סרטון, דף עבודה, סיכום על הלוח. עובד. אבל משעמם אותי, וזה כנראה גם אותם.',
  gradeHe: 'כיתה ה',
  subjectHe: 'מדעים',
  prompt: {
    roleHe: 'את מומחית בשיטת SCAMPER (Substitute, Combine, Adapt, Modify, Put to other use, Eliminate, Reverse).',
    contextHe: 'יש לי שיעור על מחזור המים לכיתה ה. המבנה הנוכחי: סרטון של 8 דקות, דף עבודה עם 5 שאלות, סיכום על הלוח.',
    taskHe: 'הפעילי SCAMPER על השיעור הזה. לכל אחת משבע האותיות — תני רעיון קונקרטי אחד לשינוי. בטבלה: אות, רעיון, השפעה צפויה.',
    constraintsHe: 'רעיונות מעשיים. עברית. רעיונות שאפשר ליישם השבוע.',
  },
  outputs: [
    { labelHe: 'S · Substitute',     valueHe: 'במקום סרטון — תלמידים מצלמים בעצמם סצנה של אדים מהקומקום / מקלחת. עלייה דרמטית במעורבות בפתיחה.' },
    { labelHe: 'C · Combine',        valueHe: 'משלבים את המחזור עם שיעור גיאוגרפיה — אותו מים שתלמיד בכיתה נתן בבר־מצווה שלו, איפה הוא היה לפני 10,000 שנה?' },
    { labelHe: 'A · Adapt',          valueHe: 'מעבירים את הצורה של "סיפור גיבור" (יציאה, מסע, חזרה) על טיפת המים. הילד הוא הגיבור.' },
    { labelHe: 'M · Modify',         valueHe: 'מגדילים את קנה המידה — לא טיפה, אלא כל המים בעולם. כמה אחוז שתינו? כמה אחוז קפא?' },
    { labelHe: 'P · Put to other use', valueHe: 'משתמשים בסרטון הקיים — אבל בלי קול. התלמידים מדבבים את המים מהזווית שלהם.' },
    { labelHe: 'E · Eliminate',      valueHe: 'מוותרים על דף העבודה לחלוטין. במקום — שאלה אחת על הלוח: "איך הגעת היום למים שלך?" 20 דקות שיחה.' },
    { labelHe: 'R · Reverse',        valueHe: 'מתחילים מהסוף — מים בים. שואלים: "איך זה הגיע לפה?" ובונים את המחזור לאחור.' },
  ],
  lesson: [
    { durationMin: 5,  titleHe: 'פתיחה · צילום אדים',         descriptionHe: 'שני תלמידים מציגים את הסרטון שצילמו אתמול בבית של אדים מהקומקום. שואלים: לאן הלכו האדים?' },
    { durationMin: 12, titleHe: 'הסיפור של הגיבורה',          descriptionHe: 'הכיתה מקבלת "טיפת מים" דמיונית. בזוגות — כותבים שלוש תחנות במסע שלה. תלמידים מציגים.' },
    { durationMin: 10, titleHe: 'הלוח הריק',                  descriptionHe: 'אני שואלת: "מה האות הראשונה במחזור הזה?" התלמידים מובילים. אני רק כותבת.' },
    { durationMin: 10, titleHe: 'היפוך — מים בים',            descriptionHe: 'מציגה תמונה של ים. שאלה: "איך הוא הגיע לפה?" התלמידים בונים את המחזור מהסוף.' },
    { durationMin: 8,  titleHe: 'סיכום · המים שלי השבוע',     descriptionHe: 'כל תלמיד שואל את עצמו לפני שיוצא: "מאיפה הגיעו המים שלי הבוקר? לאן ילכו השבוע?"' },
  ],
  reflectionHe: 'הפעם הראשונה ש-SCAMPER הצליחה אצלי הייתה כשעצרתי לבחור רק 3 מתוך 7 הרעיונות. כל 7 בשיעור אחד — יוצא מבולגן. 3 רעיונות שונים זה ממש שיעור אחר.',
};

// ── DESIGN THINKING ────────────────────────────────────────────
export const DESIGN_DEMO: MethodDemo = {
  id: 'design',
  nameHe: 'Design Thinking · אמפתיה',
  taglineHe: 'תבין את התלמיד לפני שתתכנן את השיעור',
  whenToUseHe: 'כשתלמידים לא "נתפסים" ואתה לא בטוח למה. כשהפער בין מה שתכננת לבין מה שקורה בשטח גדל.',
  challengeHe: 'יש בכיתה שלי מצב חברתי קשה. שתי קבוצות, ילדה אחת באמצע שאף אחד לא קולט אותה. רציתי לתכנן יחידה על שייכות, אבל הרגשתי שאני לא יודעת מה היא בעצם חווה.',
  gradeHe: 'כיתה ז',
  subjectHe: 'חינוך · שייכות וקליקות',
  prompt: {
    roleHe: 'את מומחית ב-Design Thinking, ובמיוחד בשלב האמפתיה — להבין את החוויה האמיתית של המשתמש, לא מה שתכננו שיקרה.',
    contextHe: 'אני מתכננת יחידה על "שייכות וקליקות" לכיתה ז. התלמידה שבראש: ילדה שעברה מבית ספר אחר באמצע שנה. חברתית בודדת. ציונים בסדר. שותקת בשיעורים.',
    taskHe: 'מפת אמפתיה לתלמידה הזאת: (1) מה היא רואה כשנכנסת לכיתה? (2) מה היא שומעת מחברים? (3) מה היא חושבת ומרגישה בפועל? (4) מה היא אומרת/עושה? (5) "כאבים". (6) "רווחים".',
    constraintsHe: 'בעברית. ספציפי, לא כללי. אם משהו לא ידוע — תגידי "לא יודעת, צריך לשאול אותה".',
  },
  outputs: [
    { labelHe: 'רואה',     valueHe: 'את אותן שתי קבוצות יושבות באותם מקומות. את שלוש בנות שצוחקות ולא מסתכלות לכיוונה. את הספסל הריק לידה.' },
    { labelHe: 'שומעת',    valueHe: 'תוכניות לסוף שבוע שהיא לא חלק מהן. בדיחות פנימיות. מורים אומרים "תשבי איפה שאת רוצה" — היא לא יודעת איפה.' },
    { labelHe: 'חושבת ומרגישה', valueHe: '"אני שקופה". "אם אקום לעבור — כולן יסתכלו". "אולי באמת יש איתי משהו לא בסדר". בושה, בדידות, רצון לקום מהכיתה.' },
    { labelHe: 'אומרת ועושה',   valueHe: 'מעט מאוד. שותקת בשיעורים. בהפסקות הולכת לספרייה לבד. ארוחת בוקר לבד. בבית — לא מספרת.' },
    { labelHe: 'כאבים',         valueHe: 'אין לה אדם אחד שמחכה לה כשהיא נכנסת לכיתה. כל הפסקה היא החלטה — "איפה אני יושבת עכשיו?". מתישה.' },
    { labelHe: 'רווחים',        valueHe: 'אם המורה תיצור מצב שבו יש לה תפקיד — לא חברה, תפקיד — ההגדרה תיתן לה במה.' },
  ],
  lesson: [
    { durationMin: 8,  titleHe: 'פתיחה · "מה אם אני הייתי חדש?"', descriptionHe: 'שואלים את כל הכיתה לכתוב על דף 3 דברים שהיו מאחלים לעצמם ביום הראשון. אנונימי.' },
    { durationMin: 10, titleHe: 'קריאת הדפים',                    descriptionHe: 'קוראת כמה דפים בקול (אנונימי). הכיתה רואה: "כולנו מאחלים אותו דבר".' },
    { durationMin: 12, titleHe: 'תפקידים, לא חברויות',            descriptionHe: 'מחלקת תפקידים סיבוביים בכיתה — אחראי על משהו שכולם צריכים. מי שאחראי על השעון, על הלוח, על האור.' },
    { durationMin: 10, titleHe: 'דיון מובנה',                    descriptionHe: 'מה ההבדל בין "להיות חבר" לבין "להיות חלק"? למה השני הוא לפעמים מספיק?' },
    { durationMin: 5,  titleHe: 'סיכום אישי',                    descriptionHe: 'כל תלמיד כותב משפט: "השבוע אני אבחין ב..." מי שמרגיש בנוח — קורא בקול.' },
  ],
  reflectionHe: 'מפת האמפתיה לא הייתה השיעור. היא הייתה ההכנה. כשנכנסתי לכיתה כבר ידעתי מה אני מחפשת — אם הייתי משתמשת רק בידע שלי על הילדה הזאת, הייתי מפספסת את ה"כאב" המרכזי (להחליט איפה לשבת בכל הפסקה).',
};

// ── WHAT IF ────────────────────────────────────────────────────
export const WHATIF_DEMO: MethodDemo = {
  id: 'whatif',
  nameHe: 'מה אם...',
  taglineHe: 'הפוך הנחה אחת. תראה מה נולד.',
  whenToUseHe: 'כשהשיעור "נכון" אבל משעמם. כשאתה רוצה לערער על משהו שתמיד היה.',
  challengeHe: 'נמאס לי משיעורי בית במתמטיקה. הילדים שונאים אותם, אני שונאת לבדוק אותם, ההורים שונאים לעמוד מעליהם. אבל "ככה זה".',
  gradeHe: 'כיתה ד',
  subjectHe: 'מתמטיקה',
  prompt: {
    roleHe: 'אתה מנחה חשיבה יצירתית בשיטת "What If" — היפוך הנחות. אתה לוקח הנחה מובנת מאליה ושואל "מה אם בדיוק ההפך?", ואז חוקר מה יקרה.',
    contextHe: 'אני מורה למתמטיקה בכיתה ד. ההנחה שאני רוצה להפוך: "שיעורי בית עוזרים ללמוד מתמטיקה".',
    taskHe: 'נסח לי 5 וריאציות של "מה אם בדיוק ההפך?". לכל אחת: (1) המשפט החדש, (2) מה היה משתנה בכיתה שלי, (3) רעיון אחד קונקרטי לפעילות שמשקפת את ההיפוך.',
    constraintsHe: 'בעברית. רעיונות שאני יכולה לנסות בשבועיים הקרובים, לא במציאות אחרת. אל תהיה נחמד — תהיה פרובוקטיבי.',
  },
  outputs: [
    { labelHe: 'מה אם · 1', valueHe: '"שיעורי בית בכיתה, שיעורים בבית". הופכים את הסדר — הסבר וידאו מהבית, תרגול בכיתה כשאני שם לעזור.' },
    { labelHe: 'מה אם · 2', valueHe: '"שיעורי בית לא הכרחיים. שואלים מי רוצה לקבל". הכיתה מתחלקת בעצמה למי שצריך עוד תרגול ומי שלא.' },
    { labelHe: 'מה אם · 3', valueHe: '"הילדים נותנים שיעורי בית למורה". כל יום שני אחד הילדים מציע "שיעור בית" למורה. המורה מבצע ומחזיר.' },
    { labelHe: 'מה אם · 4', valueHe: '"שיעורי בית הם משחק עם ההורים, לא דף עבודה". מורידים את הדף ועולים על שיחה — "ספר להורה איך מחלקים פיצה לשלוש".' },
    { labelHe: 'מה אם · 5', valueHe: '"אין שיעורי בית. יש שאלות שעלו השבוע". כל ילד מביא יום שני שאלה אחת שעלתה לו בראש בנושא — לא דף עבודה.' },
  ],
  lesson: [
    { durationMin: 5,  titleHe: 'מקבלים את ההפיכה',          descriptionHe: 'מודיעה לכיתה: "השבוע אין שיעורי בית רגילים. יש שיעור בית אחד: להביא יום שני שאלה אחת שעלתה לי בראש על מתמטיקה."' },
    { durationMin: 15, titleHe: 'מעגל השאלות',               descriptionHe: 'יום שני — כל ילד אומר את השאלה שלו בקול. כותבת על הלוח. בלי תשובות עדיין.' },
    { durationMin: 10, titleHe: 'בוחרים שתיים',              descriptionHe: 'הכיתה מצביעה על שתי שאלות שהן הכי "מסקרנות". זה השיעור של השבוע.' },
    { durationMin: 15, titleHe: 'חוקרים יחד',                descriptionHe: 'עובדים על שאלה אחת בקבוצות. כל קבוצה מציעה דרך פתרון. השוואה.' },
    { durationMin: 5,  titleHe: 'מה השתנה?',                 descriptionHe: 'שאלה לסיום: "מה למדתם השבוע שלא יכולנו ללמד עם שיעורי בית רגילים?"' },
  ],
  reflectionHe: 'הניסיון של שבועיים הראה שלא כל הילדים מביאים שאלה. שליש פשוט לא. אבל הילדים שהביאו שאלות — שאלו שאלות שלא ידעתי שתלמיד בכיתה ד יכול לחשוב עליהן. שווה את החצי שלא הביא.',
};

export const ALL_DEMOS: MethodDemo[] = [SCAMPER_DEMO, DESIGN_DEMO, WHATIF_DEMO];

export const DEMO_BY_ID: Record<TechniqueKey, MethodDemo> = {
  scamper: SCAMPER_DEMO,
  design:  DESIGN_DEMO,
  whatif:  WHATIF_DEMO,
};
'@
Write-Source -Path 'src/data/promptCards.ts' -Body @'
// ═══════════════════════════════════════════════════════════════════
// M05 · Prompt cards
// The teacher's first-contact AI toolkit. Five cards, each a 4-part
// prompt template (role · context · task · constraints).
// Used in Section 5 (overview) and Section 8 (printable deck).
// ═══════════════════════════════════════════════════════════════════
import type { TechniqueKey } from '@/types/module.types';

export interface PromptCard {
  id:           string;
  number:       string;
  nameHe:       string;
  taglineHe:    string;
  whenToUseHe:  string;
  roleHe:       string;
  contextHe:    string;
  taskHe:       string;
  constraintsHe: string;
  exampleHe:    string;
  linkedMethod?: TechniqueKey;
}

export const PROMPT_CARDS: PromptCard[] = [
  {
    id: 'firstpass',
    number: '01',
    nameHe: 'מעבר ראשון',
    taglineHe: 'עשר רעיונות בשתי דקות. בלי שיפוט.',
    whenToUseHe: 'כשאתם תקועים בהתחלה ולא יודעים מאיפה להתחיל. כשהדף לבן והשעון רץ.',
    roleHe: 'את/ה עוזר/ת תכנון פדגוגי. המטרה: לעזור לי לעבור משלב הדף הלבן לשלב של אופציות.',
    contextHe: 'אני מורה ל[מקצוע] בכיתה [שכבה]. אני צריך/ה לתכנן [סוג פעילות] בנושא [נושא]. הכיתה: [תיאור קצר].',
    taskHe: 'תן/י לי 10 רעיונות שונים לאיך אפשר להתחיל את השיעור הזה. רק רעיונות. בלי הסברים ארוכים. בלי שיפוט אם זה "נכון".',
    constraintsHe: 'משך שיעור: 45 דקות. ציוד זמין: [רשימה]. רעיונות בעברית. גוון בין סוגים שונים של פתיחות.',
    exampleHe: 'אני מורה לאזרחות בכיתה י. אני צריכה לתכנן שיעור פתיחה ליחידה על דמוקרטיה. הכיתה ערה ומפולגת פוליטית. תן לי 10 רעיונות איך אפשר להתחיל את השיעור...',
  },
  {
    id: 'scamper',
    number: '02',
    nameHe: 'SCAMPER',
    taglineHe: 'קח שיעור קיים. שבע דרכים לשנות אותו.',
    whenToUseHe: 'יש שיעור שעובד "ברגיל" ואת/ה רוצה לרענן. או שיעור שלא עובד ואת/ה לא יודע/ת איפה לתפוס אותו.',
    roleHe: 'את/ה מומחה/ית בשיטת SCAMPER לחשיבה יצירתית. ידוע/ה לך שהאותיות מייצגות: Substitute, Combine, Adapt, Modify, Put to other use, Eliminate, Reverse.',
    contextHe: 'יש לי שיעור קיים בנושא [נושא] לכיתה [שכבה]. המבנה הנוכחי: [תיאור קצר].',
    taskHe: 'הפעל את SCAMPER על השיעור הזה. לכל אחת משבע האותיות — תן רעיון קונקרטי אחד לשינוי. בטבלה: אות, הרעיון, השפעה צפויה על התלמידים.',
    constraintsHe: 'רעיונות מעשיים לכיתה רגילה — לא תרגילים אקדמיים. עברית. רעיונות שאפשר ליישם השבוע.',
    exampleHe: 'יש לי שיעור על מחזור המים לכיתה ה. המבנה הנוכחי: סרטון, דף עבודה, סיכום על הלוח. הפעל SCAMPER...',
    linkedMethod: 'scamper',
  },
  {
    id: 'design',
    number: '03',
    nameHe: 'אמפתיה לתלמיד',
    taglineHe: 'מה התלמיד באמת חווה? לא מה אני חושבת.',
    whenToUseHe: 'כשתלמידים לא "נתפסים" ואת/ה לא בטוח/ה למה. כשהפער בין מה שתכננת לבין מה שקורה בשטח גדל.',
    roleHe: 'את/ה מומחה/ית ב-Design Thinking, ובמיוחד בשלב האמפתיה. את/ה יודע/ת שהשלב הזה מנסה להבין את החוויה האמיתית של המשתמש — לא מה שמתכנני הפעילות חשבו שיקרה.',
    contextHe: 'אני מתכנן/ת [פעילות / שיעור / שגרה] בנושא [נושא] לתלמיד טיפוסי בכיתה [שכבה]. תיאור התלמיד: [סוציו-אקונומי, רקע אקדמי, מצב חברתי].',
    taskHe: 'מפת אמפתיה לתלמיד הזה: (1) מה הוא רואה כשהוא נכנס לכיתה? (2) מה הוא שומע מחברים? (3) מה הוא חושב ומרגיש בפועל? (4) מה הוא אומר/עושה? (5) "כאבים" — מה מקשה עליו? (6) "רווחים" — מה הוא משיג אם זה יעבוד?',
    constraintsHe: 'בעברית. ספציפי, לא כללי. אם משהו לא ידוע — תגיד "לא יודע/ת, צריך לשאול אותו".',
    exampleHe: 'אני מתכננת יחידה על "שייכות וקליקות" לכיתה ז. התלמיד שבראש: ילד שעבר מבית ספר אחר באמצע שנה, חברתית בודד, ציונים בסדר. תני לי מפת אמפתיה...',
    linkedMethod: 'design',
  },
  {
    id: 'whatif',
    number: '04',
    nameHe: 'מה אם...',
    taglineHe: 'הפכי הנחה אחת. תראי מה נולד.',
    whenToUseHe: 'כשהשיעור "נכון" אבל משעמם. כשאת/ה רוצה לערער על משהו שתמיד היה ולגלות מה היה קורה אחרת.',
    roleHe: 'את/ה מנחה חשיבה יצירתית בשיטת "What If" — היפוך הנחות. את/ה יודע/ת שהשיטה לוקחת הנחה מובנת מאליה ושואלת "מה אם בדיוק ההפך?", ואז חוקרת מה יקרה.',
    contextHe: 'אני מורה ל[מקצוע]. ההנחה שאני רוצה להפוך: [הנחה — לדוגמה: "שיעורי בית עוזרים ללמוד".]',
    taskHe: 'נסחי לי 5 וריאציות של "מה אם בדיוק ההפך?". לכל אחת: (1) המשפט החדש, (2) מה היה משתנה בכיתה שלי, (3) רעיון אחד קונקרטי לפעילות שיעור שמשקפת את ההיפוך.',
    constraintsHe: 'בעברית. רעיונות שאני יכולה לנסות בשבועיים הקרובים, לא במציאות אחרת. אל תהיה/י נחמד/ה — תהיה/י פרובוקטיבי/ת.',
    exampleHe: 'מורה לתנ"ך, ההנחה שאני רוצה להפוך: "התלמידים צריכים ללמוד את הסיפור לפני שדנים בו". מה אם בדיוק ההפך?',
    linkedMethod: 'whatif',
  },
  {
    id: 'failure',
    number: '05',
    nameHe: 'תכנית כישלון',
    taglineHe: 'איך השיעור הזה יקרוס. ומה לעשות אז.',
    whenToUseHe: 'לפני שיעור חשוב או שיעור חדש. במקום לקוות שיעבוד — לתכנן איך הוא ייכשל. ככה לא מופתעים.',
    roleHe: 'את/ה יועץ/ת פדגוגי/ת מנוסה מאוד. את/ה הוקיר/ה את הכישלון כמקור מידע, לא כדבר שצריך להימנע ממנו.',
    contextHe: 'יש לי שיעור מתוכנן: [תיאור קצר של השיעור]. כיתה: [שכבה]. נושא: [נושא].',
    taskHe: 'תן/י לי 5 דרכים שונות שבהן השיעור הזה עלול לקרוס. לכל אחת: (1) התרחיש — מה יקרה, (2) הסיבה — למה זה יקרה, (3) תכנית B — מה לעשות בכיתה אם זה קורה.',
    constraintsHe: 'תהיה/י ספציפי/ת ובוטה. אל תייפה/יפי. תרחישים שקרו לאמיתי למורים אחרים בכיתות דומות. עברית.',
    exampleHe: 'יש לי שיעור פתוח בנושא "צניעות בעולם דיגיטלי" לכיתה ט. נושא רגיש. תן לי 5 דרכים שזה יכול לקרוס...',
  },
];

export const PROMPT_CARD_BY_ID: Record<string, PromptCard> = PROMPT_CARDS.reduce(
  (acc, c) => { acc[c.id] = c; return acc; },
  {} as Record<string, PromptCard>,
);
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

// Build ID — bump suffix on each deploy to guarantee a unique bundle hash.
// (Required after the M04 Cloudflare 502-mid-upload incident.)
console.log('M05 build 2026-05-19-1');

ReactDOM.createRoot(document.getElementById('root')!).render(
  <React.StrictMode>
    <App />
  </React.StrictMode>,
);
'@
Write-Source -Path 'src/router/ModuleRouter.tsx' -Body @'
// ═══════════════════════════════════════════════════════════════════
// ModuleRouter — hash routing for iframe-safety.
// All 8 sections lazy-loaded.
// ═══════════════════════════════════════════════════════════════════
import React, { lazy, Suspense } from 'react';
import { createHashRouter, Navigate, RouterProvider } from 'react-router-dom';
import ModuleShell from '@/components/ModuleShell/ModuleShell';

const OpeningSection  = lazy(() => import('@/sections/01-opening'));
const AppleSection    = lazy(() => import('@/sections/02-apple'));
const RootsSection    = lazy(() => import('@/sections/03-roots'));
const BreakSection    = lazy(() => import('@/sections/04-break'));
const AISection       = lazy(() => import('@/sections/05-ai'));
const MethodsSection  = lazy(() => import('@/sections/06-methods'));
const PersonalSection = lazy(() => import('@/sections/07-personal'));
const ClosingSection  = lazy(() => import('@/sections/08-closing'));

const withSuspense = (el: React.ReactNode) => (
  <Suspense fallback={null}>{el}</Suspense>
);

const router = createHashRouter([
  {
    path: '/',
    element: <ModuleShell />,
    children: [
      { index: true,      element: <Navigate to="/opening" replace /> },
      { path: 'opening',  element: withSuspense(<OpeningSection />)  },
      { path: 'apple',    element: withSuspense(<AppleSection />)    },
      { path: 'roots',    element: withSuspense(<RootsSection />)    },
      { path: 'break',    element: withSuspense(<BreakSection />)    },
      { path: 'ai',       element: withSuspense(<AISection />)       },
      { path: 'methods',  element: withSuspense(<MethodsSection />)  },
      { path: 'personal', element: withSuspense(<PersonalSection />) },
      { path: 'closing',  element: withSuspense(<ClosingSection />)  },
      { path: '*',        element: <Navigate to="/opening" replace /> },
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
Write-Source -Path 'src/sections/02-apple/AppleExercise.module.scss' -Body @'
.section {
  @include flex-col;
  gap: $space-5;
  padding: $space-6;
  background: $bg-surface;
  border: $border-hair;
  border-radius: $radius-md;
}

// ── PHASE TABS ─────────────────────────────────────────────────
.phaseTabs {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 0;
  border-bottom: $border-subtle;
}

.tab {
  @include focus-ring;
  display: flex;
  align-items: baseline;
  gap: $space-2;
  padding: $space-3 $space-4;
  background: none;
  border: none;
  border-bottom: 2px solid transparent;
  cursor: pointer;
  color: $ink-soft;
  transition: color $dur-fast $ease-out;
  text-align: start;

  &:hover:not(:disabled) { color: $ink-mid; }
  &:disabled { opacity: 0.4; cursor: not-allowed; }
}

.tabNum {
  font-family: $font-mono;
  font-size: 11px;
  color: $ink-faint;
  letter-spacing: 0.04em;
}

.tabLabel {
  font-family: $font-body;
  font-size: $text-sm;
  font-weight: $weight-regular;
}

.tabActive {
  color: $ink !important;
  border-bottom-color: $accent !important;

  .tabNum { color: $accent; }
  .tabLabel { font-weight: $weight-medium; }
}

// ── PHASE BODY ─────────────────────────────────────────────────
.phase {
  @include flex-col;
  gap: $space-4;
}

.phaseTitle {
  @include headline-subsection;

  em {
    @include accent-underline;
    font-style: normal;
    font-weight: $weight-regular;
  }
}

.phaseHint {
  @include body-paragraph;

  strong { font-weight: $weight-medium; color: $accent; }
}

// ── INPUTS ─────────────────────────────────────────────────────
.textarea {
  @include field-base;
  resize: vertical;
  min-height: 120px;
  line-height: $leading-loose;
}

.input { @include field-base; }

// ── ASSOC CHIPS ────────────────────────────────────────────────
.assocList {
  display: flex;
  flex-wrap: wrap;
  gap: $space-2;
  padding: $space-3 0;
  border-top: $border-subtle;
  border-bottom: $border-subtle;
}

.assocChip {
  @include focus-ring;
  padding: 6px 14px;
  background: transparent;
  border: 1px solid $line-strong;
  border-radius: $radius-pill;
  font-family: $font-body;
  font-size: $text-sm;
  color: $ink-mid;
  cursor: pointer;
  transition: all $dur-fast $ease-out;

  &:hover { border-color: $ink; color: $ink; }
}

.assocChipActive {
  background: $accent !important;
  border-color: $accent !important;
  color: $bg-canvas !important;
}

// ── FOOTER ─────────────────────────────────────────────────────
.phaseFooter {
  @include flex-between;
  gap: $space-3;
  padding-top: $space-3;
  border-top: $border-subtle;
}

.counter {
  font-family: $font-mono;
  font-size: $text-md;
  color: $ink;

  em {
    color: $ink-faint;
    font-style: normal;
    font-size: $text-sm;
  }
}

.next {
  @include btn-primary;
  display: inline-flex;
  align-items: center;
  gap: $space-2;

  svg { font-size: 16px; }
}

.back {
  @include btn-link;
}

.done {
  font-family: $font-body;
  font-size: $text-sm;
  color: $success;
  font-style: italic;
}

.gateHint {
  @include body-paragraph;
  font-size: $text-sm;
  color: $ink-soft;
  font-style: italic;
}
'@
Write-Source -Path 'src/sections/02-apple/AppleExercise.tsx' -Body @'
// ═══════════════════════════════════════════════════════════════════
// AppleExercise — interactive 3-phase divergent thinking exercise.
// Phase 1: brainstorm 20 associations to "תפוח"
// Phase 2: pick the most surprising one
// Phase 3: design a chair inspired by that association
// All state persists in localStorage so teachers can return.
// ═══════════════════════════════════════════════════════════════════
import React, { useEffect, useMemo, useState } from 'react';
import { TbArrowLeft } from 'react-icons/tb';
import styles from './AppleExercise.module.scss';

const KEY_ASSOC = 'binai.m05.apple.associations.v1';
const KEY_PICK  = 'binai.m05.apple.pick.v1';
const KEY_CHAIR = 'binai.m05.apple.chair.v1';

type Phase = 1 | 2 | 3;

function loadStr(key: string, fallback: string): string {
  try { return localStorage.getItem(key) ?? fallback; } catch { return fallback; }
}
function saveStr(key: string, value: string): void {
  try { localStorage.setItem(key, value); } catch { /* noop */ }
}

const AppleExercise: React.FC = () => {
  const [phase, setPhase] = useState<Phase>(1);
  const [associations, setAssociations] = useState<string>(() => loadStr(KEY_ASSOC, ''));
  const [pick, setPick]   = useState<string>(() => loadStr(KEY_PICK, ''));
  const [chair, setChair] = useState<string>(() => loadStr(KEY_CHAIR, ''));

  // ── auto-save ────────────────────────────────────────────────
  useEffect(() => { saveStr(KEY_ASSOC, associations); }, [associations]);
  useEffect(() => { saveStr(KEY_PICK,  pick);         }, [pick]);
  useEffect(() => { saveStr(KEY_CHAIR, chair);        }, [chair]);

  // ── derived: parse associations into list ────────────────────
  const associationItems = useMemo(
    () => associations.split(/[\n,]/).map(s => s.trim()).filter(Boolean),
    [associations],
  );

  const canAdvanceFrom1 = associationItems.length >= 10;
  const canAdvanceFrom2 = pick.trim().length > 0;

  return (
    <section className={styles.section}>
      <div className={styles.phaseTabs} aria-label="שלב נוכחי">
        {[1, 2, 3].map(n => (
          <button
            key={n}
            type="button"
            className={[styles.tab, phase === n && styles.tabActive].filter(Boolean).join(' ')}
            onClick={() => {
              if (n === 1) setPhase(1);
              if (n === 2 && canAdvanceFrom1) setPhase(2);
              if (n === 3 && canAdvanceFrom1 && canAdvanceFrom2) setPhase(3);
            }}
            disabled={
              (n === 2 && !canAdvanceFrom1) ||
              (n === 3 && !(canAdvanceFrom1 && canAdvanceFrom2))
            }
          >
            <span className={styles.tabNum}>0{n}</span>
            <span className={styles.tabLabel}>
              {n === 1 ? 'אסוציאציות' : n === 2 ? 'בחירה' : 'כסא חדש'}
            </span>
          </button>
        ))}
      </div>

      {/* PHASE 1 — associations */}
      {phase === 1 && (
        <div className={styles.phase}>
          <h3 className={styles.phaseTitle}>20 אסוציאציות לתפוח</h3>
          <p className={styles.phaseHint}>
            כתבו כל מה שעולה. אחד מתחת לשני, או מופרד בפסיקים. אל תסננו. אל תחשבו "האם זה נכון?".
            התרגיל הוא בדיוק להתאמן בלא לסנן.
          </p>
          <textarea
            className={styles.textarea}
            value={associations}
            onChange={e => setAssociations(e.target.value)}
            placeholder="ניוטון, אדום, תפוח אדמה, יום הולדת של אבא, גן עדן, שלגיה, אייפון..."
            rows={9}
          />
          <div className={styles.phaseFooter}>
            <span className={styles.counter}>
              {associationItems.length} <em>/ 20</em>
            </span>
            <button
              type="button"
              className={styles.next}
              onClick={() => setPhase(2)}
              disabled={!canAdvanceFrom1}
            >
              <span>בחרו אחת</span>
              <TbArrowLeft aria-hidden />
            </button>
          </div>
          {!canAdvanceFrom1 && (
            <p className={styles.gateHint}>צריך לפחות 10 כדי להתקדם. אל תוותרו על אף אחת בלי לכתוב.</p>
          )}
        </div>
      )}

      {/* PHASE 2 — pick */}
      {phase === 2 && (
        <div className={styles.phase}>
          <h3 className={styles.phaseTitle}>בחרו את המפתיעה ביותר</h3>
          <p className={styles.phaseHint}>
            לא הראשונה. לא ה"נכונה". זאת שגרמה לכם להגיד "מאיפה זה בא לי?".
            לחצו עליה למטה, או הקלידו ידנית.
          </p>

          <div className={styles.assocList}>
            {associationItems.map((a, i) => (
              <button
                key={i}
                type="button"
                className={[styles.assocChip, pick === a && styles.assocChipActive].filter(Boolean).join(' ')}
                onClick={() => setPick(a)}
              >
                {a}
              </button>
            ))}
          </div>

          <input
            type="text"
            className={styles.input}
            placeholder="או כתבו ידנית..."
            value={pick}
            onChange={e => setPick(e.target.value)}
          />

          <div className={styles.phaseFooter}>
            <button type="button" className={styles.back} onClick={() => setPhase(1)}>← חזרה</button>
            <button
              type="button"
              className={styles.next}
              onClick={() => setPhase(3)}
              disabled={!canAdvanceFrom2}
            >
              <span>תכננו כסא</span>
              <TbArrowLeft aria-hidden />
            </button>
          </div>
        </div>
      )}

      {/* PHASE 3 — chair */}
      {phase === 3 && (
        <div className={styles.phase}>
          <h3 className={styles.phaseTitle}>תכננו כסא בהשראת <em>{pick || '...'}</em></h3>
          <p className={styles.phaseHint}>
            לא ציור. מילים. איך הוא נראה? איך הוא מרגיש? מי יושב עליו? מאיזה חומר?
            <strong> 4 דקות.</strong>
          </p>
          <textarea
            className={styles.textarea}
            value={chair}
            onChange={e => setChair(e.target.value)}
            placeholder="הכסא הזה..."
            rows={8}
          />
          <div className={styles.phaseFooter}>
            <button type="button" className={styles.back} onClick={() => setPhase(2)}>← חזרה</button>
            <span className={styles.done}>{chair.trim().length > 50 ? 'נראה טוב.' : ''}</span>
          </div>
        </div>
      )}
    </section>
  );
};

export default AppleExercise;
'@
Write-Source -Path 'src/sections/02-apple/AppleIntro.module.scss' -Body @'
.section {
  @include flex-col;
  gap: $space-3;
}

.eyebrow {
  @include eyebrow;
}

.title {
  @include headline-section;
  font-weight: $weight-light;
}

.lede {
  @include lede;
  max-width: $content-narrow;

  em {
    @include accent-underline;
    font-style: normal;
  }
}

.steps {
  list-style: none;
  margin: $space-4 0 0;
  padding: 0;
  @include flex-col;
  gap: $space-3;
  counter-reset: appleStep;

  li {
    font-family: $font-body;
    font-size: $text-base;
    color: $ink-mid;
    padding-inline-start: $space-5;
    position: relative;
    line-height: $leading-loose;

    span {
      display: inline-block;
      min-width: 64px;
      @include eyebrow;
      color: $accent;
      margin-inline-end: $space-2;
    }
  }
}
'@
Write-Source -Path 'src/sections/02-apple/AppleIntro.tsx' -Body @'
import React from 'react';
import styles from './AppleIntro.module.scss';

const AppleIntro: React.FC = () => (
  <section className={styles.section}>
    <span className={styles.eyebrow}>תרגיל חי · ⌗ 1</span>
    <h2 className={styles.title}>
      התרגיל הקלאסי של סטנפורד d.school. מתפוח — אל כסא חדש.
    </h2>
    <p className={styles.lede}>
      שלושה שלבים. כל שלב מתקתק כשעון. <em>אל תחשבו טוב מדי.</em> אם תחשבו טוב,
      תקבלו בדיוק את התשובה שכל מורה אחר בארץ נותן. אם תחשבו <em>מהר</em>, תקבלו
      את שלכם.
    </p>

    <ol className={styles.steps}>
      <li><span>שלב 1</span> 20 אסוציאציות לתפוח, בשתי דקות. בלי לסנן.</li>
      <li><span>שלב 2</span> תבחרו אחת. הכי מפתיעה. הכי שלכם.</li>
      <li><span>שלב 3</span> תכננו כסא בהשראת האסוציאציה הזאת.</li>
    </ol>
  </section>
);

export default AppleIntro;
'@
Write-Source -Path 'src/sections/02-apple/AppleReflection.module.scss' -Body @'
.section {
  @include flex-col;
  gap: $space-5;
}

.eyebrow { @include eyebrow; }

.title {
  @include headline-section;
  font-weight: $weight-light;
}

// ── TWO COLUMNS ────────────────────────────────────────────────
.split {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: $space-7;
  padding: $space-5 0;
  border-top: $border-subtle;
  border-bottom: $border-subtle;

  @media (max-width: $bp-md) {
    grid-template-columns: 1fr;
    gap: $space-5;
  }
}

.col { @include flex-col; gap: $space-2; }

.colTitle {
  display: flex;
  align-items: baseline;
  gap: $space-2;
  font-family: $font-display;
  font-size: $text-xl;
  font-weight: $weight-regular;
  color: $ink;
}

.colNum {
  font-family: $font-mono;
  font-size: $text-base;
  color: $accent;
  letter-spacing: 0.02em;
}

.colSub {
  @include eyebrow;
  margin-bottom: $space-2;
}

.colBody {
  @include body-paragraph;

  em {
    @include accent-underline;
    font-style: normal;
  }
}

// ── TAKEAWAY ───────────────────────────────────────────────────
.takeaway {
  @include flex-col;
  gap: $space-3;
  padding: $space-5;
  background: $accent-faint;
  border-radius: $radius-md;

  p {
    @include body-paragraph;
    color: $ink;
  }

  strong {
    color: $accent-deep;
    font-weight: $weight-medium;
  }
}

.rule {
  @include micro-rule(40px);
}
'@
Write-Source -Path 'src/sections/02-apple/AppleReflection.tsx' -Body @'
// ═══════════════════════════════════════════════════════════════════
// AppleReflection — names what the exercise just demonstrated.
// Two opposite cognitive moves: divergent (the 20 associations) +
// convergent (picking ONE and building from it).
// ═══════════════════════════════════════════════════════════════════
import React from 'react';
import styles from './AppleReflection.module.scss';

const AppleReflection: React.FC = () => (
  <section className={styles.section}>
    <span className={styles.eyebrow}>מה עכשיו עשיתם, באמת</span>
    <h2 className={styles.title}>
      שני מצבי חשיבה הפוכים — בעשר דקות אחת.
    </h2>

    <div className={styles.split}>
      <div className={styles.col}>
        <h3 className={styles.colTitle}>
          <span className={styles.colNum}>01</span>
          חשיבה מסתעפת
        </h3>
        <p className={styles.colSub}>Divergent thinking</p>
        <p className={styles.colBody}>
          זה היה השלב הראשון. הרבה אופציות. בלי שיפוט. הראש פתוח. ככל שהרשימה
          ארוכה יותר, ככל שהיא <em>פראית יותר</em> — כך עלתה ההסתברות שתמצאו רעיון
          שאף מורה אחר בארץ לא יקבל.
        </p>
      </div>

      <div className={styles.col}>
        <h3 className={styles.colTitle}>
          <span className={styles.colNum}>02</span>
          חשיבה מתכנסת
        </h3>
        <p className={styles.colSub}>Convergent thinking</p>
        <p className={styles.colBody}>
          זה היה השלב השני והשלישי. בחירה אחת. בנייה ממנה. שיפוט חוזר. זה השלב
          שבו אנחנו, מורים, רגילים לחיות. אנחנו <em>מצוינים בו</em>. אבל בלי
          השלב הראשון, אין ממה לבחור.
        </p>
      </div>
    </div>

    <aside className={styles.takeaway}>
      <hr className={styles.rule} aria-hidden />
      <p>
        <strong>הטעות הנפוצה ביותר</strong> שאני רואה אצל מורים: לקפוץ ישר לבחירה.
        להציע פתרון אחד ולעבוד עליו. כשאתם לא יודעים מה לעשות בכיתה — זה כי
        קפצתם לבחירה מבלי לעבור קודם דרך הסתעפות. AI יקל בדיוק על השלב הזה.
        על להסתעף מהר. על להציע 50 רעיונות לפני שאתם בוחרים אחד.
      </p>
    </aside>
  </section>
);

export default AppleReflection;
'@
Write-Source -Path 'src/sections/02-apple/index.tsx' -Body @'
// ═══════════════════════════════════════════════════════════════════
// Section 02 — תפוח → אסוציאציות → כסא (20 min)
// Live divergent thinking. Teacher does the exercise themselves
// before any theory is introduced.
// ═══════════════════════════════════════════════════════════════════
import React from 'react';
import SectionShell from '@/components/SectionShell/SectionShell';
import AppleIntro from './AppleIntro';
import AppleExercise from './AppleExercise';
import AppleReflection from './AppleReflection';

const AppleSection: React.FC = () => (
  <SectionShell id="apple">
    <AppleIntro />
    <AppleExercise />
    <AppleReflection />
  </SectionShell>
);

export default AppleSection;
'@
Write-Source -Path 'src/sections/03-roots/CaseStudies.module.scss' -Body @'
.section {
  @include flex-col;
  gap: $space-5;
}

// ── HEAD ───────────────────────────────────────────────────────
.head { @include flex-col; gap: $space-3; }

.eyebrow { @include eyebrow; }
.title   { @include headline-section; font-weight: $weight-light; }

.lede {
  @include lede;
  max-width: $content-narrow;

  em {
    @include accent-underline;
    font-style: normal;
  }
}

// ── GRID ───────────────────────────────────────────────────────
.grid {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: $space-5;

  @media (max-width: $bp-md) {
    grid-template-columns: 1fr;
  }
}

.case {
  @include flex-col;
  gap: $space-3;
  padding: $space-5;
  background: $bg-surface;
  border: $border-hair;
  border-radius: $radius-md;
}

.caseHead {
  @include flex-between;
  align-items: baseline;
  padding-bottom: $space-2;
  border-bottom: $border-subtle;
}

.brand {
  font-family: $font-display;
  font-size: $text-lg;
  font-weight: $weight-regular;
  color: $ink;
}

.year {
  font-family: $font-mono;
  font-size: 11px;
  color: $ink-faint;
  letter-spacing: 0.04em;
}

.domain {
  @include eyebrow;
  color: $accent;
  margin-bottom: $space-2;
}

// ── ROWS ───────────────────────────────────────────────────────
.row {
  @include flex-col;
  gap: 2px;
  padding: $space-2 0;
}

.rowLabel {
  @include eyebrow;
  color: $ink-soft;
}

.rowBody {
  @include body-paragraph;
  font-size: $text-sm;
}

.rowImpact {
  @include body-paragraph;
  font-size: $text-sm;
  color: $ink;
  font-weight: $weight-medium;
}

.source {
  @include eyebrow;
  margin-top: $space-2;
  padding-top: $space-2;
  border-top: $border-subtle;
  color: $ink-faint;
  font-size: 10px;
  text-transform: none;
  letter-spacing: 0.04em;
}
'@
Write-Source -Path 'src/sections/03-roots/CaseStudies.tsx' -Body @'
// ═══════════════════════════════════════════════════════════════════
// CaseStudies — 4 brands, 4 constraints, 4 creative responses.
// ═══════════════════════════════════════════════════════════════════
import React from 'react';
import { CASES } from '@/data/cases';
import styles from './CaseStudies.module.scss';

const CaseStudies: React.FC = () => (
  <section className={styles.section}>
    <header className={styles.head}>
      <span className={styles.eyebrow}>מאיפה זה צומח, באמת</span>
      <h2 className={styles.title}>יצירתיות מתעוררת ממגבלה, לא ממרחב פתוח.</h2>
      <p className={styles.lede}>
        ארבעה מקרים שכמעט לא היו נולדים בלי המגבלה שלהם. <em>אותה לוגיקה</em>
        עובדת בכיתה — שלכם.
      </p>
    </header>

    <div className={styles.grid}>
      {CASES.map(c => (
        <article key={c.id} className={styles.case}>
          <header className={styles.caseHead}>
            <h3 className={styles.brand}>{c.brandHe}</h3>
            <span className={styles.year}>{c.yearStarted}</span>
          </header>
          <span className={styles.domain}>{c.domainHe}</span>

          <div className={styles.row}>
            <span className={styles.rowLabel}>המגבלה</span>
            <p className={styles.rowBody}>{c.constraintHe}</p>
          </div>
          <div className={styles.row}>
            <span className={styles.rowLabel}>התגובה</span>
            <p className={styles.rowBody}>{c.responseHe}</p>
          </div>
          <div className={styles.row}>
            <span className={styles.rowLabel}>התוצאה</span>
            <p className={styles.rowImpact}>{c.impactHe}</p>
          </div>

          {c.source && <p className={styles.source}>{c.source}</p>}
        </article>
      ))}
    </div>
  </section>
);

export default CaseStudies;
'@
Write-Source -Path 'src/sections/03-roots/ConstraintFramework.module.scss' -Body @'
.section {
  @include flex-col;
  gap: $space-5;
  margin-top: $space-3;
}

.eyebrow { @include eyebrow; }
.title   { @include headline-section; font-weight: $weight-light; }

// ── FLOW ───────────────────────────────────────────────────────
.flow {
  list-style: none;
  margin: 0;
  padding: 0;
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: $space-3;

  @media (max-width: $bp-md) {
    grid-template-columns: 1fr;
    gap: $space-4;
  }
}

.stage {
  @include flex-col;
  gap: $space-3;
  padding: $space-4;
  background: $bg-surface;
  border: $border-hair;
  border-radius: $radius-md;
  position: relative;
}

.stageHead {
  display: flex;
  align-items: baseline;
  gap: $space-2;
}

.num {
  font-family: $font-mono;
  font-size: $text-sm;
  color: $accent;
  letter-spacing: 0.02em;
}

.stageTitle {
  font-family: $font-display;
  font-size: $text-md;
  font-weight: $weight-regular;
  color: $ink;
}

.stageBody {
  @include body-paragraph;
  font-size: $text-sm;
}

// Arrow between stages
.arrow {
  position: absolute;
  left: -14px;   // RTL: points to the next stage (which sits on the left)
  top: 50%;
  transform: translateY(-50%);
  font-family: $font-mono;
  color: $accent;
  font-size: 18px;
  pointer-events: none;

  @media (max-width: $bp-md) {
    left: 50%;
    top: auto;
    bottom: -22px;
    transform: translateX(-50%) rotate(-90deg);
  }
}

// ── CODA ───────────────────────────────────────────────────────
.coda {
  @include body-paragraph;
  padding: $space-4 $space-5;
  background: $accent-faint;
  border-radius: $radius-md;
  color: $ink;

  strong {
    font-weight: $weight-medium;
    color: $accent-deep;
  }
}
'@
Write-Source -Path 'src/sections/03-roots/ConstraintFramework.tsx' -Body @'
// ═══════════════════════════════════════════════════════════════════
// ConstraintFramework — names the underlying process:
//   Constraint → Diverge → Converge → Test
// 4 stages displayed as a horizontal flow with light typography.
// ═══════════════════════════════════════════════════════════════════
import React from 'react';
import styles from './ConstraintFramework.module.scss';

interface Stage {
  number: string;
  titleHe: string;
  bodyHe: string;
}

const STAGES: Stage[] = [
  {
    number: '01',
    titleHe: 'מגבלה',
    bodyHe: 'מה אי אפשר? מה אסור? מה שינו? המגבלה היא נקודת ההתחלה — לא בעיה שצריך לפתור, אלא הפרמטר שמולו מעצבים.',
  },
  {
    number: '02',
    titleHe: 'הסתעפות',
    bodyHe: 'כמה אופציות שאפשר. מהר. בלי שיפוט. ארוך לפני שצר. רחב לפני שעמוק. שלב התפוח-וה-20-אסוציאציות.',
  },
  {
    number: '03',
    titleHe: 'התכנסות',
    bodyHe: 'בחירה אחת מתוך הרבות. לפי מה? לפי המגבלה. מה שעובד הכי טוב מולה — נשאר.',
  },
  {
    number: '04',
    titleHe: 'בדיקה',
    bodyHe: 'מנסים. רואים. כושלים מהר. למה כושלים? המידע הזה הופך לכניסה למחזור הבא — לא לסיום הרעיון.',
  },
];

const ConstraintFramework: React.FC = () => (
  <section className={styles.section}>
    <span className={styles.eyebrow}>התהליך שמתחת לכולם</span>
    <h2 className={styles.title}>ארבעה שלבים. אותם ארבעה, כל פעם.</h2>

    <ol className={styles.flow}>
      {STAGES.map((s, i) => (
        <li key={s.number} className={styles.stage}>
          <div className={styles.stageHead}>
            <span className={styles.num}>{s.number}</span>
            <h3 className={styles.stageTitle}>{s.titleHe}</h3>
          </div>
          <p className={styles.stageBody}>{s.bodyHe}</p>
          {i < STAGES.length - 1 && <span className={styles.arrow} aria-hidden>←</span>}
        </li>
      ))}
    </ol>

    <p className={styles.coda}>
      בכיתה: <strong>"אין לי זמן" / "אין לי תקציב" / "התלמידים לא מקשיבים" —</strong>
      הן לא בעיות. הן המגבלות שמולן השיעור הבא שלכם יצמח.
    </p>
  </section>
);

export default ConstraintFramework;
'@
Write-Source -Path 'src/sections/03-roots/index.tsx' -Body @'
// ═══════════════════════════════════════════════════════════════════
// Section 03 — מאיפה צומחת יצירתיות? (15 min)
// Constraints as fuel. Four case studies + the underlying process.
// ═══════════════════════════════════════════════════════════════════
import React from 'react';
import SectionShell from '@/components/SectionShell/SectionShell';
import CaseStudies from './CaseStudies';
import ConstraintFramework from './ConstraintFramework';

const RootsSection: React.FC = () => (
  <SectionShell id="roots">
    <CaseStudies />
    <ConstraintFramework />
  </SectionShell>
);

export default RootsSection;
'@
Write-Source -Path 'src/sections/04-break/ClassPicker.module.scss' -Body @'
.form {
  @include flex-col;
  gap: $space-5;
  padding: $space-6;
  background: $bg-surface;
  border: $border-hair;
  border-radius: $radius-md;
}

.head { @include flex-col; gap: $space-2; }

.eyebrow { @include eyebrow; }
.title   { @include headline-subsection; font-weight: $weight-regular; }

// ── FIELDS ─────────────────────────────────────────────────────
.fields {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: $space-4 $space-5;

  @media (max-width: $bp-md) {
    grid-template-columns: 1fr;
  }
}

.field {
  @include flex-col;
  gap: $space-1;
}

.fieldWide { grid-column: 1 / -1; }

.label {
  @include eyebrow;
  text-transform: none;
  letter-spacing: 0.02em;
  font-size: $text-xs;
  color: $ink-mid;

  em {
    color: $accent;
    font-style: normal;
    font-weight: $weight-medium;
  }
}

.optional {
  color: $ink-faint;
  font-size: 10px;
  font-weight: $weight-light;
}

.input    { @include field-base; }
.textarea { @include field-base; resize: vertical; line-height: $leading-loose; }

// ── TIERS ──────────────────────────────────────────────────────
.tiers {
  display: flex;
  gap: $space-2;
  flex-wrap: wrap;
  margin-top: $space-1;
}

.tier {
  @include focus-ring;
  padding: 8px 14px;
  background: transparent;
  border: 1px solid $line-strong;
  border-radius: $radius-pill;
  font-family: $font-body;
  font-size: $text-sm;
  color: $ink-mid;
  cursor: pointer;
  transition: all $dur-fast $ease-out;

  &:hover { border-color: $ink; color: $ink; }
}

.tierActive {
  background: $ink !important;
  border-color: $ink !important;
  color: $bg-canvas !important;
}
'@
Write-Source -Path 'src/sections/04-break/ClassPicker.tsx' -Body @'
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
'@
Write-Source -Path 'src/sections/04-break/index.module.scss' -Body @'
.breakBanner {
  @include flex-col;
  gap: $space-3;
  padding: $space-7 $space-5;
  background: $bg-subtle;
  border-radius: $radius-md;
  text-align: center;
}

.eyebrow {
  @include eyebrow;
  color: $accent;
}

.bannerTitle {
  @include headline-section;
  font-weight: $weight-light;
}

.bannerBody {
  @include body-paragraph;
  max-width: $content-narrow;
  margin: 0 auto;
}

.gateHint {
  @include body-paragraph;
  font-size: $text-sm;
  color: $ink-soft;
  font-style: italic;
  text-align: center;
  margin-top: $space-3;
}
'@
Write-Source -Path 'src/sections/04-break/index.tsx' -Body @'
// ═══════════════════════════════════════════════════════════════════
// Section 04 — הפסקה + בחירת הכיתה (15 min)
// Short break + form to capture which class/topic the teacher will
// work on for the rest of the workshop. Gates Next button.
// ═══════════════════════════════════════════════════════════════════
import React, { useState } from 'react';
import SectionShell from '@/components/SectionShell/SectionShell';
import { useProgressCtx } from '@/components/ModuleShell/ModuleProgressContext';
import type { CustomTopic } from '@/types/module.types';
import ClassPicker from './ClassPicker';
import styles from './index.module.scss';

const BreakSection: React.FC = () => {
  const { progress, setCustomTopic } = useProgressCtx();
  const [topic, setTopic] = useState<CustomTopic | null>(progress.customTopic);

  const isValid = !!topic
    && topic.subject.trim() !== ''
    && topic.grade.trim() !== ''
    && topic.topic.trim() !== '';

  const handleChange = (next: CustomTopic) => {
    setTopic(next);
    setCustomTopic(next);
  };

  return (
    <SectionShell id="break" canAdvance={isValid}>
      <section className={styles.breakBanner}>
        <span className={styles.eyebrow}>הפסקה</span>
        <h2 className={styles.bannerTitle}>קחו 10 דקות.</h2>
        <p className={styles.bannerBody}>
          אוויר. מים. ארוחה קלה. כשתחזרו — נמלא יחד את הטופס למטה. הוא יקבע
          על איזו כיתה ועל איזה נושא תעבדו בחלק האחרון של ההשתלמות.
        </p>
      </section>

      <ClassPicker value={topic} onChange={handleChange} />

      {!isValid && (
        <p className={styles.gateHint}>
          ⌗ אי אפשר להתקדם בלי למלא את הטופס. שלושה שדות חובה: מקצוע, שכבה, ונושא.
        </p>
      )}
    </SectionShell>
  );
};

export default BreakSection;
'@
Write-Source -Path 'src/sections/05-ai/AIReframe.module.scss' -Body @'
.section {
  @include flex-col;
  gap: $space-5;
}

.head { @include flex-col; gap: $space-3; }

.eyebrow { @include eyebrow; }

.title {
  @include headline-section;
  font-weight: $weight-light;

  em {
    @include accent-underline;
    font-style: normal;
  }
}

.lede {
  @include lede;
  max-width: $content-narrow;

  em { color: $ink; font-style: italic; }
}

// ── SPLIT ──────────────────────────────────────────────────────
.split {
  display: grid;
  grid-template-columns: 1fr 1px 1fr;
  gap: $space-6;
  padding: $space-5 0;

  @media (max-width: $bp-md) {
    grid-template-columns: 1fr;
    gap: $space-5;
  }
}

.col { @include flex-col; gap: $space-3; }

.colTag {
  @include eyebrow;
  color: $ink-soft;
}

.colTagAccent { color: $accent; }

.list {
  list-style: none;
  margin: 0;
  padding: 0;
  @include flex-col;
  gap: $space-2;

  li {
    @include body-paragraph;
    padding: 6px 0;
    border-bottom: $border-subtle;

    &:last-child { border-bottom: none; }
  }
}

.colCoda {
  @include body-paragraph;
  font-size: $text-sm;
  margin-top: $space-3;
  padding-top: $space-3;
  border-top: $border-subtle;
  color: $ink;
  font-style: italic;

  strong {
    font-weight: $weight-medium;
    color: $accent-deep;
    font-style: normal;
  }
}

.divider {
  background: $line;
  width: 1px;

  @media (max-width: $bp-md) { display: none; }
}
'@
Write-Source -Path 'src/sections/05-ai/AIReframe.tsx' -Body @'
// ═══════════════════════════════════════════════════════════════════
// AIReframe — explicit two-column contrast:
//   What AI WON'T know (you stay irreplaceable)
//   What AI WILL help with (the leverage)
// ═══════════════════════════════════════════════════════════════════
import React from 'react';
import styles from './AIReframe.module.scss';

const CANNOT = [
  'את שמות התלמידים שלכם, את הסיפור של כל אחד',
  'איזה משפט עבד בשבוע שעבר ואיזה צרם',
  'את האנרגיה של כיתה ערה שעה אחרי הצהריים',
  'מי קם הבוקר בלי ארוחת בוקר ולמה',
  'את ההומור הספציפי שלכם, את מה שמרגיש כמוכם',
];

const CAN = [
  'לייצר 50 וריאציות של פתיחה לשיעור בשתי דקות',
  'להציע אנלוגיות שלא היו עולות לכם בראש',
  'להחזיק כמה רעיונות במקביל בלי לאבד אף אחד',
  'לעזור לכם לראות את השיעור מנקודת המבט של תלמיד',
  'לתכנן "תכנית כישלון" — איך זה יקרוס, ומה לעשות אז',
];

const AIReframe: React.FC = () => (
  <section className={styles.section}>
    <header className={styles.head}>
      <span className={styles.eyebrow}>עכשיו AI נכנס</span>
      <h2 className={styles.title}>לא <em>במקומכם</em>. <em>איתכם</em>.</h2>
      <p className={styles.lede}>
        בארבעת החלקים הקודמים תרגלתם חשיבה יצירתית — לבד. עכשיו נראה איך כלי
        אחד יכול להכפיל את היכולת הזאת. אבל לפני שמתחילים, חשוב להיות ברור על
        מה הוא <em>לא</em> ידע ומה הוא <em>כן</em>.
      </p>
    </header>

    <div className={styles.split}>
      <div className={styles.col}>
        <span className={styles.colTag}>AI לא ידע</span>
        <ul className={styles.list}>
          {CANNOT.map((t, i) => <li key={i}>{t}</li>)}
        </ul>
        <p className={styles.colCoda}>
          לכן <strong>אתם</strong> חייבים להישאר בלולאה. הוא לא יחליף אתכם —
          הוא יציע, ואתם תבחרו.
        </p>
      </div>

      <div className={styles.divider} aria-hidden />

      <div className={styles.col}>
        <span className={[styles.colTag, styles.colTagAccent].join(' ')}>AI יעזור עם</span>
        <ul className={styles.list}>
          {CAN.map((t, i) => <li key={i}>{t}</li>)}
        </ul>
        <p className={styles.colCoda}>
          <strong>זה החלק שעוצר אתכם עכשיו</strong> כשהדף לבן. בדיוק שם הוא
          הכי שימושי.
        </p>
      </div>
    </div>
  </section>
);

export default AIReframe;
'@
Write-Source -Path 'src/sections/05-ai/PromptCardDeck.module.scss' -Body @'
.section { @include flex-col; gap: $space-5; }

.head    { @include flex-col; gap: $space-3; }
.eyebrow { @include eyebrow; }
.title   { @include headline-section; font-weight: $weight-light; }

.lede {
  @include lede;
  max-width: $content-narrow;
}

// ── DECK LIST ──────────────────────────────────────────────────
.deck {
  list-style: none;
  margin: 0;
  padding: 0;
  @include flex-col;
  gap: $space-3;
}

.deckItem {
  display: grid;
  grid-template-columns: 40px 1fr;
  gap: $space-4;
  padding: $space-4 0;
  border-bottom: $border-subtle;

  &:last-child { border-bottom: none; }
}

.deckNum {
  font-family: $font-mono;
  font-size: $text-base;
  font-weight: $weight-regular;
  color: $accent;
  letter-spacing: 0.02em;
}

.deckBody { @include flex-col; gap: $space-1; min-width: 0; }

.deckName {
  font-family: $font-display;
  font-size: $text-md;
  font-weight: $weight-medium;
  color: $ink;
  line-height: $leading-tight;
}

.deckTag {
  @include body-paragraph;
  font-size: $text-sm;
  color: $ink;
  font-style: italic;
}

.deckWhen {
  @include body-paragraph;
  font-size: $text-sm;
  color: $ink-soft;
  margin-top: $space-1;
}

// ── FULL CARD WRAPPER ──────────────────────────────────────────
.full {
  @include flex-col;
  gap: $space-3;
  margin-top: $space-4;
  padding-top: $space-5;
  border-top: $border-subtle;
}

.fullEyebrow {
  @include eyebrow;
  color: $accent;
}

// ── BRIDGE ─────────────────────────────────────────────────────
.bridge {
  @include body-paragraph;
  font-style: italic;
  margin-top: $space-3;
  padding: $space-4 0;
  border-top: $border-subtle;
}
'@
Write-Source -Path 'src/sections/05-ai/PromptCardDeck.tsx' -Body @'
// ═══════════════════════════════════════════════════════════════════
// PromptCardDeck — introduces the 5-card prompt toolkit.
//   - List of 5 with name + tagline + when-to-use
//   - Card 1 ("First Pass") shown fully via PromptCard component
// ═══════════════════════════════════════════════════════════════════
import React from 'react';
import { PROMPT_CARDS, PROMPT_CARD_BY_ID } from '@/data/promptCards';
import PromptCard from '@/components/PromptCard/PromptCard';
import styles from './PromptCardDeck.module.scss';

const PromptCardDeck: React.FC = () => {
  const firstPass = PROMPT_CARD_BY_ID['firstpass'];

  return (
    <section className={styles.section}>
      <header className={styles.head}>
        <span className={styles.eyebrow}>הקיט · חמש כרטיסיות</span>
        <h2 className={styles.title}>חמש כרטיסיות פרומפט. הקיט הבסיסי.</h2>
        <p className={styles.lede}>
          כל כרטיסייה — מבנה של פרומפט אחד שמכוסה לסיטואציה ספציפית.
          ארבע מהן יעלו בחלק הבא דרך השיטות. את הראשונה — נצלול לתוכה עכשיו.
        </p>
      </header>

      <ul className={styles.deck}>
        {PROMPT_CARDS.map(c => (
          <li key={c.id} className={styles.deckItem}>
            <span className={styles.deckNum}>{c.number}</span>
            <div className={styles.deckBody}>
              <h3 className={styles.deckName}>{c.nameHe}</h3>
              <p className={styles.deckTag}>{c.taglineHe}</p>
              <p className={styles.deckWhen}>{c.whenToUseHe}</p>
            </div>
          </li>
        ))}
      </ul>

      <div className={styles.full}>
        <span className={styles.fullEyebrow}>כרטיסייה 01 · במלואה</span>
        <PromptCard
          prompt={{
            roleHe: firstPass.roleHe,
            contextHe: firstPass.contextHe,
            taskHe: firstPass.taskHe,
            constraintsHe: firstPass.constraintsHe,
          }}
          nameHe={firstPass.nameHe}
          exampleHe={firstPass.exampleHe}
        />
      </div>

      <p className={styles.bridge}>
        בחלק הבא — שלוש מתוך ארבע הכרטיסיות הנותרות, כל אחת על אתגר כיתתי
        אמיתי. כדי להבין איך הן עובדות בשטח.
      </p>
    </section>
  );
};

export default PromptCardDeck;
'@
Write-Source -Path 'src/sections/05-ai/index.tsx' -Body @'
// ═══════════════════════════════════════════════════════════════════
// Section 05 — AI נכנס למשחק (25 min)
// First contact with AI. Framed explicitly as creativity AMPLIFIER,
// not replacement. Then introduces the 5 prompt cards toolkit.
// ═══════════════════════════════════════════════════════════════════
import React from 'react';
import SectionShell from '@/components/SectionShell/SectionShell';
import AIReframe from './AIReframe';
import PromptCardDeck from './PromptCardDeck';

const AISection: React.FC = () => (
  <SectionShell id="ai">
    <AIReframe />
    <PromptCardDeck />
  </SectionShell>
);

export default AISection;
'@
Write-Source -Path 'src/sections/06-methods/MethodDemo.module.scss' -Body @'
.demo {
  @include flex-col;
  gap: $space-5;
  padding: $space-6;
  background: $bg-surface;
  border: $border-hair;
  border-radius: $radius-md;
}

// ── HEAD ───────────────────────────────────────────────────────
.head {
  display: grid;
  grid-template-columns: 56px 1fr;
  gap: $space-4;
  align-items: baseline;
  padding-bottom: $space-4;
  border-bottom: $border-subtle;
}

.num {
  font-family: $font-display;
  font-size: $text-3xl;
  font-weight: $weight-light;
  color: $accent;
  line-height: 0.9;
  letter-spacing: -0.02em;
}

.headBody { @include flex-col; gap: $space-1; min-width: 0; }

.name {
  font-family: $font-display;
  font-size: $text-xl;
  font-weight: $weight-regular;
  color: $ink;
}

.tagline {
  @include body-paragraph;
  font-size: $text-sm;
  color: $ink-mid;
  font-style: italic;
}

// ── WHEN BOX ───────────────────────────────────────────────────
.whenBox {
  @include flex-col;
  gap: $space-1;
  padding: $space-3 $space-4;
  background: $accent-faint;
  border-radius: $radius-sm;
}

.whenLabel { @include eyebrow; color: $accent; }
.whenBody  { @include body-paragraph; font-size: $text-sm; }

// ── BEAT ───────────────────────────────────────────────────────
.beat { @include flex-col; gap: $space-3; }

.beatTag {
  @include eyebrow;
  color: $ink-soft;
}

.challenge {
  @include body-paragraph;
  font-family: $font-display;
  font-weight: $weight-light;
  font-size: $text-md;
  color: $ink;
  font-style: italic;
  padding-inline-start: $space-4;
  border-inline-start: 2px solid $accent;
}

.context {
  font-family: $font-mono;
  font-size: 11px;
  color: $ink-soft;
  letter-spacing: 0.04em;
}

// ── OUTPUTS ────────────────────────────────────────────────────
.outputs {
  list-style: none;
  margin: 0;
  padding: 0;
  @include flex-col;
  gap: $space-3;
}

.output {
  display: grid;
  grid-template-columns: 140px 1fr;
  gap: $space-4;
  padding: $space-3 0;
  border-bottom: $border-subtle;

  &:last-child { border-bottom: none; }

  @media (max-width: $bp-md) {
    grid-template-columns: 1fr;
    gap: $space-1;
  }
}

.outputLabel {
  font-family: $font-mono;
  font-size: $text-xs;
  font-weight: $weight-medium;
  color: $accent;
  letter-spacing: 0.02em;
  padding-top: 4px;
}

.outputValue {
  @include body-paragraph;
  font-size: $text-sm;
}

// ── REFLECTION ─────────────────────────────────────────────────
.reflection {
  @include flex-col;
  gap: $space-2;
  padding: $space-4 $space-5;
  background: $bg-subtle;
  border-radius: $radius-sm;
  border-inline-start: 2px solid $ink-faint;

  p {
    @include body-paragraph;
    font-size: $text-sm;
    color: $ink;
    font-style: italic;
  }
}

.reflectionLabel {
  @include eyebrow;
  color: $ink-soft;
}
'@
Write-Source -Path 'src/sections/06-methods/MethodDemo.tsx' -Body @'
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
'@
Write-Source -Path 'src/sections/06-methods/MethodsIntro.module.scss' -Body @'
.section { @include flex-col; gap: $space-3; }

.eyebrow { @include eyebrow; }
.title   { @include headline-section; font-weight: $weight-light; }

.lede {
  @include lede;
  max-width: $content-narrow;

  em {
    @include accent-underline;
    font-style: normal;
  }
}

.previewList {
  list-style: none;
  margin: $space-3 0 0;
  padding: 0;
  @include flex-col;
  gap: $space-2;

  li {
    @include body-paragraph;
    padding: $space-2 0;
    border-bottom: $border-subtle;

    strong {
      font-weight: $weight-medium;
      color: $ink;
    }

    &:last-child { border-bottom: none; }
  }
}
'@
Write-Source -Path 'src/sections/06-methods/MethodsIntro.tsx' -Body @'
import React from 'react';
import styles from './MethodsIntro.module.scss';

const MethodsIntro: React.FC = () => (
  <section className={styles.section}>
    <span className={styles.eyebrow}>שלוש שיטות לכיתה</span>
    <h2 className={styles.title}>שיטות חשיבה יצירתית — שלוש שעובדות.</h2>
    <p className={styles.lede}>
      יש עשרות שיטות חשיבה יצירתית. את שלוש השיטות הבאות בחרנו כי הן <em>פותרות
      בעיות שונות</em> ויחד נותנות לכם כיסוי רחב. לכל אחת — אתגר כיתתי אמיתי,
      הפרומפט שמתאים לה, התוצאה ש-AI החזיר, ושיעור מוכן.
    </p>
    <ul className={styles.previewList}>
      <li><strong>SCAMPER</strong> · כשרוצים לרענן שיעור קיים.</li>
      <li><strong>Design Thinking · אמפתיה</strong> · כשרוצים להבין את התלמיד לפני שמתכננים.</li>
      <li><strong>"מה אם..."</strong> · כשרוצים לערער על משהו שתמיד היה.</li>
    </ul>
  </section>
);

export default MethodsIntro;
'@
Write-Source -Path 'src/sections/06-methods/index.module.scss' -Body @'
.demos {
  @include flex-col;
  gap: $space-8;
}
'@
Write-Source -Path 'src/sections/06-methods/index.tsx' -Body @'
// ═══════════════════════════════════════════════════════════════════
// Section 06 — שלוש שיטות (35 min)
// SCAMPER · Design Thinking · "What If"
// Each method demonstrated on a real classroom challenge.
// ═══════════════════════════════════════════════════════════════════
import React from 'react';
import SectionShell from '@/components/SectionShell/SectionShell';
import { ALL_DEMOS } from '@/data/methods';
import MethodsIntro from './MethodsIntro';
import MethodDemo from './MethodDemo';
import styles from './index.module.scss';

const MethodsSection: React.FC = () => (
  <SectionShell id="methods">
    <MethodsIntro />
    <div className={styles.demos}>
      {ALL_DEMOS.map((demo, i) => (
        <MethodDemo key={demo.id} demo={demo} index={i + 1} />
      ))}
    </div>
  </SectionShell>
);

export default MethodsSection;
'@
Write-Source -Path 'src/sections/07-personal/MethodSelector.module.scss' -Body @'
.section { @include flex-col; gap: $space-3; }

.eyebrow { @include eyebrow; }

.grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: $space-3;

  @media (max-width: $bp-md) {
    grid-template-columns: 1fr;
  }
}

.card {
  @include focus-ring;
  @include flex-col;
  gap: $space-2;
  padding: $space-4 $space-5;
  background: $bg-surface;
  border: $border-hair;
  border-radius: $radius-md;
  text-align: start;
  cursor: pointer;
  transition: all $dur-fast $ease-out;

  &:hover {
    border-color: $ink-mid;
  }
}

.cardActive {
  background: $ink !important;
  border-color: $ink !important;

  .name    { color: $bg-canvas; }
  .tagline { color: rgba(252, 251, 248, 0.85); }
  .when    { color: rgba(252, 251, 248, 0.65); }
}

.name {
  font-family: $font-display;
  font-size: $text-md;
  font-weight: $weight-medium;
  color: $ink;
}

.tagline {
  font-family: $font-body;
  font-size: $text-sm;
  color: $ink-mid;
  font-style: italic;
}

.when {
  @include body-paragraph;
  font-size: $text-xs;
  color: $ink-soft;
  margin-top: $space-1;
}
'@
Write-Source -Path 'src/sections/07-personal/MethodSelector.tsx' -Body @'
import React from 'react';
import { ALL_DEMOS } from '@/data/methods';
import type { TechniqueKey } from '@/types/module.types';
import styles from './MethodSelector.module.scss';

interface Props {
  selected: TechniqueKey | null;
  onSelect: (t: TechniqueKey) => void;
}

const MethodSelector: React.FC<Props> = ({ selected, onSelect }) => (
  <section className={styles.section}>
    <span className={styles.eyebrow}>שלב 1 · בחרו שיטה</span>
    <div className={styles.grid}>
      {ALL_DEMOS.map(d => {
        const isActive = selected === d.id;
        return (
          <button
            key={d.id}
            type="button"
            className={[styles.card, isActive && styles.cardActive].filter(Boolean).join(' ')}
            onClick={() => onSelect(d.id)}
            aria-pressed={isActive}
          >
            <h3 className={styles.name}>{d.nameHe}</h3>
            <p className={styles.tagline}>{d.taglineHe}</p>
            <p className={styles.when}>{d.whenToUseHe}</p>
          </button>
        );
      })}
    </div>
  </section>
);

export default MethodSelector;
'@
Write-Source -Path 'src/sections/07-personal/PersonalNotes.module.scss' -Body @'
.section { @include flex-col; gap: $space-3; }

.eyebrow { @include eyebrow; }
.title   { @include headline-subsection; font-weight: $weight-regular; }

.textarea {
  @include field-base;
  resize: vertical;
  min-height: 240px;
  line-height: $leading-loose;
  font-family: $font-body;
}

.tip {
  @include body-paragraph;
  font-size: $text-sm;
  color: $ink-soft;
  font-style: italic;
}
'@
Write-Source -Path 'src/sections/07-personal/PersonalNotes.tsx' -Body @'
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
'@
Write-Source -Path 'src/sections/07-personal/PersonalPromptBuilder.module.scss' -Body @'
.section { @include flex-col; gap: $space-3; }

.eyebrow { @include eyebrow; }

.title {
  @include headline-subsection;
  font-weight: $weight-regular;

  em {
    @include accent-underline;
    font-style: normal;
    font-weight: $weight-regular;
  }
}

.note {
  @include body-paragraph;
  font-size: $text-sm;
  color: $ink-mid;
}
'@
Write-Source -Path 'src/sections/07-personal/PersonalPromptBuilder.tsx' -Body @'
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
'@
Write-Source -Path 'src/sections/07-personal/index.module.scss' -Body @'
.head     { @include flex-col; gap: $space-3; }
.eyebrow  { @include eyebrow; }
.title    { @include headline-section; font-weight: $weight-light; }
.lede     { @include lede; max-width: $content-narrow; }

.warn {
  @include body-paragraph;
  padding: $space-4 $space-5;
  background: $accent-faint;
  color: $accent-deep;
  border-radius: $radius-md;
  border-inline-start: 2px solid $accent;
}
'@
Write-Source -Path 'src/sections/07-personal/index.tsx' -Body @'
// ═══════════════════════════════════════════════════════════════════
// Section 07 — השיעור היצירתי שלכם (30 min)
// Teacher picks one method + applies it to their own class topic.
// Outputs: a prompt template they can copy + their lesson notes.
// ═══════════════════════════════════════════════════════════════════
import React from 'react';
import SectionShell from '@/components/SectionShell/SectionShell';
import { useProgressCtx } from '@/components/ModuleShell/ModuleProgressContext';
import MethodSelector from './MethodSelector';
import PersonalPromptBuilder from './PersonalPromptBuilder';
import PersonalNotes from './PersonalNotes';
import styles from './index.module.scss';

const PersonalSection: React.FC = () => {
  const { progress, setPersonalTechnique } = useProgressCtx();
  const tech  = progress.personalTechnique;
  const topic = progress.customTopic;

  return (
    <SectionShell id="personal">
      <header className={styles.head}>
        <span className={styles.eyebrow}>החלק שלכם · 30 דקות</span>
        <h2 className={styles.title}>השיעור היצירתי שלכם — לכיתה שלכם, על הנושא שבחרתם.</h2>
        <p className={styles.lede}>
          בחרו שיטה אחת מהשלוש. הפרומפט יבנה אוטומטית סביב הנושא שלכם.
          העתיקו אותו. הריצו אותו במודל AI שאתם משתמשים בו. רשמו פה מה יצא ומה
          אתם רוצים לעשות עם זה בכיתה.
        </p>
      </header>

      {!topic && (
        <p className={styles.warn}>
          חסר נושא לכיתה שלכם. חזרו לחלק 4 (הפסקה) ומלאו את הטופס.
        </p>
      )}

      <MethodSelector
        selected={tech}
        onSelect={setPersonalTechnique}
      />

      {tech && topic && (
        <>
          <PersonalPromptBuilder technique={tech} topic={topic} />
          <PersonalNotes />
        </>
      )}
    </SectionShell>
  );
};

export default PersonalSection;
'@
Write-Source -Path 'src/sections/08-closing/ClosingHero.module.scss' -Body @'
.section { @include flex-col; gap: $space-3; }

.eyebrow { @include eyebrow; }
.title   { @include headline-section; font-weight: $weight-light; }

.lede {
  @include lede;
  max-width: $content-narrow;

  em {
    @include accent-underline;
    font-style: normal;
  }
}

// ── STATS ──────────────────────────────────────────────────────
.stats {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: $space-3;
  margin: $space-4 0 0;
  padding: $space-5 0;
  border-top: $border-subtle;
  border-bottom: $border-subtle;

  @media (max-width: $bp-md) {
    grid-template-columns: 1fr;
    gap: $space-4;
  }
}

.stat {
  @include flex-col;
  gap: $space-1;
  align-items: start;
}

.statValue {
  font-family: $font-display;
  font-size: $text-4xl;
  font-weight: $weight-light;
  color: $accent;
  line-height: 1;
  letter-spacing: -0.02em;
}

.statLabel {
  @include eyebrow;
  color: $ink-soft;
}
'@
Write-Source -Path 'src/sections/08-closing/ClosingHero.tsx' -Body @'
// ═══════════════════════════════════════════════════════════════════
// ClosingHero — opening of Section 8. Quick summary of what was built.
// ═══════════════════════════════════════════════════════════════════
import React from 'react';
import styles from './ClosingHero.module.scss';

const STATS = [
  { value: '4', labelHe: 'שיעורים מוכנים' },
  { value: '5', labelHe: 'כרטיסיות פרומפט' },
  { value: '3', labelHe: 'שיטות חשיבה' },
];

const ClosingHero: React.FC = () => (
  <section className={styles.section}>
    <span className={styles.eyebrow}>סיכום</span>
    <h2 className={styles.title}>בשעתיים וחצי האחרונות בניתם משהו ממשי.</h2>
    <p className={styles.lede}>
      לא רק הקשבתם. לא רק "למדתם על". <em>תרגלתם בעצמכם</em> חשיבה מסתעפת.
      בניתם שיעור על נושא אמיתי בכיתה אמיתית. בחרתם שיטה. ניסחתם פרומפט.
      תיעדתם הרהור. הנה הקיט שלוקחים הביתה:
    </p>

    <dl className={styles.stats}>
      {STATS.map(s => (
        <div key={s.labelHe} className={styles.stat}>
          <dt className={styles.statValue}>{s.value}</dt>
          <dd className={styles.statLabel}>{s.labelHe}</dd>
        </div>
      ))}
    </dl>
  </section>
);

export default ClosingHero;
'@
Write-Source -Path 'src/sections/08-closing/LessonPDFSet.module.scss' -Body @'
.section {
  @include flex-col;
  gap: $space-3;
  margin-top: $space-5;
}

.eyebrow { @include eyebrow; }
.title   { @include headline-section; font-weight: $weight-light; }

.note {
  @include body-paragraph;
  font-size: $text-sm;

  strong {
    font-weight: $weight-medium;
    color: $ink;
  }
}

// ── GRID ───────────────────────────────────────────────────────
.grid {
  list-style: none;
  margin: $space-3 0 0;
  padding: 0;
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: $space-3;

  @media (max-width: $bp-md) {
    grid-template-columns: 1fr;
  }
}

.card {
  @include flex-col;
  gap: $space-2;
  padding: $space-4 $space-5;
  background: $bg-surface;
  border: $border-hair;
  border-radius: $radius-md;
}

.cardTitle {
  font-family: $font-display;
  font-size: $text-md;
  font-weight: $weight-medium;
  color: $ink;
}

.cardMeta {
  font-family: $font-mono;
  font-size: 11px;
  color: $ink-soft;
  letter-spacing: 0.04em;
}

.btn {
  @include btn-secondary;
  align-self: start;
  margin-top: $space-2;
  display: inline-flex;
  align-items: center;
  gap: $space-2;

  svg { font-size: 14px; }
}

.cardEmpty {
  background: $bg-subtle;
  border-style: dashed;
}

.cardTitleEmpty {
  font-family: $font-display;
  font-size: $text-md;
  font-weight: $weight-regular;
  color: $ink-soft;
}

.cardMetaEmpty {
  @include body-paragraph;
  font-size: $text-sm;
  color: $ink-soft;
  font-style: italic;
}

// ── PRINT PAGE LAYOUT (only visible during print) ──────────────
.printPage {
  font-family: $font-body;
  color: $ink;
  padding: 16mm 14mm;
  background: white;
}

.printHeader {
  display: flex;
  flex-direction: column;
  gap: 6pt;
  margin-bottom: 18pt;
  padding-bottom: 10pt;
  border-bottom: 1pt solid $line-strong;
}

.printTag {
  font-family: $font-mono;
  font-size: 9pt;
  color: $accent;
  text-transform: uppercase;
  letter-spacing: 0.08em;
}

.printTitle {
  font-family: $font-display;
  font-size: 22pt;
  font-weight: 400;
  color: $ink;
  line-height: 1.2;
}

.printMeta {
  font-family: $font-mono;
  font-size: 9pt;
  color: $ink-soft;
  letter-spacing: 0.04em;
}

.printNotes {
  margin-top: 18pt;
  padding-top: 12pt;
  border-top: 1pt solid $line-strong;
}

.printNotesTitle {
  font-family: $font-display;
  font-size: 13pt;
  font-weight: 500;
  color: $ink;
  margin-bottom: 8pt;
}

.printNotesBody {
  font-family: $font-body;
  font-size: 10pt;
  line-height: 1.7;
  color: $ink-mid;
  white-space: pre-wrap;
  word-break: break-word;
}

.printFooter {
  margin-top: 24pt;
  padding-top: 8pt;
  border-top: 1pt solid $line;
  font-family: $font-mono;
  font-size: 8pt;
  color: $ink-faint;
  letter-spacing: 0.04em;
  text-align: center;
}
'@
Write-Source -Path 'src/sections/08-closing/LessonPDFSet.tsx' -Body @'
// ═══════════════════════════════════════════════════════════════════
// LessonPDFSet — 4 printable lesson plans:
//   - 3 demo lessons (SCAMPER · Design Thinking · What If)
//   - 1 personal lesson (built from teacher's customTopic + technique
//     + personalNotes textarea contents)
//
// Print isolation: each print renders ONE lesson via React portal
// mounted to document.body with class "m05-print-host". global.scss
// rules hide #root and show .m05-print-host only during print.
// ═══════════════════════════════════════════════════════════════════
import React, { useEffect, useMemo, useState } from 'react';
import { createPortal } from 'react-dom';
import { TbDownload } from 'react-icons/tb';
import LessonPlanCard from '@/components/LessonPlanCard/LessonPlanCard';
import { useProgressCtx } from '@/components/ModuleShell/ModuleProgressContext';
import { ALL_DEMOS, DEMO_BY_ID } from '@/data/methods';
import type { LessonBlock } from '@/data/methods';
import styles from './LessonPDFSet.module.scss';

const NOTES_KEY = 'binai.m05.personalNotes.v1';

interface PrintLesson {
  id:       string;
  titleHe:  string;
  classHe?: string;
  topicHe?: string;
  blocks:   LessonBlock[];
  notesHe?: string;
}

function loadNotes(): string {
  try { return localStorage.getItem(NOTES_KEY) ?? ''; } catch { return ''; }
}

const LessonPDFSet: React.FC = () => {
  const { progress } = useProgressCtx();
  const [printing, setPrinting] = useState<string | null>(null);
  const [host, setHost] = useState<HTMLElement | null>(null);

  // Ensure the print-host element exists on body before portaling into it
  useEffect(() => {
    let el = document.querySelector<HTMLElement>('.m05-print-host');
    if (!el) {
      el = document.createElement('div');
      el.className = 'm05-print-host';
      document.body.appendChild(el);
    }
    setHost(el);
  }, []);

  // Build the lessons list (3 demo + maybe 1 personal)
  const lessons: PrintLesson[] = useMemo(() => {
    const list: PrintLesson[] = ALL_DEMOS.map(d => ({
      id:      `demo-${d.id}`,
      titleHe: `${d.nameHe} · ${d.subjectHe}`,
      classHe: d.gradeHe,
      topicHe: d.challengeHe.split('.')[0],
      blocks:  d.lesson,
    }));

    if (progress.customTopic && progress.personalTechnique) {
      const demo = DEMO_BY_ID[progress.personalTechnique];
      const notes = loadNotes();
      list.push({
        id:      'personal',
        titleHe: `השיעור שלי · ${demo.nameHe}`,
        classHe: `${progress.customTopic.subject} · כיתה ${progress.customTopic.grade}`,
        topicHe: progress.customTopic.topic,
        // Use the demo's lesson as scaffold the teacher will adapt; notes appended below
        blocks:  demo.lesson,
        notesHe: notes,
      });
    }
    return list;
  }, [progress.customTopic, progress.personalTechnique]);

  const handlePrint = (id: string) => {
    setPrinting(id);
    requestAnimationFrame(() => {
      window.print();
      // Clear shortly after the print dialog opens — printing already snapshotted DOM
      setTimeout(() => setPrinting(null), 200);
    });
  };

  const currentLesson = lessons.find(l => l.id === printing);

  return (
    <section className={styles.section}>
      <span className={styles.eyebrow}>הקיט · {lessons.length} שיעורים</span>
      <h2 className={styles.title}>שיעורים מוכנים לעבודה — להוריד כ-PDF.</h2>
      <p className={styles.note}>
        כל לחיצה פותחת תיבת הדפסה של הדפדפן. <strong>בחרו "שמור כ-PDF"</strong>
        כיעד. ההדפסה מבודדת — רק השיעור הנבחר ייצא, לא הממשק.
      </p>

      <ul className={styles.grid}>
        {lessons.map(l => (
          <li key={l.id} className={styles.card}>
            <h3 className={styles.cardTitle}>{l.titleHe}</h3>
            <p className={styles.cardMeta}>
              {l.classHe}{l.topicHe ? ` · ${l.topicHe}` : ''}
            </p>
            <button
              type="button"
              className={styles.btn}
              onClick={() => handlePrint(l.id)}
            >
              <TbDownload aria-hidden /> שמרו כ-PDF
            </button>
          </li>
        ))}
        {!progress.customTopic && (
          <li className={[styles.card, styles.cardEmpty].join(' ')}>
            <h3 className={styles.cardTitleEmpty}>השיעור האישי שלכם</h3>
            <p className={styles.cardMetaEmpty}>
              כדי לקבל גם את השיעור האישי כ-PDF — מלאו את טופס הכיתה בחלק 4.
            </p>
          </li>
        )}
      </ul>

      {/* Portal: only renders into body during a print action */}
      {host && currentLesson && createPortal(
        <div className={styles.printPage}>
          <header className={styles.printHeader}>
            <span className={styles.printTag}>BinAI · חשיבה יצירתית</span>
            <h1 className={styles.printTitle}>{currentLesson.titleHe}</h1>
            {currentLesson.classHe && (
              <p className={styles.printMeta}>{currentLesson.classHe}{currentLesson.topicHe ? ` · ${currentLesson.topicHe}` : ''}</p>
            )}
          </header>

          <LessonPlanCard
            titleHe="מערך השיעור"
            blocks={currentLesson.blocks}
            variant="print"
          />

          {currentLesson.notesHe && currentLesson.notesHe.trim().length > 0 && (
            <section className={styles.printNotes}>
              <h2 className={styles.printNotesTitle}>הערות שלי</h2>
              <pre className={styles.printNotesBody}>{currentLesson.notesHe}</pre>
            </section>
          )}

          <footer className={styles.printFooter}>
            BinAI · שיעור 5 · חשיבה יצירתית עם AI
          </footer>
        </div>,
        host,
      )}
    </section>
  );
};

export default LessonPDFSet;
'@
Write-Source -Path 'src/sections/08-closing/PromptCardsPrintable.module.scss' -Body @'
.section {
  @include flex-col;
  gap: $space-3;
  margin-top: $space-5;
}

.eyebrow { @include eyebrow; }
.title   { @include headline-section; font-weight: $weight-light; }

.note {
  @include body-paragraph;
  font-size: $text-sm;
}

.btn {
  @include btn-primary;
  align-self: start;
  margin-top: $space-3;
  display: inline-flex;
  align-items: center;
  gap: $space-2;

  svg { font-size: 16px; }
}

// ── DECK PAGES (print only) ────────────────────────────────────
.deck {
  font-family: $font-body;
  color: $ink;
  background: white;
}

.card {
  padding: 16mm 14mm;
  background: white;
  min-height: 100vh;
}

.cardHeader {
  display: flex;
  justify-content: space-between;
  align-items: baseline;
  padding-bottom: 8pt;
  border-bottom: 1pt solid $line-strong;
  margin-bottom: 14pt;
}

.cardNum {
  font-family: $font-mono;
  font-size: 11pt;
  font-weight: 500;
  color: $accent;
  letter-spacing: 0.04em;
}

.cardKit {
  font-family: $font-mono;
  font-size: 8pt;
  color: $ink-faint;
  letter-spacing: 0.06em;
  text-transform: uppercase;
}

.cardName {
  font-family: $font-display;
  font-size: 26pt;
  font-weight: 400;
  color: $ink;
  line-height: 1.15;
  margin-bottom: 4pt;
}

.cardTag {
  font-family: $font-body;
  font-size: 11pt;
  font-style: italic;
  color: $ink-mid;
  margin-bottom: 12pt;
}

.cardWhen, .cardPrompt, .cardExample {
  margin-bottom: 12pt;

  h2 {
    font-family: $font-mono;
    font-size: 9pt;
    font-weight: 500;
    color: $accent;
    text-transform: uppercase;
    letter-spacing: 0.08em;
    margin-bottom: 4pt;
  }

  p {
    font-family: $font-body;
    font-size: 10pt;
    line-height: 1.7;
    color: $ink;
    margin: 0;
  }
}

.cardPrompt {
  padding: 10pt 12pt;
  background: #FBF8F1;
  border-inline-start: 2pt solid $accent;
  border-radius: 2pt;
}

.partRow {
  display: grid;
  grid-template-columns: 50pt 1fr;
  gap: 8pt;
  margin-bottom: 6pt;

  &:last-child { margin-bottom: 0; }
}

.partLabel {
  font-family: $font-mono;
  font-size: 8pt;
  font-weight: 500;
  color: $accent;
  text-transform: uppercase;
  letter-spacing: 0.04em;
  padding-top: 2pt;
}

.cardExample p { font-style: italic; color: $ink-mid; }

.cardFooter {
  margin-top: 16pt;
  padding-top: 6pt;
  border-top: 1pt solid $line;
  font-family: $font-mono;
  font-size: 7pt;
  color: $ink-faint;
  letter-spacing: 0.04em;
  text-align: center;
}
'@
Write-Source -Path 'src/sections/08-closing/PromptCardsPrintable.tsx' -Body @'
// ═══════════════════════════════════════════════════════════════════
// PromptCardsPrintable — prints all 5 prompt cards as a single deck.
// One page per card via CSS page-break-after.
// ═══════════════════════════════════════════════════════════════════
import React, { useEffect, useState } from 'react';
import { createPortal } from 'react-dom';
import { TbDownload } from 'react-icons/tb';
import { PROMPT_CARDS } from '@/data/promptCards';
import styles from './PromptCardsPrintable.module.scss';

const PromptCardsPrintable: React.FC = () => {
  const [printing, setPrinting] = useState(false);
  const [host, setHost] = useState<HTMLElement | null>(null);

  useEffect(() => {
    let el = document.querySelector<HTMLElement>('.m05-print-host');
    if (!el) {
      el = document.createElement('div');
      el.className = 'm05-print-host';
      document.body.appendChild(el);
    }
    setHost(el);
  }, []);

  const handlePrint = () => {
    setPrinting(true);
    requestAnimationFrame(() => {
      window.print();
      setTimeout(() => setPrinting(false), 200);
    });
  };

  return (
    <section className={styles.section}>
      <span className={styles.eyebrow}>הקיט · 5 כרטיסיות פרומפט</span>
      <h2 className={styles.title}>הדק כרטיסיות הפרומפט — שיהיה תלוי במסך שלכם.</h2>
      <p className={styles.note}>
        חבילה אחת. 5 דפים. כדאי להדפיס דו-צדדי על דף A4 ולגזור — או לשמור כ-PDF
        ולחפש בו לפי מצב.
      </p>

      <button
        type="button"
        className={styles.btn}
        onClick={handlePrint}
      >
        <TbDownload aria-hidden /> שמרו את כל הכרטיסיות כ-PDF
      </button>

      {host && printing && createPortal(
        <div className={styles.deck}>
          {PROMPT_CARDS.map((c, i) => (
            <article
              key={c.id}
              className={styles.card}
              style={i < PROMPT_CARDS.length - 1 ? { pageBreakAfter: 'always' } : undefined}
            >
              <header className={styles.cardHeader}>
                <span className={styles.cardNum}>{c.number}</span>
                <span className={styles.cardKit}>BinAI · קיט יצירתיות</span>
              </header>

              <h1 className={styles.cardName}>{c.nameHe}</h1>
              <p className={styles.cardTag}>{c.taglineHe}</p>

              <section className={styles.cardWhen}>
                <h2>מתי</h2>
                <p>{c.whenToUseHe}</p>
              </section>

              <section className={styles.cardPrompt}>
                <h2>הפרומפט · 4 חלקים</h2>

                <div className={styles.partRow}>
                  <span className={styles.partLabel}>תפקיד</span>
                  <p>{c.roleHe}</p>
                </div>
                <div className={styles.partRow}>
                  <span className={styles.partLabel}>הקשר</span>
                  <p>{c.contextHe}</p>
                </div>
                <div className={styles.partRow}>
                  <span className={styles.partLabel}>משימה</span>
                  <p>{c.taskHe}</p>
                </div>
                <div className={styles.partRow}>
                  <span className={styles.partLabel}>מגבלות</span>
                  <p>{c.constraintsHe}</p>
                </div>
              </section>

              <section className={styles.cardExample}>
                <h2>דוגמה</h2>
                <p>{c.exampleHe}</p>
              </section>

              <footer className={styles.cardFooter}>
                BinAI · שיעור 5 · חשיבה יצירתית עם AI · כרטיסייה {c.number} מתוך 05
              </footer>
            </article>
          ))}
        </div>,
        host,
      )}
    </section>
  );
};

export default PromptCardsPrintable;
'@
Write-Source -Path 'src/sections/08-closing/index.module.scss' -Body @'
.commit {
  @include flex-col;
  gap: $space-3;
  margin-top: $space-5;
  padding: $space-6;
  background: $bg-deep;
  color: $bg-canvas;
  border-radius: $radius-md;
}

.eyebrow {
  @include eyebrow;
  color: $accent;
}

.title {
  @include headline-section;
  color: $bg-canvas;
  font-weight: $weight-light;

  em {
    color: $accent;
    font-style: normal;
    text-decoration: underline;
    text-decoration-thickness: 1px;
    text-underline-offset: 4px;
  }
}

.lede {
  font-family: $font-body;
  font-size: $text-md;
  font-weight: $weight-light;
  line-height: $leading-loose;
  color: rgba(252, 251, 248, 0.75);
  max-width: $content-narrow;
}

.textarea {
  @include field-base;
  resize: vertical;
  min-height: 100px;
  background: rgba(252, 251, 248, 0.05);
  border-color: rgba(252, 251, 248, 0.18);
  color: $bg-canvas;
  line-height: $leading-loose;

  &::placeholder { color: rgba(252, 251, 248, 0.4); }
  &:focus {
    border-color: $accent;
    background: rgba(252, 251, 248, 0.08);
  }
}

.completeBtn {
  @include focus-ring;
  align-self: start;
  padding: 12px 32px;
  background: $accent;
  border: none;
  border-radius: $radius-md;
  color: $bg-canvas;
  font-family: $font-body;
  font-size: $text-base;
  font-weight: $weight-medium;
  cursor: pointer;
  transition: background $dur-fast $ease-out;

  &:hover:not(:disabled) { background: $accent-deep; }
  &:disabled {
    opacity: 0.35;
    cursor: not-allowed;
  }
}

.thanks {
  font-family: $font-body;
  font-size: $text-sm;
  color: rgba(252, 251, 248, 0.75);
  font-style: italic;
  margin-top: $space-2;
}
'@
Write-Source -Path 'src/sections/08-closing/index.tsx' -Body @'
// ═══════════════════════════════════════════════════════════════════
// Section 08 — סיכום (15 min)
// Closing summary + 4 downloadable lesson PDFs + 5-card printable deck
// + a commitment field. Marks module complete on submit.
// ═══════════════════════════════════════════════════════════════════
import React, { useEffect, useState } from 'react';
import SectionShell from '@/components/SectionShell/SectionShell';
import { useProgressCtx } from '@/components/ModuleShell/ModuleProgressContext';
import ClosingHero from './ClosingHero';
import LessonPDFSet from './LessonPDFSet';
import PromptCardsPrintable from './PromptCardsPrintable';
import styles from './index.module.scss';

const KEY_COMMIT = 'binai.m05.commit.v1';

function loadCommit(): string {
  try { return localStorage.getItem(KEY_COMMIT) ?? ''; } catch { return ''; }
}
function saveCommit(value: string): void {
  try { localStorage.setItem(KEY_COMMIT, value); } catch { /* noop */ }
}

const ClosingSection: React.FC = () => {
  const { complete } = useProgressCtx();
  const [commit, setCommit] = useState<string>(() => loadCommit());
  const [done, setDone] = useState(false);

  useEffect(() => { saveCommit(commit); }, [commit]);

  const handleComplete = () => {
    complete('closing');
    setDone(true);
  };

  return (
    <SectionShell id="closing">
      <ClosingHero />
      <LessonPDFSet />
      <PromptCardsPrintable />

      <section className={styles.commit}>
        <span className={styles.eyebrow}>צעד אחד · השבוע</span>
        <h2 className={styles.title}>
          מה אתם הולכים <em>באמת לנסות</em> השבוע?
        </h2>
        <p className={styles.lede}>
          לא מערכת שיעורים שלמה. דבר אחד. שיטה אחת על שיעור אחד. אם תכתבו את
          זה — סיכוי גבוה יותר שזה יקרה.
        </p>
        <textarea
          className={styles.textarea}
          value={commit}
          onChange={e => setCommit(e.target.value)}
          placeholder="ביום שלישי, בשיעור הראשון של כיתה ז, אנסה..."
          rows={4}
        />

        <button
          type="button"
          className={styles.completeBtn}
          onClick={handleComplete}
          disabled={done || commit.trim().length < 10}
        >
          {done ? 'סומן כהושלם ✓' : 'סיימתי את ההשתלמות'}
        </button>

        {done && (
          <p className={styles.thanks}>
            תודה שלמדתם איתנו. השיעורים, הכרטיסיות, וההתחייבות שלכם — שמורים אצלכם.
            חזרו לכאן בכל זמן.
          </p>
        )}
      </section>
    </SectionShell>
  );
};

export default ClosingSection;
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

  &:hover:not(:disabled) { background: $bg-deep; }
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
Write-Source -Path 'src/vite-env.d.ts' -Body @'
/// <reference types="vite/client" />

declare module '*.module.scss' {
  const classes: { readonly [key: string]: string };
  export default classes;
}

declare module '*.module.css' {
  const classes: { readonly [key: string]: string };
  export default classes;
}

declare module '*.scss';
declare module '*.css';
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
