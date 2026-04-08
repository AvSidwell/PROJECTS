'use client'

const exp = [
  {
    title: 'Senior UI Developer',
    org:   'Creative Studio',
    year:  '2022 — Present',
    desc:  'Leading frontend architecture and design system development for enterprise-grade React applications.',
  },
  {
    title: 'Frontend Developer',
    org:   'Digital Agency',
    year:  '2020 — 2022',
    desc:  'Built responsive marketing sites and interactive apps with Next.js and Tailwind CSS.',
  },
  {
    title: 'UI/UX Designer',
    org:   'StartupCo',
    year:  '2019 — 2020',
    desc:  'Prototyped interfaces for mobile and web, bridging design and engineering.',
  },
]

const edu = [
  {
    title: 'BSc Computer Science',
    org:   'University of Technology',
    year:  '2015 — 2019',
    desc:  'Specialised in Human-Computer Interaction and Software Engineering.',
  },
  {
    title: 'Google UX Design Certificate',
    org:   'Google / Coursera',
    year:  '2020',
    desc:  'Professional certificate covering UX research, wireframing, and high-fidelity prototyping.',
  },
]

function Item({
  title, org, year, desc,
}: { title: string; org: string; year: string; desc: string }) {
  return (
    <div style={{ paddingLeft: '1rem', borderLeft: '1px solid #1e2220', position: 'relative', paddingBottom: '1.6rem' }}>
      {/* dot */}
      <div
        style={{
          position: 'absolute', left: -4, top: 5,
          width: 7, height: 7, borderRadius: '50%',
          background: 'var(--pink)',
        }}
      />
      <div style={{ display: 'flex', justifyContent: 'space-between', flexWrap: 'wrap', gap: '0.2rem', marginBottom: '0.2rem' }}>
        <span className="lv" style={{ fontSize: '0.78rem' }}>{title}</span>
        <span
          style={{
            fontFamily: 'var(--ff-mono)',
            fontSize: '0.6rem',
            letterSpacing: '0.1em',
            color: 'var(--cyan-dim)',
          }}
        >
          {year}
        </span>
      </div>
      <div className="lk" style={{ fontSize: '0.62rem', color: 'var(--text-lo)', marginBottom: '0.35rem' }}>
        {org}
      </div>
      <p className="dc" style={{ fontSize: '0.68rem' }}>{desc}</p>
    </div>
  )
}

export default function ResumeSection() {
  return (
    <section
      style={{
        position: 'relative',
        zIndex: 1,
        height: '100%',
        padding: '2.5rem 3.5rem 2rem',
        display: 'flex',
        flexDirection: 'column',
        gap: '1.4rem',
        overflowY: 'auto',
      }}
    >
      <h2 className="title-display">Resume</h2>
      <div className="divider-cyan" />

      <div style={{ display: 'flex', gap: '4rem', flex: 1, flexWrap: 'wrap', alignItems: 'flex-start' }}>
        {/* Experience */}
        <div style={{ flex: 1, minWidth: 200 }}>
          <p
            className="lk"
            style={{ fontSize: '0.6rem', letterSpacing: '0.22em', color: 'var(--cyan-dim)', marginBottom: '1.4rem' }}
          >
            Experience
          </p>
          {exp.map((e) => <Item key={e.title} {...e} />)}
        </div>

        {/* Education */}
        <div style={{ flex: 1, minWidth: 200 }}>
          <p
            className="lk"
            style={{ fontSize: '0.6rem', letterSpacing: '0.22em', color: 'var(--cyan-dim)', marginBottom: '1.4rem' }}
          >
            Education
          </p>
          {edu.map((e) => <Item key={e.title} {...e} />)}
        </div>
      </div>

      <div className="divider-cyan" />
    </section>
  )
}
