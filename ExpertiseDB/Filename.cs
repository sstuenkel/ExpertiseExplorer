//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace ExpertiseDB
{
    using System;
    using System.Collections.Generic;
    
    public partial class Filename
    {
        public Filename()
        {
            this.FileRevisions = new HashSet<FileRevision>();
        }
    
        public int FilenameId { get; set; }
        public string Name { get; set; }
        public int SourceRepositoryId { get; set; }
    
        public virtual ICollection<FileRevision> FileRevisions { get; set; }
        public virtual SourceRepository SourceRepository { get; set; }
    }
}
