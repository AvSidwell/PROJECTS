import type { Look } from "@/types/content";
import LookFullbleed         from "@/components/looks/LookFullbleed";
import LookCentered          from "@/components/looks/LookCentered";
import LookSticky            from "@/components/looks/LookSticky";
import LookSplit             from "@/components/looks/LookSplit";
import LookEditorialSequence from "@/components/looks/LookEditorialSequence";
import LookFeatureSingle     from "@/components/looks/LookFeatureSingle";
import LookMasonry           from "@/components/looks/LookMasonry";

interface Props {
  looks: Look[];
}

export default function Collection({ looks }: Props) {
  return (
    <div id="collection">
      {looks.map((look) => {
        switch (look.layout) {
          case "fullbleed":          return <LookFullbleed          key={look.id} look={look} />;
          case "centered":           return <LookCentered           key={look.id} look={look} />;
          case "sticky":             return <LookSticky             key={look.id} look={look} />;
          case "split":              return <LookSplit              key={look.id} look={look} />;
          case "editorial-sequence": return <LookEditorialSequence  key={look.id} look={look} />;
          case "feature-single":     return <LookFeatureSingle      key={look.id} look={look} />;
          case "masonry":            return <LookMasonry            key={look.id} look={look} />;
          default:                   return null;
        }
      })}
    </div>
  );
}
