import Image from "next/image";
import type { Look } from "@/types/content";
import { label, heading, bodyText } from "@/lib/styles";

export default function LookFeatureSingle({ look }: { look: Look }) {
  const [feature] = look.images;

  return (
    <section
      className="look-feature-single"
      style={{ backgroundColor: "#000", padding: "10vh 0 12vh", display: "flex", flexDirection: "column", alignItems: "center" }}
    >
      {/* Feature image — centered, max 72vw */}
      <div
        className="feature-image-wrap"
        style={{
          position: "relative",
          width: "72vw",
          maxWidth: 1080,
          aspectRatio: "2/3",
          overflow: "hidden",
        }}
      >
        <Image
          src={feature.src}
          alt={look.name}
          fill
          sizes="72vw"
          style={{ objectFit: "cover", objectPosition: "center 10%", filter: "brightness(0.92) contrast(1.04)" }}
        />
      </div>

      {/* Text block — bottom-left of image area */}
      <div
        className="feature-text"
        style={{
          width: "72vw",
          maxWidth: 1080,
          marginTop: 28,
          display: "flex",
          justifyContent: "space-between",
          alignItems: "flex-end",
          gap: 24,
        }}
      >
        <div style={{ display: "flex", flexDirection: "column", gap: 10 }}>
          <p style={label()}>{look.category} — {look.number}</p>
          <h2 style={heading("clamp(28px,3vw,52px)")}>{look.name}</h2>
        </div>
        <p style={{ ...bodyText(), maxWidth: "30ch", textAlign: "right", fontSize: 14, opacity: 0.7 }}>
          {look.description}
        </p>
      </div>

      <style>{`
        @media (max-width: 640px) {
          .look-feature-single .feature-image-wrap { width: 100% !important; max-width: none !important; aspect-ratio: 3/4 !important; }
          .look-feature-single .feature-text { width: 100% !important; max-width: none !important; padding: 0 20px !important; flex-direction: column !important; align-items: flex-start !important; }
          .look-feature-single .feature-text p { text-align: left !important; }
        }
      `}</style>
    </section>
  );
}
