"use client";
import { useEffect } from "react";
import { label } from "@/lib/styles";

interface Props {
  open: boolean;
  onClose: () => void;
  children: React.ReactNode;
  maxWidth?: string;
}

export default function Modal({ open, onClose, children, maxWidth = "92vw" }: Props) {
  useEffect(() => {
    if (open) {
      document.body.style.overflow = "hidden";
    } else {
      document.body.style.overflow = "";
    }
    return () => { document.body.style.overflow = ""; };
  }, [open]);

  useEffect(() => {
    const handler = (e: KeyboardEvent) => { if (e.key === "Escape") onClose(); };
    if (open) window.addEventListener("keydown", handler);
    return () => window.removeEventListener("keydown", handler);
  }, [open, onClose]);

  return (
    <div
      style={{
        position: "fixed",
        inset: 0,
        zIndex: 60,
        background: "rgba(10,10,10,0.93)",
        display: "flex",
        alignItems: "center",
        justifyContent: "center",
        opacity: open ? 1 : 0,
        pointerEvents: open ? "auto" : "none",
        transition: "opacity 280ms ease",
      }}
      onClick={onClose}
    >
      {/* Close button */}
      <button
        aria-label="Close"
        onClick={onClose}
        style={{
          position: "absolute",
          top: 28,
          right: 32,
          background: "transparent",
          border: "none",
          cursor: "pointer",
          ...label(),
          color: "rgba(201,163,92,0.7)",
          letterSpacing: "0.32em",
          padding: 0,
        }}
      >
        ESC
      </button>

      {/* Content — stop propagation so clicks inside don't close */}
      <div
        style={{ maxWidth, width: "100%", maxHeight: "92vh", overflowY: "auto" }}
        onClick={e => e.stopPropagation()}
      >
        {children}
      </div>
    </div>
  );
}
