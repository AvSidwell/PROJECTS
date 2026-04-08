'use client'

const details = [
  { k: 'Name',     v: 'Av Sidwell' },
  { k: 'Role',     v: 'UI Developer' },
  { k: 'Location', v: 'Remote Worldwide' },
  { k: 'Email',    v: 'hello@avsidwell.dev' },
]

const stats = [
  { n: '5+',  l: 'Years Experience' },
  { n: '30+', l: 'Projects Completed' },
  { n: '20+', l: 'Happy Clients' },
]

export default function AboutSection() {
  return (
    <section
      style={{
        position: 'relative',
        zIndex: 1,
        height: '100%',
        display: 'flex',
        flexDirection: 'column',
        padding: '2.5rem 3.5rem 2rem',
        gap: '1.4rem',
        overflowY: 'auto',
      }}
    >
      <h2 className="title-display">About</h2>
      <div className="divider-cyan" />

      {/* Main split */}
      <div style={{ display: 'flex', gap: '3.5rem', flex: 1, alignItems: 'flex-start', flexWrap: 'wrap' }}>

        {/* Portrait block */}
        <div
          style={{
            width: 170,
            height: 210,
            flexShrink: 0,
            border: '1px solid var(--pink)',
            background: 'rgba(0,0,0,0.4)',
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'center',
          }}
        >
          <svg viewBox="0 0 24 24" fill="#1e2220" width="72" height="72">
            <path d="M12 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0 2c-2.67 0-8 1.34-8 4v2h16v-2c0-2.66-5.33-4-8-4z" />
          </svg>
        </div>

        {/* Text column */}
        <div style={{ flex: 1, minWidth: 220, display: 'flex', flexDirection: 'column', gap: '1rem' }}>
          <p className="dc" style={{ lineHeight: 2 }}>
            I&apos;m a UI developer with a passion for building clean, responsive, and visually
            compelling interfaces. My work spans from component-level design systems to full-scale
            web applications with a focus on crafted detail.
          </p>
          <p className="dc" style={{ lineHeight: 2 }}>
            I specialise in React, Next.js, and modern CSS, with a strong emphasis on
            accessibility, performance, and the intersection of design and engineering.
          </p>

          {/* Detail rows */}
          <div style={{ display: 'flex', flexDirection: 'column', gap: '0.5rem', marginTop: '0.5rem' }}>
            {details.map((d) => (
              <div key={d.k} style={{ display: 'flex', gap: '1.2rem', alignItems: 'baseline' }}>
                <span className="lk" style={{ minWidth: 72 }}>{d.k}:</span>
                <span className="lv">{d.v}</span>
              </div>
            ))}
          </div>
        </div>
      </div>

      {/* Stat boxes */}
      <div style={{ display: 'flex', gap: '1rem', flexWrap: 'wrap' }}>
        {stats.map((s) => (
          <div
            key={s.l}
            style={{
              flex: 1,
              minWidth: 110,
              border: '1px solid #1e2220',
              background: 'rgba(0,0,0,0.25)',
              padding: '1rem 1.25rem',
              textAlign: 'center',
            }}
          >
            <div
              style={{
                fontFamily: 'var(--ff-display)',
                fontWeight: 600,
                fontSize: '2rem',
                color: 'var(--pink)',
                lineHeight: 1,
              }}
            >
              {s.n}
            </div>
            <div className="lk" style={{ fontSize: '0.58rem', marginTop: '0.35rem', color: 'var(--text-lo)' }}>
              {s.l}
            </div>
          </div>
        ))}
      </div>

      <div className="divider-cyan" />
    </section>
  )
}
