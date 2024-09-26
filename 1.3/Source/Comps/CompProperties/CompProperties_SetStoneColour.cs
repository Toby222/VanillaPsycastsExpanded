using System;
using System.Collections.Generic;
using System.Linq;
using RimWorld;
using UnityEngine;
using Verse;
using Verse.AI;

namespace VanillaPsycastsExpanded
{
    public class CompProperties_SetStoneColour : CompProperties
    {
        public CompProperties_SetStoneColour()
        {
            this.compClass = typeof(CompSetStoneColour);
        }
    }
}
