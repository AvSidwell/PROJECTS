'use client'

import { useState } from 'react'

const INFO = [
  { k: 'Email',    v: 'hello@avsidwell.dev' },
  { k: 'LinkedIn', v: '/in/avsidwell' },
  { k: 'GitHub',   v: 'github.com/AvSidwell' },
  { k: 'Location', v: 'Remote Worldwide' },
]

export default function ContactSection() {
  const [form, setForm] = useState({ name: '', email: '', message: '' })

  function set(k: keyof typeof form) {
    return (e: React.ChangeEvent<HTMLInputElement | HTMLTextAreaElement>) =>
      setForm((f) => ({ ...f, [k]: e.target.value }))
  }

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
      <h2 className="title-display">Contact</h2>
      <div className="divider-cyan" />

      <div style={{ display: 'flex', gap: '4rem', flex: 1, flexWrap: 'wrap', alignItems: 'flex-start' }}>

        {/* Left — contact details */}
        <div style={{ flex: '0 0 180px', display: 'flex', flexDirection: 'column', gap: '1.4rem' }}>
          <p
            className="lk"
            style={{ fontSize: '0.58rem', letterSpacing: '0.22em', color: 'var(--cyan-dim)', marginBottom: '0.2rem' }}
          >
            Get In Touch
          </p>
          {INFO.map((r) => (
            <div key={r.k}>
              <div className="lk" style={{ fontSize: '0.6rem', marginBottom: '0.25rem' }}>{r.k}:</div>
              <div className="lv" style={{ fontSize: '0.72rem' }}>{r.v}</div>
            </div>
          ))}
        </div>

        {/* Right — form */}
        <form
          style={{ flex: 1, minWidth: 220, display: 'flex', flexDirection: 'column', gap: '1.1rem' }}
          onSubmit={(e) => e.preventDefault()}
        >
          <div>
            <label className="lk" style={{ display: 'block', fontSize: '0.6rem', marginBottom: '0.3rem' }}>
              Name:
            </label>
            <input className="field" value={form.name} onChange={set('name')} placeholder="Your name" />
          </div>

          <div>
            <label className="lk" style={{ display: 'block', fontSize: '0.6rem', marginBottom: '0.3rem' }}>
              Email:
            </label>
            <input className="field" type="email" value={form.email} onChange={set('email')} placeholder="your@email.com" />
          </div>

          <div>
            <label className="lk" style={{ display: 'block', fontSize: '0.6rem', marginBottom: '0.3rem' }}>
              Message:
            </label>
            <textarea className="field" rows={5} value={form.message} onChange={set('message')} placeholder="Tell me about your project..." />
          </div>

          <button
            type="submit"
            className="btn-outline btn-outline-pink"
            style={{ alignSelf: 'flex-start' }}
          >
            Send Message
          </button>
        </form>
      </div>

      <div className="divider-cyan" />
    </section>
  )
}
