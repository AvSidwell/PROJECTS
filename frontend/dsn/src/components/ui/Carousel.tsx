"use client";
import { useState, useEffect } from "react";
import Image from "next/image";
import type { LookImage } from "@/types/content";
import { label } from "@/lib/styles";

interface Props {
  images: LookImage[];
  initialIndex: number;
  lookName: string;
}

export default function Carousel({ images, initialIndex, lookName }: Props) {
  const [current, setCurrent] = useState(initialIndex);

  useEffect(() => { setCurrent(initialIndex); }, [initialIndex]);

  useEffect(() => {
    const handler = (e: KeyboardEvent) => {
      if (e.key === "ArrowLeft")  setCurrent(i => (i - 1 + images.length) % images.length);
      if (e.key === "ArrowRight") setCurrent(i => (i + 1) % images.length);
    };
    window.addEventListener("keydown", handler);
    return () => window.removeEventListener("keydown", handler);
  }, [images.length]);

  const prev = () => setCurrent(i => (i - 1 + images.length) % images.length);
  const next = () => setCurrent(i => (i + 1) % images.length);

  const img = images[current];

  return (
    <div style={{ display: "flex", flexDirection: "column", alignItems: "center", gap: 20, padding: "0 48px" }}>
      {/* Image */}
      <div style={{ position: "relative", height: "78vh", aspectRatio: String(img.aspectRatio), overflow: "hidden" }}>
        <Image
          key={current}
          src={img.src}
          alt={`${lookName} ${current + 1}`}
          fill
          sizes="80vw"
          style={{ objectFit: "cover", objectPosition: "center 18%", animation: "heroFadeIn 220ms ease both" }}
        />
      </div>

      {/* Controls */}
      <div style={{ display: "flex", alignItems: "center", gap: 32 }}>
        <button
          onClick={prev}
          aria-label="Previous"
          style={{ background: "none", border: "none", cursor: "pointer", ...label(), color: "rgba(201,163,92,0.8)", fontSize: 16 }}
        >
          ←
        </button>

        <span style={{ ...label(), color: "rgba(243,239,232,0.5)", letterSpacing: "0.24em" }}>
          {String(current + 1).padStart(2, "0")} / {String(images.length).padStart(2, "0")}
        </span>

        <button
          onClick={next}
          aria-label="Next"
          style={{ background: "none", border: "none", cursor: "pointer", ...label(), color: "rgba(201,163,92,0.8)", fontSize: 16 }}
        >
          →
        </button>
      </div>
    </div>
  );
}
