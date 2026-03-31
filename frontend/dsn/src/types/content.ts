export interface LookImage {
  src: string;
  name: string;
  width: number;
  height: number;
  aspectRatio: number;
}

export interface Look {
  id: string;
  number: string;
  name: string;
  category: string;
  description: string;
  layout: "fullbleed" | "centered" | "sticky" | "split" | "editorial-sequence" | "masonry" | "feature-single";
  special: boolean;
  images: LookImage[];
  detailMode: string;
  interaction: string;
}

export interface EditorialPiece {
  id: string;
  title: string;
  image: string;
  relatedLooks: string[];
}

export interface BrandData {
  season: string;
  established: string;
  theme?: string;
}

export interface HeroData {
  headline: string;
  subheadline: string;
  body: string;
  cta: string;
  image: string;
}
