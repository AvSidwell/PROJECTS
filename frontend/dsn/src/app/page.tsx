"use client";

import { useState, useEffect, useCallback, useRef } from "react";
import Navbar     from "@/components/Navbar";
import Hero       from "@/components/sections/Hero";
import Collection from "@/components/sections/Collection";
import Editorial  from "@/components/sections/Editorial";
import Footer     from "@/components/Footer";
import SleepOverlay from "@/components/SleepOverlay";
import type { Look, EditorialPiece } from "@/types/content";
import data from "@/data/products.json";

const IDLE_TIMEOUT = 30_000;

export default function Home() {
  const [sleeping, setSleeping] = useState(false);
  const idleTimer = useRef<ReturnType<typeof setTimeout> | null>(null);
  const savedScroll = useRef(0);

  const goToSleep = useCallback(() => {
    savedScroll.current = window.scrollY;
    setSleeping(true);
  }, []);

  const resetIdle = useCallback(() => {
    if (idleTimer.current) clearTimeout(idleTimer.current);
    idleTimer.current = setTimeout(goToSleep, IDLE_TIMEOUT);
  }, [goToSleep]);

  useEffect(() => {
    resetIdle();
    window.addEventListener("mousemove", resetIdle);
    window.addEventListener("keydown", resetIdle);
    window.addEventListener("touchstart", resetIdle);
    window.addEventListener("scroll", resetIdle, { passive: true });
    return () => {
      if (idleTimer.current) clearTimeout(idleTimer.current);
      window.removeEventListener("mousemove", resetIdle);
      window.removeEventListener("keydown", resetIdle);
      window.removeEventListener("touchstart", resetIdle);
      window.removeEventListener("scroll", resetIdle);
    };
  }, [resetIdle]);

  const handleWake = useCallback(() => {
    setSleeping(false);
    setTimeout(() => {
      window.scrollTo({ top: savedScroll.current, behavior: "instant" });
    }, 100);
    resetIdle();
  }, [resetIdle]);

  return (
    <main>
      <Navbar />
      <Hero data={data.hero} brand={data.brand} />
      <Collection looks={data.looks as Look[]} />
      <Editorial pieces={data.editorial as EditorialPiece[]} season={data.brand.season} />
      <Footer season={data.brand.season} established={data.brand.established} />
      <SleepOverlay active={sleeping} onWake={handleWake} />
    </main>
  );
}
