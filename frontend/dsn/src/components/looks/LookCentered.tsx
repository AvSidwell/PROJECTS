"use client";
import { useState } from "react";
import Image from "next/image";
import type { Look } from "@/types/content";
import { label, heading, bodyText, ghost } from "@/lib/styles";
import Modal from "@/components/ui/Modal";

export default function LookCentered({ look }: { look: Look }) {
  const [open, setOpen] = useState(false);
  const [img] = look.images;

  return (
    <section style={{ backgroundColor: "#0a0a0a", display: "flex", flexDirection: "column", alignItems: "center", padding: "14vh 0 16vh", gap: 0 }}>
      <p style={{ ...ghost(), alignSelf: "flex-start", paddingLeft: "6vw", marginBottom: "-0.06em" }}>{look.number}</p>

      {/* Clickable image */}
      <div
        role="button"
        tabIndex={0}
        onClick={() => setOpen(true)}
        onKeyDown={e => e.key === "Enter" && setOpen(true)}
        className="look-clickable"
        style={{ position: "relative", width: "44vw", aspectRatio: String(img.aspectRatio), overflow: "hidden", cursor: "zoom-in", pointerEvents: "auto" }}
      >
        <Image src={img.src} alt={look.name} fill sizes="44vw"
          style={{ objectFit: "cover", objectPosition: "center 20%" }} />
      </div>

      {/* Caption row */}
      <div style={{ width: "44vw", display: "flex", justifyContent: "space-between", alignItems: "flex-start", paddingTop: 20, gap: 24 }}>
        <div style={{ display: "flex", flexDirection: "column", gap: 6 }}>
          <p style={label()}>{look.category}</p>
          <h2 style={heading("clamp(26px,2.8vw,44px)")}>{look.name}</h2>
        </div>
        <p style={{ ...bodyText(), fontSize: 13, maxWidth: "22ch", textAlign: "right" }}>{look.description}</p>
      </div>

      {/* Modal — single image + copy */}
      <Modal open={open} onClose={() => setOpen(false)} maxWidth="60vw">
        <div style={{ display: "flex", flexDirection: "column", alignItems: "center", gap: 20, padding: "24px 0" }}>
          <div style={{ position: "relative", width: "100%", aspectRatio: String(img.aspectRatio), overflow: "hidden" }}>
            <Image src={img.src} alt={look.name} fill sizes="60vw"
              style={{ objectFit: "cover", objectPosition: "center 20%" }} />
          </div>
          <div style={{ display: "flex", flexDirection: "column", gap: 8, alignSelf: "flex-start" }}>
            <p style={label()}>{look.category} — {look.number}</p>
            <h2 style={heading("clamp(24px,2.5vw,40px)")}>{look.name}</h2>
            <p style={{ ...bodyText(), fontSize: 14, maxWidth: "48ch", marginTop: 4 }}>{look.description}</p>
          </div>
        </div>
      </Modal>
    </section>
  );
}
