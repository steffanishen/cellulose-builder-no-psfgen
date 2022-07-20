#!/bin/bash
/Users/meshen/anaconda3/envs/psfgen/bin/psfgen << ENDMOL
topology ./bGLC.top

segment M0 {
  pdb ./frag_0.tmp.pdb
  }
patch 14bb M0:4 M0:3
patch 14bb M0:3 M0:2
patch 14bb M0:2 M0:1

segment M1 {
  pdb ./frag_1.tmp.pdb
  }
patch 14bb M1:4 M1:3
patch 14bb M1:3 M1:2
patch 14bb M1:2 M1:1

segment M2 {
  pdb ./frag_2.tmp.pdb
  }
patch 14bb M2:4 M2:3
patch 14bb M2:3 M2:2
patch 14bb M2:2 M2:1

segment M3 {
  pdb ./frag_3.tmp.pdb
  }
patch 14bb M3:4 M3:3
patch 14bb M3:3 M3:2
patch 14bb M3:2 M3:1

segment M4 {
  pdb ./frag_4.tmp.pdb
  }
patch 14bb M4:4 M4:3
patch 14bb M4:3 M4:2
patch 14bb M4:2 M4:1

segment M5 {
  pdb ./frag_5.tmp.pdb
  }
patch 14bb M5:4 M5:3
patch 14bb M5:3 M5:2
patch 14bb M5:2 M5:1

segment M6 {
  pdb ./frag_6.tmp.pdb
  }
patch 14bb M6:4 M6:3
patch 14bb M6:3 M6:2
patch 14bb M6:2 M6:1

segment M7 {
  pdb ./frag_7.tmp.pdb
  }
patch 14bb M7:4 M7:3
patch 14bb M7:3 M7:2
patch 14bb M7:2 M7:1

regenerate angles dihedrals

coordpdb frag_0.tmp.pdb M0
coordpdb frag_1.tmp.pdb M1
coordpdb frag_2.tmp.pdb M2
coordpdb frag_3.tmp.pdb M3
coordpdb frag_4.tmp.pdb M4
coordpdb frag_5.tmp.pdb M5
coordpdb frag_6.tmp.pdb M6
coordpdb frag_7.tmp.pdb M7

guesscoord
writepsf crystal.psf
writepdb crystal.pdb
ENDMOL
