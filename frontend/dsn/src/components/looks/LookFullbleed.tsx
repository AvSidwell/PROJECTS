"use client";
import { useState } from "react";
import Image from "next/image";
import type { Look } from "@/types/content";
import { label, heading, bodyText, ghost } from "@/lib/styles";
import Modal from "@/components/ui/Modal";

export default function LookFullbleed({ look }: { look: Look }) {
  const [open, setOpen] = useState(false);
  const [main, alt] = look.images;

  return (
    <section style={{ position: "relative", backgroundColor: "#000", padding: "0 0 120px" }}>
      {/* Large portrait — clickable */}
      <div
        role="button"
        tabIndex={0}
        onClick={() => setOpen(true)}
        onKeyDown={e => e.key === "Enter" && setOpen(true)}
        className="look-clickable"
        style={{ position: "relative", width: "66%", aspectRatio: "2/3", overflow: "hidden", cursor: "pointer", pointerEvents: "auto" }}
      >
        <Image src={main.src} alt={look.name} fill sizes="66vw"
          style={{ objectFit: "cover", objectPosition: "center 18%" }} />
        <div style={{ position: "absolute", inset: 0, background: "linear-gradient(to right, transparent 60%, rgba(0,0,0,0.85) 100%)" }} />
      </div>

      {/* Offset square card — also clickable */}
      {alt && (
        <div
          role="button"
          tabIndex={0}
          onClick={() => setOpen(true)}
          onKeyDown={e => e.key === "Enter" && setOpen(true)}
          className="look-clickable"
          style={{ position: "absolute", bottom: 60, right: "5vw", width: "28vw", aspectRatio: "1/1", overflow: "hidden", cursor: "pointer", pointerEvents: "auto", outline: "1px solid rgba(201,163,92,0.12)" }}
        >
          <Image src={alt.src} alt={`${look.name} detail`} fill sizes="28vw"
            style={{ objectFit: "cover", objectPosition: "center" }} />
        </div>
      )}

      {/* Text — right, vertically centered */}
      <div style={{ position: "absolute", top: "50%", right: "5vw", transform: "translateY(-50%)", width: "28vw", display: "flex", flexDirection: "column", gap: 16, zIndex: 2 }}>
        <p style={label()}>{look.category} — {look.number}</p>
        <h2 style={heading("clamp(40px,5vw,84px)")}>{look.name}</h2>
        <div style={{ width: 32, height: 1, backgroundColor: "rgba(201,163,92,0.35)" }} />
        <p style={{ ...bodyText(), maxWidth: "28ch" }}>{look.description}</p>
      </div>

      {/* Ghost number */}
      <p style={{ ...ghost(), position: "absolute", bottom: 16, left: "2vw" }}>{look.number}</p>

      {/* Diptych lightbox */}
      <Modal open={open} onClose={() => setOpen(false)} maxWidth="88vw">
        <div style={{ display: "flex", flexDirection: "column", alignItems: "center", gap: 24, padding: "24px 0" }}>
          <div style={{ display: "flex", gap: 8, alignItems: "flex-start", width: "100%" }}>
            <div style={{ position: "relative", flex: "0 0 58%", height: "80vh", overflow: "hidden" }}>
              <Image src={main.src} alt={look.name} fill sizes="50vw"
                style={{ objectFit: "cover", objectPosition: "center 18%" }} />
            </div>
            {alt && (
              <div style={{ position: "relative", flex: "0 0 42%", aspectRatio: "1/1", overflow: "hidden" }}>
                <Image src={alt.src} alt={`${look.name} detail`} fill sizes="38vw"
                  style={{ objectFit: "cover", objectPosition: "center" }} />
              </div>
            )}
          </div>
          <div style={{ display: "flex", flexDirection: "column", gap: 8, alignSelf: "flex-start", paddingLeft: 4 }}>
            <p style={label()}>{look.category} — {look.number}</p>
            <h2 style={heading("clamp(24px,2.5vw,40px)")}>{look.name}</h2>
            <p style={{ ...bodyText(), fontSize: 14, maxWidth: "50ch", marginTop: 4 }}>{look.description}</p>
          </div>
        </div>
      </Modal>
    </section>
  );
}
