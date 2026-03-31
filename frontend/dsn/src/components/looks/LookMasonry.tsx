"use client";
import { useState } from "react";
import Image from "next/image";
import type { Look } from "@/types/content";
import { label, heading, bodyText, ghost } from "@/lib/styles";
import Modal from "@/components/ui/Modal";
import Carousel from "@/components/ui/Carousel";

export default function LookMasonry({ look }: { look: Look }) {
  const [carouselOpen, setCarouselOpen] = useState(false);
  const [activeIndex, setActiveIndex] = useState(0);
  const [main, cropA, cropB, profile] = look.images;

  const open = (i: number) => { setActiveIndex(i); setCarouselOpen(true); };

  const cellStyle = (gridRow: string, gridColumn: string): React.CSSProperties => ({
    position: "relative",
    gridRow,
    gridColumn,
    overflow: "hidden",
    cursor: "pointer",
    pointerEvents: "auto",
  });

  return (
    <section className="look-06-masonry" style={{ backgroundColor: "#0a0a0a", padding: "10vh 0 16vh" }}>
      {/* Header */}
      <div style={{ display: "flex", justifyContent: "space-between", alignItems: "baseline", padding: "0 52px 32px" }}>
        <div style={{ display: "flex", flexDirection: "column", gap: 8 }}>
          <p style={label()}>{look.category} — {look.number}</p>
          <h2 style={heading("clamp(30px,3.5vw,56px)")}>{look.name}</h2>
        </div>
        <p style={{ ...bodyText(), fontSize: 14, maxWidth: "28ch", textAlign: "right" }}>{look.description}</p>
      </div>

      {/* Masonry grid */}
      <div className="masonry-grid" style={{ display: "grid", gridTemplateColumns: "1.8fr 1fr 1.3fr", gridTemplateRows: "1fr 1fr", gap: 8, height: "88vh", padding: "0 8px" }}>
        {main && (
          <div role="button" tabIndex={0} onClick={() => open(0)} onKeyDown={e => e.key === "Enter" && open(0)}
            className="look-clickable" style={cellStyle("1 / 3", "1")}>
            <Image src={main.src} alt={look.name} fill sizes="45vw"
              style={{ objectFit: "cover", objectPosition: "center 15%" }} />
          </div>
        )}
        {cropA && (
          <div role="button" tabIndex={0} onClick={() => open(1)} onKeyDown={e => e.key === "Enter" && open(1)}
            className="look-clickable" style={cellStyle("1", "2")}>
            <Image src={cropA.src} alt={`${look.name} A`} fill sizes="25vw"
              style={{ objectFit: "cover", objectPosition: "center 20%" }} />
          </div>
        )}
        {cropB && (
          <div role="button" tabIndex={0} onClick={() => open(2)} onKeyDown={e => e.key === "Enter" && open(2)}
            className="look-clickable" style={cellStyle("2", "2")}>
            <Image src={cropB.src} alt={`${look.name} B`} fill sizes="25vw"
              style={{ objectFit: "cover", objectPosition: "center 30%" }} />
          </div>
        )}
        {profile && (
          <div role="button" tabIndex={0} onClick={() => open(3)} onKeyDown={e => e.key === "Enter" && open(3)}
            className="look-clickable" style={cellStyle("1 / 3", "3")}>
            <Image src={profile.src} alt={`${look.name} profile`} fill sizes="30vw"
              style={{ objectFit: "cover", objectPosition: "center 18%" }} />
          </div>
        )}
      </div>

      <p style={{ ...ghost(), textAlign: "right", paddingRight: "4vw", marginTop: -20 }}>{look.number}</p>

      {/* Carousel modal */}
      <Modal open={carouselOpen} onClose={() => setCarouselOpen(false)} maxWidth="80vw">
        <Carousel images={look.images} initialIndex={activeIndex} lookName={look.name} />
      </Modal>

      <style>{`
        @media (max-width: 640px) {
          .look-06-masonry .masonry-grid {
            display: flex !important; flex-direction: column !important;
            height: auto !important; gap: 2px !important; padding: 0 !important;
          }
          .look-06-masonry .masonry-grid > div {
            position: relative !important; grid-column: unset !important; grid-row: unset !important;
            aspect-ratio: 3/4 !important; width: 100% !important; height: auto !important;
          }
          .look-06-masonry [style*="ghost"] { display: none !important; }
        }
        @media (max-width: 1024px) and (min-width: 641px) {
          .look-06-masonry .masonry-grid { height: 70vh !important; }
        }
      `}</style>
    </section>
  );
}
