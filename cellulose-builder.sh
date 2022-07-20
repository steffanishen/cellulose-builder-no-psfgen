#!/bin/bash
#
# Cellulose-builder builds Cartesian coordinates files for cellulose crystalline
# domains and plant cell wall cellulose elementary fibrils in PDB format.
#
# Copyright (C) 2012-2013 Thiago C. F. Gomes 
################################################################################
# Please cite the following paper if this code has been in any way useful      #
# to you: ( DOI: 10.1002/jcc.22959 )                                           #
#                                                                              #
# T. C. F. Gomes, M. S. Skaf, J. Comput. Chem. 2012, 33, 1338-1346.            #
#                                                                              #
# Code written by Thiago C. F. Gomes, Department of Physical Chemistry,        #
# Institute of Chemistry at the State University of Campinas (UNICAMP).        #
# Campinas - Sao Paulo, Brazil.                                                #
# Cp 6154. CEP 13083-970.                                                      #
# www.iqm.unicamp.br                                                           #
#                                                                              #
# See also http://code.google.com/p/cellulose-builder for more instructions.   #
################################################################################
#    This file is part of cellulose-builder.                                   #
#                                                                              #
#    cellulose-builder is free software: you can redistribute it and/or modify #
#    it under the terms of the GNU General Public License as published by      #
#    the Free Software Foundation, either version 3 of the License, or         #
#    (at your option) any later version.                                       #
#                                                                              #
#    cellulose-builder is distributed in the hope that it will be useful,      #
#    but WITHOUT ANY WARRANTY; without even the implied warranty of            #
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the             #
#    GNU General Public License for more details.                              #
#                                                                              #
#    You should have received a copy of the GNU General Public License         #
#    along with cellulose-builder. If not, see <http://www.gnu.org/licenses/>. #
################################################################################
#
###################  FUNCTIONS' DECLARATION  ##############
function usage {
echo 'Usage: 

 $ ./cellulose-builder.sh <INTEGER> <INTEGER> <INTEGER>

 You must specify three integers greater than 1 as arguments.
 (Actually the third integer is allowed to be 1 as well).
 They stand for how many replications of the unit cell will be
 performed in each crystallographic direction. The third integer
 also determines how many cellobiose residues the chains will have.

OR

 $ ./cellulose-builder.sh fibril <INTEGER>

 In this case you must provide the string `fibril`
 and an integer greater than 0 as arguments.
 
OR

 $ ./cellulose-builder center|origin|monolayer <INTEGER> <INTEGER>

 For monolayers from allomorphs I-beta and II choose either `center` or `origin`
 as first argument and provide two integers greater than 1.
 For allomorph I-alpha monolayers just type `monolayer`
 as first argument and provide two integers greater than 1. 

 Edit file `input.inp` to control other crystal features.

 See also http://code.google.com/p/cellulose-builder for more instructions. 
'
exit 9 ;
}
function remove_crap { ## WARNING: It is very DANGEROUS to edit this function! Pay attention to asterisks if you do!
#rm -f uc* lay* sed* crystal.* crystal_* frc $FRACT $AUXSCRIPT auxiliary_script_for_sed vmdquit frag* nfrag.pl vmdaux vmdLOG.log vmd*LOG.log vmdscript psfgen.* ring anti.pl basisvectors tmpbasisvectors whenwhowherehow;
rm -f uc* lay* sed* crystal.* crystal_* frc $FRACT $AUXSCRIPT auxiliary_script_for_sed vmdquit  nfrag.pl vmdaux vmdLOG.log vmd*LOG.log vmdscript psfgen.* ring anti.pl basisvectors tmpbasisvectors whenwhowherehow;
}
function too_big_error {
mv -f vmdLOG.log __vmdLOG.log ;
mv -f crystal.xyz __crystal.xyz ;
remove_crap ;
mv -f __vmdLOG.log vmdLOG.log ;
mv -f __crystal.xyz crystal.xyz ;
echo ' ERROR: your crystal is probably too big. Crystal size is actually limited'
echo '        by the PDB format. Cartesian coordinates cannot exceed 9999.999 in'
echo '        this format, so VMD cannot write the PDB file without truncating it.'
echo '        (See file vmdLOG.log). You still have the crystal you had asked for'
echo '        in XYZ format though. See file crystal.xyz.'
exit 8 ;
}
function endless_failsafe {
if [ ! -r "$1" ] ; then
  echo
  echo ' WARNING: waiting for VMD to terminate.';
  echo ' This script SHOULD NOT display the above message about VMD by default,';
  echo ' please interrupt (Ctrl+c) if it seems to take forever....';
  echo
  while [ ! -r "$1" ] ; do
    sleep 2 ;
  done
fi
}
function psfgen_error {
mv -f psfgen.log __psfgen.log ; mv -f psfgen.tcl __psfgen.tcl ; mv -f crystal.xyz __crystal.xyz ;
fragdir=$( mktemp -d --tmpdir=. --suffix=_fragments.pdb ) ;
mv -f frag_*.tmp.pdb $fragdir ;
remove_crap ;
mv -f __psfgen.log psfgen.log ; mv -f __psfgen.tcl psfgen.tcl ; mv -f __crystal.xyz crystal.xyz ;
echo ' Program aborted due to error in psfgen execution.' ;
echo ' String `ERROR` and/or `MOLECULE MISSING` found in file psfgen.log' ;
echo ' You might still have the crystal you had asked for in XYZ format though. ' ;
echo ' See file crystal.xyz. You might also have single cellulose chains in PDB '
echo " format as separate files. See into directory $fragdir "
exit 8 ;
}
function octave_error {
remove_crap ;
echo " Program aborted due to error during octave execution. Octave returned non-zero exit status!";
exit 8 ;
}
function vmd_error {
remove_crap ;
echo " Program aborted due to error during VMD execution. VMD returned non-zero exit status!";
exit 8 ;
}
function print_thank_you {
echo ' Structure written to file `crystal.pdb`. Please, look into directory `crystal`.' ;
echo ' Please include this reference in published work using cellulose-builder: ' ; echo ;
echo ' T. C. F. Gomes, M. S. Skaf, J. Comput. Chem. 2012, 33, 1338-1346. ' ; echo ' DOI: 10.1002/jcc.22959' ; echo ;
echo ' Thank you for using cellulose-builder !' ; echo ; 
}
##################### SCRIPT STARTS HERE   ######################
#which bc >/dev/null 2>&1 || { echo " Please, make sure the program bc is installed and in your PATH";
#echo " in order to run this script."; exit 1; }
echo ' cellulose-builder Copyright (C) 2012-2013 Thiago C. F. Gomes'
echo ' This program comes with ABSOLUTELY NO WARRANTY; not even for MERCHANTABILITY or'
echo ' FITNESS FOR A PARTICULAR PURPOSE. This is free software, and you are welcome to'
echo ' redistribute it under certain conditions; see `license` for details.'
echo
echo ' See http://code.google.com/p/cellulose-builder for installation, usage'
echo ' instructions and mailing list.'
echo
declare -i exit_trigger=0;
REQUIRED='octave sed grep nl cat echo perl vmd tr'
for prog in $REQUIRED
do
  which $prog >/dev/null 2>&1 || { echo " Please, make sure "$prog" is installed and in \
your PATH." ; exit_trigger=1; \
[ "$prog" = 'vmd' ] && { echo ' See http://www.ks.uiuc.edu/Research/vmd/' ; echo ; } ; \
#[ "$prog" = 'psfgen' ] && { echo ' See http://www.ks.uiuc.edu/Research/namd/' ; echo ; } ; 
}
done
[ "$exit_trigger" -eq "1" ] && { echo " That is necessary in order to run this script."; echo " Make sure the above program(s) are \
installed and that they are in your PATH."; exit 1; } ;

