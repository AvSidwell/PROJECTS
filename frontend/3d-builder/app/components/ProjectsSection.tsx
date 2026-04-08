'use client'

import { useState } from 'react'

const ALL_PROJECTS = [
  { id: 1, name: 'Portfolio V2',   desc: 'Dark editorial personal portfolio with animated sections and custom type system.',         tags: ['React', 'Next.js', 'CSS'] },
  { id: 2, name: 'Dashboard',      desc: 'Analytics dashboard for real-time data visualization with filterable chart views.',        tags: ['React', 'TypeScript', 'D3'] },
  { id: 3, name: 'E-Commerce UI',  desc: 'Full product catalogue interface with cart, filters, and micro-interaction details.',      tags: ['Next.js', 'Tailwind'] },
  { id: 4, name: 'Design System',  desc: 'Component library and token system built for multi-brand scalability.',                    tags: ['React', 'Figma', 'Storybook'] },
  { id: 5, name: 'Blog CMS',       desc: 'Headless CMS-driven blog with MDX, full-text search, and RSS.',                           tags: ['Next.js', 'Markdown'] },
  { id: 6, name: 'Mobile App UI',  desc: 'High-fidelity prototype for a fitness tracking mobile app.',                               tags: ['Figma', 'TypeScript'] },
]

const FILTERS = ['All', 'React', 'Next.js', 'TypeScript', 'Figma']

export default function ProjectsSection() {
  const [filter, setFilter] = useState('All')
  const [search, setSearch] = useState('')

  const visible = ALL_PROJECTS.filter((p) => {
    const matchTag  = filter === 'All' || p.tags.includes(filter)
    const matchText = p.name.toLowerCase().includes(search.toLowerCase())
    return matchTag && matchText
  })

  return (
    <section
      style={{
        position: 'relative',
        zIndex: 1,
        height: '100%',
        display: 'flex',
        flexDirection: 'column',
        padding: '2.5rem 3rem 1.5rem',
        gap: '1.2rem',
      }}
    >
      <h2 className="title-display">Projects</h2>

      {/* Sort / search row */}
      <div style={{ display: 'flex', gap: '1rem', alignItems: 'center', flexWrap: 'wrap' }}>
        <div style={{ display: 'flex', gap: '0.4rem', flexWrap: 'wrap' }}>
          {FILTERS.map((f) => (
            <button
              key={f}
              className={`stab${filter === f ? ' on' : ''}`}
              onClick={() => setFilter(f)}
            >
              {f}
            </button>
          ))}
        </div>

        {/* Search */}
        <input
          className="field"
          style={{ maxWidth: 180, padding: '0.3rem 0.65rem', fontSize: '0.65rem' }}
          placeholder="Search..."
          value={search}
          onChange={(e) => setSearch(e.target.value)}
        />
      </div>

      <div className="divider-cyan" />

      {/* Cards + right scroll indicator */}
      <div style={{ flex: 1, display: 'flex', minHeight: 0, gap: '0.75rem' }}>
        {/* Cards grid */}
        <div
          style={{
            flex: 1,
            overflowY: 'auto',
            display: 'grid',
            gridTemplateColumns: 'repeat(auto-fill, minmax(190px, 1fr))',
            gap: '0.9rem',
            alignContent: 'start',
            paddingRight: '0.5rem',
          }}
        >
          {visible.map((p) => (
            <div
              key={p.id}
              style={{
                border: '1px solid #1e2220',
                background: 'rgba(0,0,0,0.3)',
                display: 'flex',
                flexDirection: 'column',
              }}
            >
              {/* Image block — strong pink top */}
              <div
                style={{
                  height: 90,
                  background: 'var(--pink)',
                  display: 'flex',
                  alignItems: 'center',
                  justifyContent: 'center',
                  opacity: 0.9,
                }}
              />

              {/* Meta area */}
              <div style={{ padding: '0.65rem 0.75rem', display: 'flex', flexDirection: 'column', gap: '0.4rem', flex: 1 }}>
                <span className="lv" style={{ fontSize: '0.72rem' }}>{p.name}</span>
                <p className="dc" style={{ fontSize: '0.62rem' }}>{p.desc}</p>

                {/* Action pills */}
                <div style={{ display: 'flex', gap: '0.4rem', marginTop: 'auto', paddingTop: '0.5rem', flexWrap: 'wrap' }}>
                  {(['GitHub', 'Live', 'Design'] as const).map((btn) => (
                    <button
                      key={btn}
                      style={{
                        fontFamily: 'var(--ff-mono)',
                        fontSize: '0.55rem',
                        letterSpacing: '0.1em',
                        padding: '0.18rem 0.5rem',
                        background: 'transparent',
                        border: '1px solid #2e3231',
                        color: 'var(--text-lo)',
                        cursor: 'pointer',
                        transition: 'border-color 0.2s, color 0.2s',
                      }}
                      onMouseEnter={(e) => {
                        const t = e.currentTarget
                        t.style.borderColor = 'var(--cyan-dim)'
                        t.style.color = 'var(--cyan-dim)'
                      }}
                      onMouseLeave={(e) => {
                        const t = e.currentTarget
                        t.style.borderColor = '#2e3231'
                        t.style.color = 'var(--text-lo)'
                      }}
                    >
                      {btn}
                    </button>
                  ))}
                </div>
              </div>
            </div>
          ))}
        </div>

        {/* Right scroll indicator */}
        <div
          style={{
            width: 3,
            background: '#1a1e1c',
            borderRadius: 2,
            flexShrink: 0,
            position: 'relative',
          }}
        >
          <div
            style={{
              position: 'absolute',
              top: 0, left: 0, right: 0,
              height: '40%',
              background: 'var(--pink)',
              opacity: 0.6,
              borderRadius: 2,
            }}
          />
        </div>
      </div>
    </section>
  )
}
