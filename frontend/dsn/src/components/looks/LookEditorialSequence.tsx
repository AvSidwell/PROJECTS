import Image from "next/image";
import type { Look } from "@/types/content";
import { label, heading, bodyText } from "@/lib/styles";

export default function LookEditorialSequence({ look }: { look: Look }) {
  const [wide, portrait, lowAngle] = look.images;

  return (
    <section className="look-05-sequence" style={{ backgroundColor: "#000", padding: "0 0 14vh" }}>
      {/* Wide banner — full bleed */}
      <div className="wide-banner" style={{ position: "relative", width: "100%", aspectRatio: "21/9", overflow: "hidden" }}>
        <Image src={wide.src} alt={look.name} fill sizes="100vw"
          style={{ objectFit: "cover", objectPosition: "center 35%" }} />
        <div style={{ position: "absolute", inset: 0, background: "linear-gradient(to top, rgba(0,0,0,0.6) 0%, transparent 50%)" }} />
        <div style={{ position: "absolute", bottom: 32, left: 52 }}>
          <p style={{ ...label(), fontSize: 14, letterSpacing: "0.42em", color: "rgba(201,163,92,1)", textShadow: "0 1px 8px rgba(0,0,0,0.7)" }}>{look.category} — {look.number}</p>
          <h2 style={{ ...heading("clamp(32px,4vw,64px)"), marginTop: 8, textShadow: "0 2px 12px rgba(0,0,0,0.5)" }}>{look.name}</h2>
        </div>
      </div>

      {/* Two portraits — asymmetric */}
      <div className="portrait-row" style={{ display: "flex", gap: 10, alignItems: "flex-start", padding: "12px 0 0" }}>
        {portrait && (
          <div style={{ position: "relative", flex: "0 0 60%", aspectRatio: "3/4", overflow: "hidden" }}>
            <Image src={portrait.src} alt={`${look.name} portrait`} fill sizes="60vw"
              style={{ objectFit: "cover", objectPosition: "center 15%" }} />
          </div>
        )}
        {lowAngle && (
          <div className="low-angle-col" style={{ flex: "0 0 40%", display: "flex", flexDirection: "column", paddingTop: "12vh", gap: 12 }}>
            <div style={{ position: "relative", width: "100%", aspectRatio: "3/4", overflow: "hidden" }}>
              <Image src={lowAngle.src} alt={`${look.name} low angle`} fill sizes="40vw"
                style={{ objectFit: "cover", objectPosition: "center 20%" }} />
            </div>
            <p style={{ ...bodyText(), fontSize: 14, maxWidth: "28ch", padding: "4px 8px 0 0" }}>{look.description}</p>
          </div>
        )}
      </div>

      <style>{`
        @media (max-width: 640px) {
          .look-05-sequence .wide-banner { aspect-ratio: 4/3 !important; }
          .look-05-sequence .wide-banner > div:last-child { bottom: 20px !important; left: 20px !important; }
          .look-05-sequence .portrait-row { flex-direction: column !important; gap: 2px !important; }
          .look-05-sequence .portrait-row > div { flex: none !important; width: 100% !important; }
          .look-05-sequence .low-angle-col { padding-top: 0 !important; }
          .look-05-sequence .low-angle-col p { padding: 16px 20px 0 !important; }
        }
      `}</style>
    </section>
  );
}
