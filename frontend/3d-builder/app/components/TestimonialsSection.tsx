'use client'

import { useState } from 'react'

const CARDS = [
  {
    quote: 'Av has an exceptional eye for detail and delivered a product that far exceeded our expectations. The UI is clean, fast, and a joy to use.',
    author: 'Sarah M.',
    role: 'Product Director, CreativeCo',
  },
  {
    quote: 'Working with Av was seamless. They brought genuine craft to every interaction — from the micro-animations to the overall information architecture.',
    author: 'James T.',
    role: 'CTO, StartupLab',
  },
  {
    quote: "Av's ability to bridge design and engineering is rare. They spoke both languages fluently and kept the whole team aligned throughout.",
    author: 'Priya K.',
    role: 'Lead Designer, DigitalStudio',
  },
]

export default function TestimonialsSection() {
  const [idx, setIdx] = useState(0)
  const t = CARDS[idx]

  function prev() { setIdx((i) => (i - 1 + CARDS.length) % CARDS.length) }
  function next() { setIdx((i) => (i + 1) % CARDS.length) }

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
      <h2 className="title-display">Testimonials</h2>
      <div className="divider-cyan" />

      {/* Centered card */}
      <div
        style={{
          flex: 1,
          display: 'flex',
          alignItems: 'center',
          justifyContent: 'center',
        }}
      >
        {/* Tall outlined card */}
        <div
          key={idx}
          style={{
            width: 340,
            border: '1px solid #1e2220',
            background: 'rgba(0,0,0,0.3)',
            padding: '2.5rem 2rem',
            display: 'flex',
            flexDirection: 'column',
            alignItems: 'center',
            gap: '1.5rem',
            animation: 'sectionIn 0.3s ease',
          }}
        >
          {/* Avatar circle */}
          <div
            style={{
              width: 56, height: 56,
              borderRadius: '50%',
              border: '1px solid #2a2e2c',
              background: '#131513',
              display: 'flex',
              alignItems: 'center',
              justifyContent: 'center',
            }}
          >
            <svg viewBox="0 0 24 24" fill="#1e2220" width="28" height="28">
              <path d="M12 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0 2c-2.67 0-8 1.34-8 4v2h16v-2c0-2.66-5.33-4-8-4z" />
            </svg>
          </div>

          {/* Quote open mark */}
          <div
            style={{
              fontFamily: 'var(--ff-display)',
              fontSize: '3.5rem',
              color: 'var(--pink)',
              lineHeight: 1,
              opacity: 0.35,
              marginBottom: '-1.2rem',
              alignSelf: 'flex-start',
            }}
          >
            &ldquo;
          </div>

          {/* Quote text */}
          <p
            style={{
              fontFamily: 'var(--ff-display)',
              fontStyle: 'italic',
              fontSize: '1rem',
              lineHeight: 1.75,
              color: 'var(--text-mid)',
              textAlign: 'center',
              letterSpacing: '0.02em',
            }}
          >
            {t.quote}
          </p>

          {/* Author */}
          <div style={{ textAlign: 'center' }}>
            <div className="lv" style={{ fontSize: '0.75rem' }}>{t.author}</div>
            <div className="dc" style={{ fontSize: '0.62rem', marginTop: '0.2rem' }}>{t.role}</div>
          </div>
        </div>
      </div>

      {/* Dots */}
      <div style={{ display: 'flex', justifyContent: 'center', gap: '0.5rem' }}>
        {CARDS.map((_, i) => (
          <div key={i} className={`dot${i === idx ? ' on' : ''}`} onClick={() => setIdx(i)} />
        ))}
      </div>

      {/* Arrows */}
      <div style={{ display: 'flex', justifyContent: 'center', gap: '0.75rem' }}>
        <button
          onClick={prev}
          style={{
            background: 'none',
            border: '1px solid #2a2e2c',
            color: 'var(--text-lo)',
            width: 34, height: 34,
            cursor: 'pointer',
            fontSize: '1rem',
            display: 'flex', alignItems: 'center', justifyContent: 'center',
            transition: 'border-color 0.2s, color 0.2s',
          }}
          onMouseEnter={(e) => { e.currentTarget.style.borderColor = 'var(--pink)'; e.currentTarget.style.color = 'var(--pink)' }}
          onMouseLeave={(e) => { e.currentTarget.style.borderColor = '#2a2e2c';    e.currentTarget.style.color = 'var(--text-lo)' }}
        >
          ‹
        </button>
        <button
          onClick={next}
          style={{
            background: 'none',
            border: '1px solid var(--pink)',
            color: 'var(--pink)',
            width: 34, height: 34,
            cursor: 'pointer',
            fontSize: '1rem',
            display: 'flex', alignItems: 'center', justifyContent: 'center',
            transition: 'opacity 0.2s',
          }}
          onMouseEnter={(e) => { e.currentTarget.style.opacity = '0.7' }}
          onMouseLeave={(e) => { e.currentTarget.style.opacity = '1' }}
        >
          ›
        </button>
      </div>

      <div className="divider-cyan" />
    </section>
  )
}
