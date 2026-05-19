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