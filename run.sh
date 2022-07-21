#!/bin/bash
#Usage: bash run.sh #before that, modify x y z and input.inp

x=5
y=5
z=2

dir=crystal_${x}_${y}_${z}_pbc_cbc_I_beta_mod

#bash cellulose-builder.sh $x $y $z
bash cellulose-builder.sh origin $x $y
#bash cellulose-builder.sh center $x $y
#bash cellulose-builder.sh monolayer $x $y
#bash cellulose-builder.sh center $x $y
#bash cellulose-builder.sh fibril $x
#mv crystal ../$dir
