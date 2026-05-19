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