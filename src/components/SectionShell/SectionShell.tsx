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