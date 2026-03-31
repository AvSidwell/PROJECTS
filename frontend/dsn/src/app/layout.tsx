import type { Metadata } from "next";
import localFont from "next/font/local";
import "./globals.css";

const panchang = localFont({
  src: "./fonts/Panchang-Variable.woff2",
  variable: "--font-panchang",
  display: "swap",
});

const melodrama = localFont({
  src: "./fonts/Melodrama-Medium.woff2",
  variable: "--font-melodrama",
  display: "swap",
});

const gambetta = localFont({
  src: "./fonts/Gambetta-Variable.woff2",
  variable: "--font-gambetta",
  display: "swap",
});

export const metadata: Metadata = {
  title: "DSN",
  description: "Luxury fashion portfolio",
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html
      lang="en"
      className={`${panchang.variable} ${melodrama.variable} ${gambetta.variable}`}
    >
      <body>{children}</body>
    </html>
  );
}
