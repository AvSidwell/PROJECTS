"use client";
import { useState, useEffect } from "react";

export default function Navbar() {
  const [scrolled, setScrolled] = useState(false);

  useEffect(() => {
    const onScroll = () => setScrolled(window.scrollY > 60);
    window.addEventListener("scroll", onScroll, { passive: true });
    return () => window.removeEventListener("scroll", onScroll);
  }, []);

  return (
    <>
      <nav
        style={{
          position: "fixed",
          top: 0,
          left: 0,
          right: 0,
          height: 52,
          zIndex: 50,
          display: "flex",
          alignItems: "center",
          justifyContent: "space-between",
          padding: "0 32px",
          background: scrolled ? "rgba(0,0,0,0.82)" : "transparent",
          backdropFilter: scrolled ? "blur(12px)" : "none",
          WebkitBackdropFilter: scrolled ? "blur(12px)" : "none",
          transition: "background 0.35s ease, backdrop-filter 0.35s ease",
        }}
      >
        {/* Brand mark */}
        <a
          href="#"
          style={{
            fontFamily: "var(--font-brand)",
            fontSize: 11,
            letterSpacing: "0.38em",
            textTransform: "uppercase",
            color: "rgba(201,163,92,0.88)",
            textDecoration: "none",
          }}
        >
          DSN
        </a>

        {/* Nav links — hidden on mobile via class */}
        <div className="navbar-links" style={{ display: "flex", gap: 36 }}>
          {[
            { label: "Collection", href: "#collection" },
            { label: "Editorial", href: "#editorial" },
            { label: "Archive", href: "#" },
          ].map(({ label, href }) => (
            <a key={label} href={href} className="footer-nav-link">
              {label}
            </a>
          ))}
        </div>
      </nav>

      <style>{`
        @media (max-width: 640px) {
          .navbar-links { display: none !important; }
        }
      `}</style>
    </>
  );
}
