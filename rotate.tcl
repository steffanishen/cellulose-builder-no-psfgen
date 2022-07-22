mol new crystal.psf
mol addfile crystal.pdb

set sel [atomselect top all]
set com [measure center $sel]
$sel moveby [vecscale -1.0 $com]

set matrix [transaxis z -136.91619477413516]
$sel move $matrix
set matrix [transaxis x 90.0]
$sel move $matrix

set sel [atomselect top "(same residue as index 1) and name H61"]
set z [$sel get z]
set coord [list 0.0 0.0 $z]

set sel [atomselect top all]
$sel moveby [vecscale -1.0 $coord]

$sel writepdb crystal_rot.pdb
