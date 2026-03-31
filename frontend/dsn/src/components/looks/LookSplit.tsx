"use client";
import { useState } from "react";
import Image from "next/image";
import type { Look } from "@/types/content";
import { label, heading, bodyText } from "@/lib/styles";

export default function LookSplit({ look }: { look: Look }) {
  const [showDetail, setShowDetail] = useState(false);
  const [main, detail] = look.images;

  return (
    <section className="look-04-split" style={{ backgroundColor: "#0a0a0a", padding: "10vh 0 14vh" }}>
      {/* Header */}
      <div style={{ display: "flex", justifyContent: "space-between", alignItems: "baseline", padding: "0 52px", marginBottom: 24 }}>
        <p style={label()}>{look.category} — {look.number}</p>
        <h2 style={heading("clamp(28px,3vw,48px)")}>{look.name}</h2>
      </div>

      {/* Image pair */}
      <div className="image-pair" style={{ display: "flex", gap: 8, alignItems: "flex-start" }}>
        {/* Main slot — stacks both images, swaps on hover/click */}
        <div
          onMouseEnter={() => setShowDetail(true)}
          onMouseLeave={() => setShowDetail(false)}
          onClick={() => setShowDetail(v => !v)}
          style={{ position: "relative", flex: "0 0 58%", aspectRatio: "4/5", overflow: "hidden", cursor: "pointer", pointerEvents: "auto" }}
        >
          <div style={{ position: "absolute", inset: 0, opacity: showDetail ? 0 : 1, transition: "opacity 280ms ease" }}>
            <Image src={main.src} alt={look.name} fill sizes="58vw"
              style={{ objectFit: "cover", objectPosition: "center 18%" }} />
          </div>
          {detail && (
            <div style={{ position: "absolute", inset: 0, opacity: showDetail ? 1 : 0, transition: "opacity 280ms ease" }}>
              <Image src={detail.src} alt={`${look.name} detail`} fill sizes="58vw"
                style={{ objectFit: "cover", objectPosition: "center 22%" }} />
            </div>
          )}
        </div>

        {/* Static detail slot — pushed down */}
        {detail && (
          <div style={{ position: "relative", flex: "0 0 42%", aspectRatio: "4/5", marginTop: "8vh", overflow: "hidden" }}>
            <Image src={detail.src} alt={`${look.name} detail`} fill sizes="42vw"
              style={{ objectFit: "cover", objectPosition: "center 22%" }} />
          </div>
        )}
      </div>

      {/* Affordance + description */}
      <div style={{ padding: "16px 52px 0", display: "flex", justifyContent: "space-between", alignItems: "flex-start" }}>
        <p style={{ ...bodyText(), maxWidth: "38ch" }}>{look.description}</p>
        {detail && (
          <p style={{ ...label(), letterSpacing: "0.28em" }}>
            <span style={{ color: showDetail ? "rgba(201,163,92,0.4)" : "rgba(201,163,92,0.85)" }}>Portrait</span>
            {" · "}
            <span style={{ color: showDetail ? "rgba(201,163,92,0.85)" : "rgba(201,163,92,0.4)" }}>Detail</span>
          </p>
        )}
      </div>

      <style>{`
        @media (max-width: 640px) {
          .look-04-split .image-pair { flex-direction: column !important; gap: 16px !important; }
          .look-04-split .image-pair > div { flex: none !important; width: 100% !important; margin-top: 0 !important; }
        }
      `}</style>
    </section>
  );
}
