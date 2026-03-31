"use client";
import { useState } from "react";
import Image from "next/image";
import type { HeroData, BrandData } from "@/types/content";

interface Props {
  data: HeroData;
  brand: BrandData;
}

export default function Hero({ data, brand }: Props) {
  const [triggered, setTriggered] = useState(false);

  const handleEnter = (e: React.MouseEvent) => {
    e.preventDefault();
    if (triggered) return;
    setTriggered(true);
    setTimeout(() => {
      document.getElementById("collection")?.scrollIntoView({ behavior: "smooth" });
    }, 820);
    setTimeout(() => setTriggered(false), 1400);
  };

  return (
    <section
      style={{
        position: "relative",
        minHeight: "100svh",
        overflow: "hidden",
        backgroundColor: "#000",
        transform: triggered
          ? "perspective(1100px) rotateY(-7deg) rotateX(1.5deg) scale(1.04)"
          : "perspective(1100px) rotateY(0deg) rotateX(0deg) scale(1)",
        transition: triggered
          ? "transform 0.55s cubic-bezier(0.36,0.07,0.19,0.97)"
          : "transform 0.9s cubic-bezier(0.16,1,0.3,1)",
      }}
    >
      {/* ── Image ── */}
      <div style={{ position: "absolute", inset: 0 }}>
        <div
          className="hero-image-anim"
          style={{
            position: "absolute",
            right: 0,
            top: 0,
            width: "68vw",
            height: "100%",
            transform: triggered ? "scale(1.14)" : "scale(1.02)",
            transition: triggered
              ? "transform 0.85s cubic-bezier(0.16,1,0.3,1)"
              : undefined,
          }}
        >
          <Image
            src={data.image}
            alt={data.headline}
            fill
            priority
            sizes="68vw"
            style={{ objectFit: "cover", objectPosition: "center 28%" }}
          />
        </div>

        {/* Horizontal gradient */}
        <div
          style={{
            position: "absolute",
            inset: 0,
            background:
              "linear-gradient(90deg, rgba(0,0,0,0.96) 0%, rgba(0,0,0,0.88) 18%, rgba(0,0,0,0.46) 42%, rgba(0,0,0,0.10) 62%, rgba(0,0,0,0.00) 78%)",
            opacity: triggered ? 0.25 : 1,
            transition: "opacity 0.6s ease",
          }}
        />
      </div>

      {/* ── Brand mark ── */}
      <p
        className="hero-body-anim"
        style={{
          position: "absolute",
          top: 28,
          left: 32,
          zIndex: 10,
          fontFamily: "var(--font-brand)",
          fontSize: 12,
          letterSpacing: "0.32em",
          textTransform: "uppercase",
          color: "rgba(201,163,92,0.88)",
        }}
      >
        Est.&thinsp;{brand.established}
      </p>

      {/* ── Season ── */}
      <p
        className="hero-body-anim"
        style={{
          position: "absolute",
          top: 28,
          right: 32,
          zIndex: 10,
          fontFamily: "var(--font-brand)",
          fontSize: 12,
          letterSpacing: "0.32em",
          textTransform: "uppercase",
          color: "rgba(201,163,92,0.6)",
        }}
      >
        {brand.season}
      </p>

      {/* ── Copy block ── */}
      <div
        className="hero-copy"
        style={{
          position: "absolute",
          zIndex: 5,
          left: "-2vw",
          top: "64%",
          transform: triggered
            ? "translateY(-50%) translateX(-130%) rotate(-4deg)"
            : "translateY(-50%)",
          width: "42vw",
          maxWidth: 680,
          padding: "0 0 0 2vw",
          opacity: triggered ? 0 : 1,
          transition: triggered
            ? "transform 0.45s cubic-bezier(0.55,0,1,0.45), opacity 0.3s ease"
            : undefined,
        }}
      >
        {/* Headline */}
        <h1
          style={{
            fontFamily: "var(--font-heading)",
            fontSize: "clamp(72px, 9vw, 156px)",
            lineHeight: 0.88,
            letterSpacing: "-0.045em",
            fontWeight: 400,
            color: "#f3efe8",
          }}
        >
          <span className="hero-line-1" style={{ display: "block" }}>The New</span>
          <span className="hero-line-2" style={{ display: "block" }}>Silhouette</span>
        </h1>

        {/* Body */}
        <p
          className="hero-body-anim"
          style={{
            marginTop: 36,
            maxWidth: 320,
            fontFamily: "var(--font-body)",
            fontSize: 18,
            lineHeight: 1.6,
            letterSpacing: "-0.01em",
            color: "#f3efe8",
          }}
        >
          {data.body}
        </p>

        {/* Editorial CTA */}
        <a
          href="#collection"
          className="hero-cta hero-cta-anim"
          onClick={handleEnter}
        >
          {data.cta}
          <span
            style={{
              display: "inline-block",
              color: "rgba(201,163,92,0.85)",
              animation: "arrowNudge 1.8s ease-in-out infinite",
            }}
          >
            →
          </span>
        </a>
      </div>

      {/* Responsive overrides */}
      <style>{`
        @media (max-width: 1024px) {
          .hero-copy {
            left: 24px !important;
            top: 68% !important;
            width: min(68vw, 520px) !important;
          }
          .hero-copy h1 { font-size: clamp(56px, 11vw, 96px) !important; }
        }
        @media (max-width: 640px) {
          .hero-copy {
            left: 20px !important;
            right: 20px !important;
            bottom: 28px !important;
            top: auto !important;
            transform: none !important;
            width: auto !important;
            max-width: none !important;
          }
          .hero-copy h1 {
            font-size: clamp(44px, 14vw, 68px) !important;
            line-height: 0.9 !important;
          }
        }
      `}</style>
    </section>
  );
}
