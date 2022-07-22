#!/bin/bash
#Usage: bash run.sh #before that, modify x y z and input.inp

x=2
y=3
z=39

dir=crystal_${x}_${y}_${z}_pbc_cbc_center_I_beta

bash cellulose-builder.sh $x $y $z
#bash cellulose-builder.sh origin $x $y
#bash cellulose-builder.sh center $x $y
#mv crystal ../$dir
