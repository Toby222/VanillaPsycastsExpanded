using System;
using System.Collections.Generic;
using System.Linq;
using RimWorld;
using UnityEngine;
using Verse;
using Verse.AI;

namespace VanillaPsycastsExpanded
{
    public class CompProperties_BreakLink : CompProperties
    {
        public string gizmoImage;
        public string gizmoLabel;
        public string gizmoDesc;

        public CompProperties_BreakLink()
        {
            this.compClass = typeof(CompBreakLink);
        }
    }
}
