using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BPrep_BL.Model
{
    public partial class Item
    {
        public DateTime? StartWarningForReplacement
        {
            get
            {
                if (ReplaceBy == null) return null;
                return ((DateTime) ReplaceBy).AddDays(DaysWarningOfReplacement*-1);
            }
        }
    }
}
