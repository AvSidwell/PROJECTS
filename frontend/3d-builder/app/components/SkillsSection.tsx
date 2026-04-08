'use client'

import { useState } from 'react'

/* ─── Inline SVG logos (faded) ───────────────────────────────────────── */
function ReactLogo({ size = 140 }: { size?: number }) {
  return (
    <svg viewBox="-11.5 -10.23 23 20.46" width={size} height={size} style={{ opacity: 0.12 }}>
      <circle r="2.05" fill="#61dafb" />
      <g stroke="#61dafb" strokeWidth="1" fill="none">
        <ellipse rx="11" ry="4.2" />
        <ellipse rx="11" ry="4.2" transform="rotate(60)" />
        <ellipse rx="11" ry="4.2" transform="rotate(120)" />
      </g>
    </svg>
  )
}

function NextLogo({ size = 140 }: { size?: number }) {
  return (
    <svg viewBox="0 0 180 180" width={size} height={size} style={{ opacity: 0.12 }}>
      <mask id="nm" style={{ maskType: 'alpha' }}>
        <circle cx="90" cy="90" r="90" fill="black" />
      </mask>
      <circle cx="90" cy="90" r="90" fill="white" />
      <g mask="url(#nm)">
        <circle cx="90" cy="90" r="90" fill="black" />
        <path d="M149 180L76 79H56V179.4H76V106L143 197C145 198 147 198 149 197L149 180Z" fill="white" />
        <rect x="103" y="78" width="20" height="102" fill="white" />
      </g>
    </svg>
  )
}

function TSLogo({ size = 140 }: { size?: number }) {
  return (
    <svg viewBox="0 0 100 100" width={size} height={size} style={{ opacity: 0.12 }}>
      <rect width="100" height="100" rx="8" fill="#3178c6" />
      <path d="M22 52h12v34h10V52h12V42H22v10zm41 18.5c0 4.7 3.8 8.5 9 8.5 5.5 0 9-3.5 9-9V42H71v28c0 .8-.6 1.5-1.5 1.5S68 70.8 68 70v-1h-5v1.5z" fill="white" />
    </svg>
  )
}

function FigmaLogo({ size = 140 }: { size?: number }) {
  return (
    <svg viewBox="0 0 38 57" width={(size * 38) / 57} height={size} style={{ opacity: 0.12 }}>
      <path d="M19 28.5a9.5 9.5 0 1 1 19 0 9.5 9.5 0 0 1-19 0z" fill="#1abcfe" />
      <path d="M0 47.5A9.5 9.5 0 0 1 9.5 38H19v9.5a9.5 9.5 0 1 1-19 0z" fill="#0acf83" />
      <path d="M19 0v19h9.5a9.5 9.5 0 1 0 0-19H19z" fill="#ff7262" />
      <path d="M0 9.5A9.5 9.5 0 0 0 9.5 19H19V0H9.5A9.5 9.5 0 0 0 0 9.5z" fill="#f24e1e" />
      <path d="M0 28.5A9.5 9.5 0 0 0 9.5 38H19V19H9.5A9.5 9.5 0 0 0 0 28.5z" fill="#a259ff" />
    </svg>
  )
}

function TailwindLogo({ size = 140 }: { size?: number }) {
  return (
    <svg viewBox="0 0 54 33" width={size} height={(size * 33) / 54} style={{ opacity: 0.12 }}>
      <path
        fillRule="evenodd" clipRule="evenodd"
        d="M27 0C19.8 0 15.3 3.6 13.5 10.8c2.7-3.6 5.85-4.95 9.45-4.05 2.054.513 3.522 2.004 5.147 3.653C30.744 12.756 33.808 16 40.5 16c7.2 0 11.7-3.6 13.5-10.8-2.7 3.6-5.85 4.95-9.45 4.05-2.054-.513-3.522-2.004-5.147-3.653C37.256 3.244 34.192 0 27 0zM13.5 16.2C6.3 16.2 1.8 19.8 0 27c2.7-3.6 5.85-4.95 9.45-4.05 2.054.514 3.522 2.004 5.147 3.653C16.744 28.956 19.808 32.2 26.5 32.2c7.2 0 11.7-3.6 13.5-10.8-2.7 3.6-5.85 4.95-9.45 4.05-2.054-.514-3.522-2.004-5.147-3.653C23.756 19.444 20.692 16.2 13.5 16.2z"
        fill="#38bdf8"
      />
    </svg>
  )
}

/* ─── Data ───────────────────────────────────────────────────────────── */
interface SkillEntry {
  id:       string
  tab:      string
  fullName: string
  usedFor:  string
  Logo:     React.FC<{ size?: number }>
  projects: { name: string }[]
}

const SKILLS: SkillEntry[] = [
  {
    id: 'react', tab: 'React', fullName: 'React.js',
    usedFor: 'Component-based UI development, state management, and building interactive web applications with a virtual DOM.',
    Logo: ReactLogo,
    projects: [{ name: 'Portfolio' }, { name: 'Dashboard' }, { name: 'E-Commerce' }],
  },
  {
    id: 'next', tab: 'Next.js', fullName: 'Next.js',
    usedFor: 'Full-stack React framework for production. Server-side rendering, static generation, and API routes.',
    Logo: NextLogo,
    projects: [{ name: 'Portfolio' }, { name: 'Blog CMS' }, { name: 'E-Commerce' }],
  },
  {
    id: 'ts', tab: 'TypeScript', fullName: 'TypeScript',
    usedFor: 'Strongly-typed superset of JavaScript. Adds type safety and improved DX across the entire codebase.',
    Logo: TSLogo,
    projects: [{ name: 'Dashboard' }, { name: 'Design System' }, { name: 'Portfolio' }],
  },
  {
    id: 'tw', tab: 'Tailwind', fullName: 'Tailwind CSS',
    usedFor: 'Utility-first CSS framework for rapidly building custom user interfaces without leaving your markup.',
    Logo: TailwindLogo,
    projects: [{ name: 'Marketing Site' }, { name: 'Admin Panel' }],
  },
  {
    id: 'figma', tab: 'Figma', fullName: 'Figma',
    usedFor: 'Collaborative design tool for creating wireframes, high-fidelity mockups, and interactive prototypes.',
    Logo: FigmaLogo,
    projects: [{ name: 'Design System' }, { name: 'Mobile App' }],
  },
]

