'use client'

import { useState } from 'react'
import Sidebar, { type Section } from './components/Sidebar'
import BackgroundMotif        from './components/BackgroundMotif'
import HeroSection            from './components/HeroSection'
import AboutSection           from './components/AboutSection'
import ResumeSection          from './components/ResumeSection'
import ProjectsSection        from './components/ProjectsSection'
import SkillsSection          from './components/SkillsSection'
import EducationSection       from './components/EducationSection'
import TestimonialsSection    from './components/TestimonialsSection'
import ContactSection         from './components/ContactSection'

const SECTIONS: Record<Section, React.ReactNode> = {
  home:         <HeroSection />,
  about:        <AboutSection />,
  resume:       <ResumeSection />,
  projects:     <ProjectsSection />,
  skills:       <SkillsSection />,
  education:    <EducationSection />,
  testimonials: <TestimonialsSection />,
  contact:      <ContactSection />,
}

export default function Portfolio() {
  const [active, setActive] = useState<Section>('home')

  return (
    /*
     * Outermost shell — deep charcoal bg.
     * Subtle flanking columns give depth impression.
     */
    <div
      style={{
        display: 'flex',
        height: '100vh',
        width: '100vw',
        background: 'var(--bg-outer)',
        overflow: 'hidden',
      }}
    >
      {/* ── Sidebar ─────────────────────────────────────────────────── */}
      <Sidebar active={active} onNav={setActive} />

      {/* ── Outer padding zone (dark flanking columns) ──────────────── */}
      <div
        style={{
          flex: 1,
          display: 'flex',
          padding: '1.4rem 1.6rem 1.4rem 1.4rem',
          overflow: 'hidden',
          /* Left/right dark flanking column effect */
          background: 'linear-gradient(90deg, #0a0c0b 0%, transparent 6%, transparent 94%, #0a0c0b 100%)',
        }}
      >
        {/* ── Blue-bordered content frame ─────────────────────────── */}
        <div
          style={{
            flex: 1,
            border: '1.5px solid var(--frame-blue)',
            background: 'var(--bg-inner)',
            position: 'relative',
            overflow: 'hidden',
            display: 'flex',
            flexDirection: 'column',
          }}
        >
          {/* Background motif layer — behind all content */}
          <BackgroundMotif />

          {/* Section content */}
          <div
            key={active}
            className="section-in"
            style={{ flex: 1, overflow: 'hidden', display: 'flex', flexDirection: 'column' }}
          >
            {SECTIONS[active]}
          </div>
        </div>
      </div>
    </div>
  )
}