[ -r bGLC.top ] || { echo ' ERROR: Please make a link named `bGLC.top` to topology file top_all36_carb.rtf' ; \
                     echo '        using the following command line:' ; \
                     echo ' $ ln -s top_all36_carb.rtf bGLC.top' ; exit 1 ; } ;

# sourcing input
source input.inp && { echo ; } || { echo ' WARNING: Cellulose builder was not able to source `input.inp`.'; \
                    echo '          Assuming default values for the following variables: ' ; \
                    PHASE=I_BETA ; PBC=none ; PCB_c=FALSE ; \
                    echo "          PHASE = $PHASE " ; \
                    echo "          PBC = $PBC " ; \
                    echo "          PCB_c = $PCB_c " ; echo ; } ;
PHASE=$(echo $PHASE | tr [:upper:] [:lower:]) ;
PBC=$(echo $PBC | tr [:upper:] [:lower:]) ;
PCB_c=$(echo $PCB_c | tr [:upper:] [:lower:]) ;

AUXSCRIPT=auxiliary_script_for_octave
FRACT=fract            # Unit cell in fractional coordinates
FC=frc                 # The same as above but with no comment lines
CRYSTAL='crystal.xyz'  # Output file (Do not change!)

case $PHASE in
               i*beta | 1*beta )
                               ALLOMORPH=I-beta.sh   ; # Code to build chosen cellulose allomorph
                               ASY=asy_I_beta        ; # Asymmetric unit in fractional coordinates
                               DIM=dimensions_I_beta ; # Unit cell parameters
               ;;
               i*alpha | 1*alpha )
                               ALLOMORPH=I-alpha.sh   ; # Code to build chosen cellulose allomorph
                               ASY=asy_I_alpha        ; # Asymmetric unit in fractional coordinates
                               DIM=dimensions_I_alpha ; # Unit cell parameters
               ;;
               ii | 2 ) 
                               ALLOMORPH=II.sh   ;      # Code to build chosen cellulose allomorph
                               ASY=asy_II        ;      # Asymmetric unit in fractional coordinates
                               DIM=dimensions_II ;      # Unit cell parameters
               ;;
               iii_ii | 3_2 ) 
                               echo ' Sorry, cellulose III_II allomorph is not sopported yet.' ;
                               exit 1 ;
               ;;
               iii* | 3* ) 
                               ALLOMORPH=III_I.sh   ;   # Code to build chosen cellulose allomorph
                               ASY=asy_III_I        ;   # Asymmetric unit in fractional coordinates
                               DIM=dimensions_III_I ;   # Unit cell parameters
               ;;
               *)
                echo " ERROR: Error in file input.inp. Value $PHASE is invalid." ;
                exit 1 ;
               ;;
