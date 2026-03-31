interface Props {
  season: string;
  established: string;
}

export default function Footer({ season, established }: Props) {
  return (
    <footer style={{ backgroundColor: "#0a0a0a", padding: "64px 52px 48px" }}>
      {/* Gold hairline rule */}
      <div style={{ width: "100%", height: 1, backgroundColor: "rgba(201,163,92,0.12)", marginBottom: 48 }} />

      {/* Est. label */}
      <p style={{
        textAlign: "center",
        fontFamily: "var(--font-brand)",
        fontSize: 11,
        letterSpacing: "0.42em",
        textTransform: "uppercase",
        color: "rgba(201,163,92,0.45)",
        marginBottom: 40,
      }}>
        Est.&thinsp;{established}
      </p>

      {/* Middle row — season · mark · nav */}
      <div className="footer-row" style={{ display: "flex", justifyContent: "space-between", alignItems: "center", marginBottom: 48 }}>
        <p style={{
          fontFamily: "var(--font-brand)",
          fontSize: 11,
          letterSpacing: "0.38em",
          textTransform: "uppercase",
          color: "rgba(201,163,92,0.45)",
        }}>
          {season}
        </p>

        {/* Brand mark placeholder */}
        <span style={{
          fontFamily: "var(--font-brand)",
          fontSize: 20,
          color: "rgba(201,163,92,0.5)",
          letterSpacing: "0.12em",
        }}>
          ✦
        </span>

        {/* Nav */}
        <nav style={{ display: "flex", gap: 32 }}>
          <a href="#collection" className="footer-nav-link">Collection</a>
          <a href="#editorial" className="footer-nav-link">Editorial</a>
        </nav>
      </div>

      {/* Copyright row with flanking rules */}
      <div style={{ display: "flex", alignItems: "center", gap: 20 }}>
        <div style={{ flex: 1, height: 1, backgroundColor: "rgba(201,163,92,0.08)" }} />
        <p style={{
          fontFamily: "var(--font-body)",
          fontSize: 11,
          letterSpacing: "0.18em",
          color: "rgba(176,170,165,0.4)",
          whiteSpace: "nowrap",
        }}>
          © {new Date().getFullYear()}
        </p>
        <div style={{ flex: 1, height: 1, backgroundColor: "rgba(201,163,92,0.08)" }} />
      </div>

      <style>{`
        @media (max-width: 640px) {
          .footer-row {
            flex-direction: column !important;
            align-items: center !important;
            gap: 20px !important;
          }
        }
      `}</style>
    </footer>
  );
}
