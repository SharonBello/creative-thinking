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