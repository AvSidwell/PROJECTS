/**
 * Jagged abstract dark-shape poster motif.
 * Low-contrast angular polygons — graphic layer, not UI content.
 */
export default function BackgroundMotif() {
  return (
    <svg
      aria-hidden="true"
      xmlns="http://www.w3.org/2000/svg"
      style={{
        position: 'absolute',
        inset: 0,
        width: '100%',
        height: '100%',
        pointerEvents: 'none',
        zIndex: 0,
      }}
      preserveAspectRatio="xMidYMid slice"
      viewBox="0 0 900 700"
    >
      {/* Large left angular shard */}
      <polygon
        points="80,0 420,0 560,700 0,700 0,0"
        fill="#0f1210"
        opacity="0.75"
      />
      {/* Right overlapping shard */}
      <polygon
        points="340,0 820,0 900,200 900,700 480,700"
        fill="#0b0e0c"
        opacity="0.6"
      />
      {/* Inner accent shard — slightly lighter for depth */}
      <polygon
        points="220,0 500,0 620,700 180,700"
        fill="#121512"
        opacity="0.5"
      />
      {/* Top-right dark wedge */}
      <polygon
        points="600,0 900,0 900,350"
        fill="#0a0c0b"
        opacity="0.55"
      />
      {/* Bottom-left filler */}
      <polygon
        points="0,400 260,700 0,700"
        fill="#0a0c0b"
        opacity="0.45"
      />
    </svg>
  )
}
