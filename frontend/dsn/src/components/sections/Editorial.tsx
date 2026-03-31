import Image from "next/image";
import type { EditorialPiece } from "@/types/content";
import { label, heading } from "@/lib/styles";

interface Props {
  pieces: EditorialPiece[];
  season: string;
}

export default function Editorial({ pieces, season }: Props) {
  return (
    <section id="editorial" style={{ backgroundColor: "#000", padding: "120px 0" }}>
      {/* Section header */}
      <div style={{ display: "flex", justifyContent: "space-between", alignItems: "baseline", padding: "0 52px", marginBottom: 32 }}>
        <p style={label()}>Editorial</p>
        <p style={{ ...label(), color: "rgba(243,239,232,0.3)" }}>{season}</p>
      </div>

      {/* Two-column grid, second card offset */}
      <div style={{ display: "grid", gridTemplateColumns: "1fr 1fr", gap: 2 }}>
        {pieces.map((piece, i) => (
          <div key={piece.id} style={{ marginTop: i === 1 ? "10vh" : 0 }}>
            <div style={{ position: "relative", width: "100%", aspectRatio: "3/4", overflow: "hidden" }}>
              <Image
                src={piece.image}
                alt={piece.title}
                fill
                sizes="50vw"
                style={{ objectFit: "cover", objectPosition: "center 20%" }}
              />
              {/* Gradient overlay */}
              <div style={{
                position: "absolute", inset: 0,
                background: "linear-gradient(to top, rgba(10,10,10,0.88) 0%, rgba(10,10,10,0.1) 45%, transparent 70%)",
              }} />
              {/* Title + related look */}
              <div style={{ position: "absolute", bottom: 0, left: 0, right: 0, padding: 32, display: "flex", flexDirection: "column", gap: 10 }}>
                {piece.relatedLooks.length > 0 && (
                  <p style={{ ...label(), color: "rgba(201,163,92,0.6)" }}>
                    Look {piece.relatedLooks[0].replace("look-", "")}
                  </p>
                )}
                <h3 style={heading("clamp(28px,3vw,52px)")}>{piece.title}</h3>
              </div>
            </div>
          </div>
        ))}
      </div>

      <style>{`
        @media (max-width: 640px) {
          #editorial > div:last-of-type {
            grid-template-columns: 1fr !important;
          }
          #editorial > div:last-of-type > div:last-child {
            margin-top: 2px !important;
          }
        }
        @media (max-width: 1024px) and (min-width: 641px) {
          #editorial > div:last-of-type > div:last-child {
            margin-top: 5vh !important;
          }
        }
      `}</style>
    </section>
  );
}
