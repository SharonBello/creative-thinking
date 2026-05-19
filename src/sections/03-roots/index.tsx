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