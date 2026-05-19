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