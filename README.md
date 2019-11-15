# senior-design-project
My senior design project, which is a hardware solution to generating CRISPR/Cas-9 guide RNA sequences.

# The Modules

The primary modules can be found at:

  [PAM Searcher](ip_repo/PAMChunkSearch_1.0/src/PAMSearcher.v)
  [Off-Target Searcher](ip_repo/offTargetSearcher_1.0/src/offTargetSearcher.v)
  
The primary solution itself utilizes Microblaze, a softcore processor, to read and write to text files for the DNA data.

My write-up is available [here](Documents/seniorDesign2WriteUp.pdf).
