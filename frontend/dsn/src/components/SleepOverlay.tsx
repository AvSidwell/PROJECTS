"use client";

import { useEffect, useState } from "react";
import Image from "next/image";

interface Props {
  active: boolean;
  onWake: () => void;
}

export default function SleepOverlay({ active, onWake }: Props) {
  const [time, setTime] = useState("");
  const [mounted, setMounted] = useState(false);

  useEffect(() => {
    setMounted(true);
    const tick = () => {
      const now = new Date();
      setTime(
        now.toLocaleTimeString("en-GB", { hour: "2-digit", minute: "2-digit" })
      );
    };
    tick();
    const id = setInterval(tick, 1000);
    return () => clearInterval(id);
  }, []);

  if (!mounted) return null;

  return (
    <div
      className="fixed inset-0 z-40 flex flex-col items-center justify-end pb-20"
      style={{
        opacity: active ? 1 : 0,
        pointerEvents: active ? "auto" : "none",
        transition: "opacity 1.4s ease",
        cursor: "pointer",
      }}
      onClick={onWake}
    >
      {/* Full-bleed image with slow zoom */}
      <div className="absolute inset-0 overflow-hidden">
        <Image
          src="/images/hero/hero-main.jpg"
          alt=""
          fill
          sizes="100vw"
          className="object-cover object-top"
          style={{
            animation: active ? "sleepZoom 20s ease-in-out infinite alternate" : "none",
            filter: "brightness(0.4)",
          }}
        />
      </div>

      {/* Overlay tint */}
      <div
        className="absolute inset-0"
        style={{ background: "linear-gradient(to top, rgba(0,0,0,0.7) 0%, transparent 60%)" }}
      />

      {/* Content */}
      <div className="relative z-10 flex flex-col items-center gap-5">
        <p
          className="text-7xl md:text-8xl tabular-nums"
          style={{
            fontFamily: "var(--font-brand)",
            color: "var(--color-offwhite)",
            letterSpacing: "0.05em",
          }}
        >
          {time}
        </p>

        <div className="flex flex-col items-center gap-2">
          <p
            className="text-xs tracking-[0.4em] uppercase"
            style={{ fontFamily: "var(--font-brand)", color: "var(--color-warm-gray)" }}
          >
            Tap to return
          </p>
          <span
            style={{
              display: "block",
              width: 4,
              height: 4,
              borderRadius: "50%",
              backgroundColor: "var(--color-gold)",
              animation: "pulse 2.4s ease-in-out infinite",
            }}
          />
        </div>
      </div>

      <style>{`
        @keyframes sleepZoom {
          from { transform: scale(1); }
          to   { transform: scale(1.07); }
        }
        @keyframes pulse {
          0%, 100% { opacity: 1; transform: scale(1); }
          50%       { opacity: 0.25; transform: scale(0.5); }
        }
      `}</style>
    </div>
  );
}
