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