/* ─── Component ──────────────────────────────────────────────────────── */
export default function SkillsSection() {
  const [activeId,      setActiveId]      = useState('react')
  const [carouselStart, setCarouselStart] = useState(0)

  const skill = SKILLS.find((s) => s.id === activeId)!
  const visible = skill.projects.slice(carouselStart, carouselStart + 2)

  function changeSkill(id: string) {
    setActiveId(id)
    setCarouselStart(0)
  }

  function nextCard() {
    setCarouselStart((i) => (i + 1) % skill.projects.length)
  }

  return (
    <section
      style={{
        position: 'relative',
        zIndex: 1,
        height: '100%',
        display: 'flex',
        flexDirection: 'column',
        padding: '2.5rem 3rem 1.5rem',
        gap: '1.1rem',
      }}
    >
      <h2 className="title-display">Skills</h2>
      <div className="divider-cyan" />

      {/* Skill tabs */}
      <div style={{ display: 'flex', gap: '0.4rem', flexWrap: 'wrap' }}>
        {SKILLS.map((s) => (
          <button
            key={s.id}
            className={`stab${activeId === s.id ? ' on' : ''}`}
            onClick={() => changeSkill(s.id)}
          >
            {s.tab}
          </button>
        ))}
      </div>

      {/* Detail panel — two-column, matches screenshot */}
      <div style={{ flex: 1, display: 'flex', minHeight: 0 }}>

        {/* Left — logo + name */}
        <div
          style={{
            flex: '0 0 44%',
            borderRight: '1px solid #1e2220',
            display: 'flex',
            flexDirection: 'column',
            alignItems: 'center',
            justifyContent: 'center',
            gap: '1rem',
            paddingRight: '2.5rem',
          }}
        >
          <skill.Logo size={145} />

          <div
            style={{
              fontFamily: 'var(--ff-display)',
              fontWeight: 400,
              fontSize: '1.9rem',
              letterSpacing: '0.12em',
              color: '#1e2220',
              userSelect: 'none',
            }}
          >
            {skill.tab}
          </div>

          <div className="divider-pink" style={{ width: '55%' }} />
        </div>

        {/* Right — info + projects */}
        <div
          style={{
            flex: 1,
            paddingLeft: '2.5rem',
            display: 'flex',
            flexDirection: 'column',
            gap: '1.4rem',
            overflowY: 'auto',
            paddingTop: '0.5rem',
          }}
        >
          {/* Name */}
          <div>
            <span className="lk">Name:</span>
            {'  '}
            <span className="lv">{skill.fullName}</span>
          </div>

          {/* Used For */}
          <div>
            <p className="lk" style={{ marginBottom: '0.45rem' }}>Used For:</p>
            <p className="dc">{skill.usedFor}</p>
          </div>

          {/* Featured On Projects */}
          <div>
            <p className="lk" style={{ marginBottom: '0.8rem' }}>Feature On Projects:</p>

            {/* Project cards row */}
            <div style={{ display: 'flex', alignItems: 'center', gap: '0.5rem' }}>
              <div style={{ display: 'flex', gap: '0.65rem' }}>
                {visible.map((p) => (
                  <div
                    key={p.name}
                    style={{
                      width: 118,
                      background: 'var(--pink)',
                      padding: '0.45rem 0.55rem',
                      flexShrink: 0,
                    }}
                  >
                    {/* Image block */}
                    <div
                      style={{
                        height: 62,
                        background: 'rgba(0,0,0,0.18)',
                        marginBottom: '0.4rem',
                      }}
                    />
                    <div style={{ fontFamily: 'var(--ff-mono)', fontSize: '0.62rem', color: 'white', letterSpacing: '0.06em' }}>
                      Name: <span style={{ fontWeight: 400 }}>{p.name}</span>
                    </div>
                    <button
                      style={{
                        marginTop: '0.3rem',
                        fontFamily: 'var(--ff-mono)',
                        fontSize: '0.58rem',
                        letterSpacing: '0.07em',
                        background: 'rgba(255,255,255,0.14)',
                        border: 'none',
                        color: 'white',
                        padding: '2px 7px',
                        cursor: 'pointer',
                      }}
                    >
                      See more
                    </button>
                  </div>
                ))}
              </div>

              {/* Arrow */}
              {skill.projects.length > 2 && (
                <button
                  onClick={nextCard}
                  style={{
                    background: 'none',
                    border: 'none',
                    color: 'var(--pink)',
                    fontSize: '1.4rem',
                    cursor: 'pointer',
                    lineHeight: 1,
                    padding: '0 0.2rem',
                  }}
                >
                  ›
                </button>
              )}
            </div>

            {/* Dots */}
            <div style={{ display: 'flex', gap: '0.45rem', marginTop: '0.8rem' }}>
              {skill.projects.map((_, i) => (
                <div
                  key={i}
                  className={`dot${i === carouselStart ? ' on' : ''}`}
                  onClick={() => setCarouselStart(i)}
                />
              ))}
            </div>
          </div>
        </div>
      </div>

      <div className="divider-cyan" />
    </section>
  )
}
