namespace VanillaPsycastsExpanded
{
    using System.Linq;
    using RimWorld.Planet;
    using Ability = VFECore.Abilities.Ability;

    public class Ability_WordOf : Ability
    {
        public override void Cast(params GlobalTargetInfo[] targets)
        {
            base.Cast(targets);
            var groupLinkMaster =
                this.pawn.health.hediffSet.GetFirstHediffOfDef(VPE_DefOf.VPE_GroupLink)
                as Hediff_GroupLink;
            if (groupLinkMaster != null)
            {
                foreach (var linkedPawn in groupLinkMaster.linkedPawns)
                {
                    if (!targets.Any(x => x.Thing == linkedPawn))
                    {
                        base.Cast(new GlobalTargetInfo[] { linkedPawn });
                    }
                }
            }
        }
    }
}
