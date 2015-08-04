//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace BPrep_BL.Model
{
    using System;
    using System.Collections.Generic;
    
    public partial class Item
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public Nullable<System.DateTime> ReplaceBy { get; set; }
        public int DaysWarningOfReplacement { get; set; }
        public int KitId { get; set; }
        public int ItemStatusId { get; set; }
        public int Quantity { get; set; }
        public Nullable<int> SampleItemId { get; set; }
    
        public virtual Kit Kit { get; set; }
        public virtual ItemStatus ItemStatus { get; set; }
    }
}