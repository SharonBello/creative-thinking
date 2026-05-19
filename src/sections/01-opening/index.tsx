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