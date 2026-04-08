'use client'

/* ─── Milestone data ─────────────────────────────────────────────────── */
const milestones = [
  {
    year: '2015',
    title: 'BSc Computer Science',
    org: 'University of Technology',
    note: 'Specialising in HCI & Software Engineering.',
    side: 'top',
  },
  {
    year: '2017',
    title: 'First Web App',
    org: 'Self-directed',
    note: 'Shipped first production React project.',
    side: 'bottom',
  },
  {
    year: '2019',
    title: 'Graduated',
    org: 'University of Technology',
    note: 'First class honours. Senior project: design system toolkit.',
    side: 'top',
  },
  {
    year: '2020',
    title: 'Google UX Certificate',
    org: 'Google / Coursera',
    note: 'UX research, prototyping and information architecture.',
    side: 'bottom',
  },
  {
    year: '2022',
    title: 'Senior UI Developer',
    org: 'Creative Studio',
    note: 'Leading frontend architecture for enterprise applications.',
    side: 'top',
  },
]

/* Simple tech logos as text marks */
const TECH_MARKS = [
  { label: 'HTML',    x: '8%',  y: '42%' },
  { label: 'CSS',     x: '20%', y: '55%' },
  { label: 'JS',      x: '34%', y: '38%' },
  { label: 'React',   x: '50%', y: '52%' },
  { label: 'Next',    x: '65%', y: '40%' },
  { label: 'TS',      x: '78%', y: '56%' },
  { label: 'Figma',   x: '90%', y: '44%' },
]

export default function EducationSection() {
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
        overflow: 'hidden',
      }}
    >
      <h2 className="title-display">Education</h2>
      <div className="divider-cyan" />

      {/* Tech mark cloud — compositional layer */}
      <div style={{ position: 'relative', height: 40, flexShrink: 0 }}>
        {TECH_MARKS.map((m) => (
          <span
            key={m.label}
            style={{
              position: 'absolute',
              left: m.x,
              top: m.y,
              fontFamily: 'var(--ff-mono)',
              fontSize: '0.62rem',
              letterSpacing: '0.18em',
              color: 'var(--cyan-dim)',
              opacity: 0.5,
              transform: 'translateY(-50%)',
              userSelect: 'none',
            }}
          >
            {m.label}
          </span>
        ))}
      </div>

      {/* Timeline rail + milestones */}
      <div style={{ flex: 1, position: 'relative', overflowX: 'auto', overflowY: 'hidden' }}>
        {/* Horizontal rail line */}
        <div
          style={{
            position: 'absolute',
            top: '50%',
            left: 0,
            right: 0,
            height: 1,
            background: 'linear-gradient(90deg, transparent, var(--pink) 5%, var(--pink) 95%, transparent)',
            opacity: 0.4,
            transform: 'translateY(-50%)',
          }}
        />

        {/* Milestones */}
        <div
          style={{
            position: 'relative',
            height: '100%',
            minWidth: 700,
            display: 'flex',
            alignItems: 'center',
          }}
        >
          {milestones.map((m, i) => {
            const pct = 8 + i * 22
            const isTop = m.side === 'top'

            return (
              <div
                key={m.year}
                style={{
                  position: 'absolute',
                  left: `${pct}%`,
                  top: '50%',
                  transform: 'translateX(-50%)',
                  display: 'flex',
                  flexDirection: 'column',
                  alignItems: 'center',
                  gap: 0,
                }}
              >
                {/* Top content or spacer */}
                {isTop ? (
                  <div
                    style={{
                      marginBottom: 6,
                      textAlign: 'center',
                      maxWidth: 130,
                    }}
                  >
                    <div className="lv" style={{ fontSize: '0.68rem', lineHeight: 1.3 }}>{m.title}</div>
                    <div className="lk" style={{ fontSize: '0.55rem', color: 'var(--text-lo)', margin: '0.15rem 0' }}>{m.org}</div>
                    <div className="dc" style={{ fontSize: '0.6rem', lineHeight: 1.5 }}>{m.note}</div>
                  </div>
                ) : (
                  <div style={{ height: 80 }} />
                )}

                {/* Year node */}
                <div
                  style={{
                    display: 'flex',
                    flexDirection: 'column',
                    alignItems: 'center',
                  }}
                >
                  {/* Connector bar */}
                  <div
                    style={{
                      width: 1,
                      height: 20,
                      background: 'var(--pink)',
                      opacity: 0.6,
                    }}
                  />
                  {/* Dot */}
                  <div
                    style={{
                      width: 10, height: 10,
                      borderRadius: '50%',
                      border: '2px solid var(--pink)',
                      background: 'var(--bg-inner)',
                    }}
                  />
                  {/* Connector bar bottom */}
                  <div
                    style={{
                      width: 1,
                      height: 20,
                      background: 'var(--pink)',
                      opacity: 0.6,
                    }}
                  />
                </div>

                {/* Year label */}
                <div
                  style={{
                    fontFamily: 'var(--ff-mono)',
                    fontSize: '0.62rem',
                    letterSpacing: '0.12em',
                    color: 'var(--cyan)',
                    margin: '4px 0',
                  }}
                >
                  {m.year}
                </div>

                {/* Bottom content or spacer */}
                {!isTop ? (
                  <div
                    style={{
                      marginTop: 4,
                      textAlign: 'center',
                      maxWidth: 130,
                    }}
                  >
                    <div className="lv" style={{ fontSize: '0.68rem', lineHeight: 1.3 }}>{m.title}</div>
                    <div className="lk" style={{ fontSize: '0.55rem', color: 'var(--text-lo)', margin: '0.15rem 0' }}>{m.org}</div>
                    <div className="dc" style={{ fontSize: '0.6rem', lineHeight: 1.5 }}>{m.note}</div>
                  </div>
                ) : (
                  <div style={{ height: 80 }} />
                )}
              </div>
            )
          })}
        </div>
      </div>

      <div className="divider-cyan" />
    </section>
  )
}