esac

trap " { echo ' Cellulose-builder INTERRUPTED by user. Cleaning and exiting. ' ; remove_crap ; rm -rf crystal ; exit 2 ; } " SIGINT SIGTERM
source $ALLOMORPH
# Copyright (C) 2012-2013 Thiago C. F. Gomes 
################################################################################
# Please cite the following paper if this code has been in any way useful      #
# to you: ( DOI: 10.1002/jcc.22959 )                                           #
#                                                                              #
# T. C. F. Gomes, M. S. Skaf, J. Comput. Chem. 2012, 33, 1338-1346.            #
#                                                                              #
# Code written by Thiago C. F. Gomes, Department of Physical Chemistry,        #
# Institute of Chemistry at the State University of Campinas (UNICAMP).        #
# Campinas - Sao Paulo, Brazil.                                                #
# Cp 6154. CEP 13083-970.                                                      #
# www.iqm.unicamp.br                                                           #
#                                                                              #
# See also http://code.google.com/p/cellulose-builder for more instructions.   #
################################################################################
#    This file is part of cellulose-builder.                                   #
#                                                                              #
#    cellulose-builder is free software: you can redistribute it and/or modify #
#    it under the terms of the GNU General Public License as published by      #
#    the Free Software Foundation, either version 3 of the License, or         #
#    (at your option) any later version.                                       #
#                                                                              #
#    cellulose-builder is distributed in the hope that it will be useful,      #
#    but WITHOUT ANY WARRANTY; without even the implied warranty of            #
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the             #
#    GNU General Public License for more details.                              #
#                                                                              #
#    You should have received a copy of the GNU General Public License         #
#    along with cellulose-builder. If not, see <http://www.gnu.org/licenses/>. #
################################################################################
