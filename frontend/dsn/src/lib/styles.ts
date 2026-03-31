import type { CSSProperties } from "react";

export const label = (): CSSProperties => ({
  fontFamily: "var(--font-brand)",
  fontSize: 11,
  letterSpacing: "0.38em",
  textTransform: "uppercase",
  color: "rgba(201,163,92,0.78)",
});

export const heading = (size = "clamp(36px,4.5vw,72px)"): CSSProperties => ({
  fontFamily: "var(--font-heading)",
  fontSize: size,
  lineHeight: 0.9,
  letterSpacing: "-0.04em",
  fontWeight: 400,
  color: "#f3efe8",
});

export const bodyText = (): CSSProperties => ({
  fontFamily: "var(--font-body)",
  fontSize: 15,
  lineHeight: 1.65,
  color: "#f3efe8",
});

export const ghost = (size = "clamp(90px,13vw,200px)"): CSSProperties => ({
  fontFamily: "var(--font-brand)",
  fontSize: size,
  lineHeight: 1,
  letterSpacing: "-0.05em",
  color: "rgba(255,255,255,0.035)",
  userSelect: "none",
  pointerEvents: "none",
});

export const rule = (): CSSProperties => ({
  width: 32,
  height: 1,
  backgroundColor: "rgba(201,163,92,0.35)",
});
