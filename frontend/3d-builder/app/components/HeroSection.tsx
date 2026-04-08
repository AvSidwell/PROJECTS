'use client'

export default function HeroSection() {
  return (
    <section
      style={{
        position: 'relative',
        zIndex: 1,
        height: '100%',
        display: 'flex',
        flexDirection: 'column',
        alignItems: 'center',
        justifyContent: 'center',
        gap: '2rem',
        padding: '3rem',
        textAlign: 'center',
      }}
    >
      {/* Welcome line */}
      <p
        style={{
          fontFamily: 'var(--ff-mono)',
          fontSize: '0.68rem',
          letterSpacing: '0.32em',
          color: 'var(--cyan-dim)',
          textTransform: 'uppercase',
        }}
      >
        Welcome to my portfolio
      </p>

      {/* Giant name */}
      <h1
        style={{
          fontFamily: 'var(--ff-display)',
          fontWeight: 400,
          fontSize: 'clamp(3.5rem, 9vw, 7rem)',
          letterSpacing: '0.22em',
          color: 'var(--pink)',
          lineHeight: 1,
        }}
      >
        Av Sidwell
      </h1>

      {/* Thin cyan divider */}
      <div className="divider-cyan" style={{ width: '55%' }} />

      {/* Descriptor */}
      <p
        style={{
          fontFamily: 'var(--ff-mono)',
          fontSize: '0.78rem',
          letterSpacing: '0.12em',
          color: 'var(--text-mid)',
          maxWidth: 420,
          lineHeight: 2,
        }}
      >
        UI Developer &amp; Designer building immersive digital experiences
        with modern web technologies.
      </p>

      {/* CTA row */}
      <div style={{ display: 'flex', gap: '1rem', marginTop: '0.5rem' }}>
        <button className="btn-outline btn-outline-cyan">View Work</button>
        <button className="btn-outline btn-outline-muted">Contact Me</button>
      </div>
    </section>
  )
}
