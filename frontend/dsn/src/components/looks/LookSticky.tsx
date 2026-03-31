import Image from "next/image";
import type { Look } from "@/types/content";
import { label, heading, bodyText, ghost } from "@/lib/styles";

export default function LookSticky({ look }: { look: Look }) {
  return (
    <section className="look-03-sticky" style={{ display: "grid", gridTemplateColumns: "38% 62%", minHeight: "180vh", backgroundColor: "#0a0a0a" }}>
      {/* Sticky text — left */}
      <div className="sticky-text" style={{ position: "relative" }}>
        <div className="sticky-inner" style={{ position: "sticky", top: 0, height: "100vh", display: "flex", flexDirection: "column", justifyContent: "center", padding: "0 40px 0 52px", gap: 24 }}>
          <p style={label()}>{look.number}</p>
          <h2 style={heading("clamp(36px,4vw,68px)")}>{look.name}</h2>
          <div style={{ width: 32, height: 1, backgroundColor: "rgba(201,163,92,0.35)" }} />
          <p style={{ ...bodyText(), maxWidth: "26ch" }}>{look.description}</p>
          <p style={{ ...label(), color: "rgba(243,239,232,0.25)", marginTop: 8 }}>{look.category}</p>
          <p style={{ ...ghost("clamp(80px,10vw,160px)"), position: "absolute", bottom: 40, left: 32, margin: 0 }}>{look.number}</p>
        </div>
      </div>

      {/* Scrolling images — right (all images in array) */}
      <div className="image-stack" style={{ display: "flex", flexDirection: "column", gap: 12, padding: "10vh 48px 16vh 12px" }}>
        {look.images.map((img, i) => (
          <div key={img.name} style={{
            position: "relative",
            width: i % 2 === 0 ? "100%" : "72%",
            alignSelf: i % 2 === 0 ? "auto" : "flex-end",
            aspectRatio: i % 2 === 0 ? "3/4" : "4/5",
            overflow: "hidden",
          }}>
            <Image src={img.src} alt={`${look.name} ${i + 1}`} fill
              sizes={i % 2 === 0 ? "55vw" : "40vw"}
              style={{ objectFit: "cover", objectPosition: "center 15%" }} />
          </div>
        ))}
      </div>

      <style>{`
        @media (max-width: 640px) {
          .look-03-sticky { display: block !important; min-height: auto !important; }
          .look-03-sticky .sticky-text { position: static !important; }
          .look-03-sticky .sticky-inner { position: static !important; height: auto !important; padding: 48px 20px 32px !important; }
          .look-03-sticky .image-stack { padding: 0 20px 48px !important; }
          .look-03-sticky .image-stack > div:last-child { width: 100% !important; align-self: stretch !important; }
        }
        @media (max-width: 1024px) and (min-width: 641px) {
          .look-03-sticky { grid-template-columns: 42% 58% !important; }
          .look-03-sticky .sticky-inner { padding: 0 24px 0 32px !important; }
        }
      `}</style>
    </section>
  );
}
