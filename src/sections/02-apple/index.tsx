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