'use client'

export type Section =
  | 'home' | 'about' | 'resume' | 'projects'
  | 'skills' | 'education' | 'testimonials' | 'contact'

interface SidebarProps {
  active: Section
  onNav: (s: Section) => void
}

/* ─── Icon SVGs ──────────────────────────────────────────────────────── */
const HomeIcon = () => (
  <svg viewBox="0 0 24 24" fill="currentColor" width="18" height="18">
    <path d="M10 20v-6h4v6h5v-8h3L12 3 2 12h3v8z" />
  </svg>
)
const AboutIcon = () => (
  <svg viewBox="0 0 24 24" fill="currentColor" width="18" height="18">
    <path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm1 15h-2v-6h2v6zm0-8h-2V7h2v2z" />
  </svg>
)
const ResumeIcon = () => (
  <svg viewBox="0 0 24 24" fill="currentColor" width="18" height="18">
    <path d="M14 2H6c-1.1 0-2 .9-2 2v16c0 1.1.9 2 2 2h12c1.1 0 2-.9 2-2V8l-6-6zM6 20V4h7v5h5v11H6zm2-5h8v2H8zm0-4h8v2H8zm0-4h5v2H8z" />
  </svg>
)
const ProjectsIcon = () => (
  <svg viewBox="0 0 24 24" fill="currentColor" width="18" height="18">
    <path d="M4 6h16v2H4zm0 5h16v2H4zm0 5h16v2H4z" />
  </svg>
)
const SkillsIcon = () => (
  <svg viewBox="0 0 24 24" fill="currentColor" width="18" height="18">
    <path d="M9 21c0 .55.45 1 1 1h4c.55 0 1-.45 1-1v-1H9v1zm3-19C8.14 2 5 5.14 5 9c0 2.38 1.19 4.47 3 5.74V17c0 .55.45 1 1 1h6c.55 0 1-.45 1-1v-2.26c1.81-1.27 3-3.36 3-5.74 0-3.86-3.14-7-7-7z" />
  </svg>
)
const EducationIcon = () => (
  <svg viewBox="0 0 24 24" fill="currentColor" width="18" height="18">
    <path d="M5 13.18v4L12 21l7-3.82v-4L12 17l-7-3.82zM12 3L1 9l11 6 9-4.91V17h2V9L12 3z" />
  </svg>
)
const TestimonialsIcon = () => (
  <svg viewBox="0 0 24 24" fill="currentColor" width="18" height="18">
    <path d="M21 15c0 1.1-.9 2-2 2H7l-4 4V5c0-1.1.9-2 2-2h14c1.1 0 2 .9 2 2v10z" />
  </svg>
)
const ContactIcon = () => (
  <svg viewBox="0 0 24 24" fill="currentColor" width="18" height="18">
    <path d="M6.62 10.79c1.44 2.83 3.76 5.14 6.59 6.59l2.2-2.2c.27-.27.67-.36 1.02-.24 1.12.37 2.33.57 3.57.57.55 0 1 .45 1 1V20c0 .55-.45 1-1 1-9.39 0-17-7.61-17-17 0-.55.45-1 1-1h3.5c.55 0 1 .45 1 1 0 1.25.2 2.45.57 3.57.11.35.03.74-.25 1.02l-2.2 2.2z" />
  </svg>
)

const navItems: { id: Section; Icon: React.FC; label: string }[] = [
  { id: 'home',         Icon: HomeIcon,         label: 'Home' },
  { id: 'about',        Icon: AboutIcon,        label: 'About' },
  { id: 'resume',       Icon: ResumeIcon,       label: 'Resume' },
  { id: 'projects',     Icon: ProjectsIcon,     label: 'Projects' },
  { id: 'skills',       Icon: SkillsIcon,       label: 'Skills' },
  { id: 'education',    Icon: EducationIcon,    label: 'Education' },
  { id: 'testimonials', Icon: TestimonialsIcon, label: 'Testimonials' },
  { id: 'contact',      Icon: ContactIcon,      label: 'Contact' },
]

export default function Sidebar({ active, onNav }: SidebarProps) {
  return (
    <aside
      style={{
        width: 64,
        minWidth: 64,
        background: '#0a0c0b',
        borderRight: '1px solid #1a1e1c',
        display: 'flex',
        flexDirection: 'column',
        alignItems: 'center',
        padding: '2rem 0 1.25rem',
        zIndex: 20,
        gap: 0,
      }}
    >
      {/* Nav icons */}
      <nav
        style={{
          display: 'flex',
          flexDirection: 'column',
          gap: '0.2rem',
          flex: 1,
          width: '100%',
          alignItems: 'center',
        }}
      >
        {navItems.map(({ id, Icon, label }) => (
          <button
            key={id}
            className={`nav-btn${active === id ? ' on' : ''}`}
            title={label}
            onClick={() => onNav(id)}
            style={{ width: '100%', paddingLeft: 0, paddingRight: 0 }}
          >
            <Icon />
          </button>
        ))}
      </nav>

      {/* Social icons */}
      <div
        style={{
          display: 'flex',
          flexDirection: 'column',
          alignItems: 'center',
          gap: '0.45rem',
          marginBottom: '0.75rem',
        }}
      >
        {[
          { label: 'f',  title: 'Facebook' },
          { label: 'in', title: 'LinkedIn' },
          { label: '𝕏',  title: 'X / Twitter' },
        ].map((s) => (
          <div key={s.title} className="social-badge" title={s.title}>
            {s.label}
          </div>
        ))}
      </div>

      {/* Personal badge circle */}
      <div
        title="AvSidwell"
        style={{
          width: 36,
          height: 36,
          borderRadius: '50%',
          border: '1px solid #2e3231',
          background: '#131513',
          display: 'flex',
          alignItems: 'center',
          justifyContent: 'center',
          fontFamily: 'var(--ff-mono)',
          fontSize: '0.6rem',
          letterSpacing: '0.05em',
          color: 'var(--text-lo)',
          cursor: 'pointer',
          userSelect: 'none',
        }}
      >
        AS
      </div>
    </aside>
  )
}
