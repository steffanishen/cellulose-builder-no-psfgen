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


FIBRIL=0  #Meng mod

[ -z "$1" ] && usage || { case $1 in 
                          fibril) declare -i XSIZE=7; declare -i YSIZE=5;  FIBRIL=1;
                                       if [ ! -z "$2" ] ; then
                                         if [ `expr $2 + 1` -a "$2" -gt 0 ] ; then
                                           declare -i ZSIZE=$2 && echo ' Allomorph II-mercerized' ; 
                                           echo ' Building cellulose elementary fibril';
                                           echo " Number of cellobiose residues per cellulose chain = $ZSIZE" ; echo ;
                                         else
                                           echo 'ARGUMENT ERROR: The second command-line argument must be an integer greater than 1!' ; exit 9 ;
                                         fi
                                       else
                                         echo 'ARGUMENT ERROR: You must provide a second command-line argument for fibril construction!'
                                         echo 'ARGUMENT ERROR: The second argument must be an integer greater than 0!' ; exit 9 ; 
                                       fi
                                       declare -i BVX=0 ; declare -i BVY=0 ; declare -i BVZ=$ZSIZE ;  
#                                      ##
                                       echo
                          ;;
                          [0-9]*) if [ -z "$2" ] ; then
                                     echo 'ARGUMENT ERROR: You must provide three integer numbers greater than 1 as arguments.' ; exit 9;
                                  fi
#                                 ##
                                  if [ -z "$3" ] ; then
                                     echo 'ARGUMENT ERROR: You must provide three integer numbers greater than 1 as arguments.' ; exit 9;
                                  fi
#                                 ########
                                  if [ `expr $1 + 1` -a "$1" -gt 1 ] ; then
                                     declare -i XSIZE=$1 ;
                                  else
                                     echo 'ARGUMENT ERROR: Error in first command-line argument!';
                                     echo 'ARGUMENT ERROR: The first argument must be an integer greater than 1!' ; exit 9 ;
                                  fi
#                                 ##
                                  if [ `expr $2 + 1` -a "$2" -gt 1 ] ; then
                                     declare -i YSIZE=$2
                                  else
                                     echo 'ARGUMENT ERROR: Error in second command-line argument!';
                                     echo 'ARGUMENT ERROR: The second argument must be an integer greater than 1!' ; exit 9 ;
                                  fi
#                                 ##
                                  if [ `expr $3 + 1` -a "$3" -gt 0 ] ; then
                                     declare -i ZSIZE=$3
                                  else
                                     echo 'ARGUMENT ERROR: Error in third command-line argument!';
                                     echo 'ARGUMENT ERROR: The third argument must be an integer greater than 0!' ; exit 9 ;
                                  fi
                                  declare -i BVX=$XSIZE ; declare -i BVY=$YSIZE ; declare -i BVZ=$ZSIZE ;  
#                                 #######    
                                  echo ' Allomorph II (mercerized)' ; 
                                  echo " Building cristallite with arguments provided ( $XSIZE , $YSIZE , $ZSIZE ). " ;
                                  echo ;
                          ;;
                         center) if [ -z "$2" ] ; then
                                    echo 'ARGUMENT ERROR: You must provide two integer numbers greater than 1' ;
                                    echo '                as arguments after the string `center`.' ; exit 9;
                                 fi
#                                ####
                                 if [ -z "$3" ] ; then
                                    echo 'ARGUMENT ERROR: You must provide two integer numbers greater than 1' ;
                                    echo '                as arguments after the string `center`.' ; exit 9;
                                 fi
#                                ####
                                 if [ `expr $2 + 1` -a "$2" -gt 1 ] ; then
                                    declare -i XSIZE=$2
                                    XSIZE=XSIZE+1 ;
                                 else
                                    echo 'ARGUMENT ERROR: Error in second command-line argument!';
                                    echo 'ARGUMENT ERROR: The second argument must be an integer greater than 1!' ; exit 9 ;
                                 fi
#                                ##
                                 if [ `expr $3 + 1` -a "$3" -gt 0 ] ; then
                                    declare -i ZSIZE=$3 && echo ' Allomorph II (mercerized)' ; 
                                    echo " Building monolayer consisting of $2 cellulose chains" ;
                                    echo ' labeled as `center` within cellulose II crystalline phase.'
                                    echo " Number of cellobiose residues per cellulose chain = $ZSIZE" ; echo ;
                                 else
                                    echo 'ARGUMENT ERROR: Error in third command-line argument!';
                                    echo 'ARGUMENT ERROR: The third argument must be an integer greater than 0!' ; exit 9 ;
                                 fi
#                                ##########
                                 declare -i YSIZE=2 ;
#                                ##########
                                 declare -i BVX=$2 ; declare -i BVY=1 ; declare -i BVZ=$3 ;  
                                 echo
                         ;;
                         origin) if [ -z "$2" ] ; then
                                    echo 'ARGUMENT ERROR: You must provide two integer numbers greater than 1' ;
                                    echo '                as arguments after the string `origin`.' ; exit 9;
                                 fi
#                                ####
                                 if [ -z "$3" ] ; then
                                    echo 'ARGUMENT ERROR: You must provide two integer numbers greater than 1' ;
                                    echo '                as arguments after the string `origin`.' ; exit 9;
                                 fi
#                                ####
                                 if [ `expr $2 + 1` -a "$2" -gt 1 ] ; then
                                    declare -i XSIZE=$2
                                 else
                                    echo 'ARGUMENT ERROR: Error in second command-line argument!';
                                    echo 'ARGUMENT ERROR: The second argument must be an integer greater than 1!' ; exit 9 ;
                                 fi
#                                ##
                                 if [ `expr $3 + 1` -a "$3" -gt 0 ] ; then
                                    declare -i ZSIZE=$3 && echo ' Allomorph II (mercerized)' ; 
                                    echo " Building monolayer consisting of $2 cellulose chains" ;
                                    echo ' labeled as `origin` within cellulose II crystalline phase.'
                                    echo " Number of cellobiose residues per cellulose chain = $ZSIZE" ; echo ;
                                 else
                                    echo 'ARGUMENT ERROR: Error in third command-line argument!';
                                    echo 'ARGUMENT ERROR: The third argument must be an integer greater than 0!' ; exit 9 ;
                                 fi
#                                ##########
                                 declare -i YSIZE=2 ;
#                                ##########
                                 declare -i BVX=$2 ; declare -i BVY=1 ; declare -i BVZ=$3 ;  
                                 echo
                         ;;
                          h*|H*|-h*|-H*) usage ;
                          ;;
                          *) echo 'ARGUMENT ERROR! Try ` ./cellulose-builder -h ` for help on usage.'; exit 9;
                          ;;
                          esac } ;
####
case $PCB_c in
false) echo " PCB_c = $PCB_c , no periodic covalent bonding between" ;
       echo " chains' periodic images along direction c (default)." ;
;;
true) echo " PCB_c = $PCB_c , periodic covalent bonding will be applied" ;
      echo " between chains' periodic images along direction c." ;
;;
*) echo " ERROR in file input.inp . Invalid value for variable PCB_c: $PCB_c ." ;
   echo " Valid values are FALSE, TRUE. " ; exit 6 ;
;;
esac
echo
####
echo ' Building ....' ; echo ;
####

[ -e "$AUXSCRIPT" ] && rm -f $AUXSCRIPT
echo "load $ASY" > $AUXSCRIPT
echo "image(:,1) = -"$ASY"(:,1)" >> $AUXSCRIPT
echo "image(:,2) = -"$ASY"(:,2)" >> $AUXSCRIPT
echo "image(:,3) =  "$ASY"(:,3) + 0.5" >> $AUXSCRIPT

if [ $FIBRIL -eq 0 ]
then
  echo "half = length(image)/2" >> $AUXSCRIPT
  echo "image(half + 1:half*2,1) += 1.0  " >> $AUXSCRIPT
  echo "image(half + 1:half*2,2) += 1.0  " >> $AUXSCRIPT
fi

echo "save '"$FRACT"' "$ASY" image" >> $AUXSCRIPT
octave $AUXSCRIPT > /dev/null 2>&1 || octave_error ;
rm -f $AUXSCRIPT
cat $FRACT | sed -e '/^\#.*$/d' > $FC
rm -f $FRACT
##############################
cat $DIM > $AUXSCRIPT
echo 'format long' >> $AUXSCRIPT
echo "load $FC" >> $AUXSCRIPT
echo 'cosg = cos(gamma)' >> $AUXSCRIPT
echo 'sing = sin(gamma)' >> $AUXSCRIPT
declare -i I=0
declare -i J=0
declare -i NUM=1
for (( J=0; J<YSIZE; J++ ))
do
  for (( I=0; I<XSIZE; I++))
  do
    echo "fc"$NUM"(:,1) = "$FC"(:,1) + "$I"" >> $AUXSCRIPT
    echo "fc"$NUM"(:,2) = "$FC"(:,2) + "$J"" >> $AUXSCRIPT
    echo "fc"$NUM"(:,3) = "$FC"(:,3)"        >> $AUXSCRIPT
    echo                                     >> $AUXSCRIPT
    echo "uc"$NUM"(:,1) = fc"$NUM"(:,1)*a + fc"$NUM"(:,2)*b*cosg" >> \
                                                         $AUXSCRIPT
    echo "uc"$NUM"(:,2) = fc"$NUM"(:,2)*b*sing"       >> $AUXSCRIPT
    echo "uc"$NUM"(:,3) = fc"$NUM"(:,3)*c"            >> $AUXSCRIPT
    echo "clear fc"$NUM""                    >> $AUXSCRIPT
    echo                                     >> $AUXSCRIPT
    echo                                     >> $AUXSCRIPT
    NUM=$NUM+1
  done
done
echo "basisvector1 = [ "$BVX"*a 0 0 ]" >> $AUXSCRIPT
echo "basisvector2 = [ "$BVY"*b*cosg  "$BVY"*b*sing  0 ]" >> $AUXSCRIPT
echo "basisvector3 = [ 0  0  "$BVZ"*c ]" >> $AUXSCRIPT
echo "save 'basisvectors' basisvector1 basisvector2 basisvector3 " >> $AUXSCRIPT
echo "clear basisvector1 basisvector2 basisvector3 " >> $AUXSCRIPT

declare -i cnum=1
#####################################################################
#####################################################################
for (( cnum=1; cnum<NUM; cnum++ ))
do
  echo "save 'uc"$cnum"' uc"$cnum" " >> $AUXSCRIPT
done
octave $AUXSCRIPT > /dev/null 2>&1  || octave_error ; 
for (( cnum=1; cnum<NUM; cnum++ ))
do
  sed -i -e '/^\#.*$/d' uc"$cnum"
done
###############
rm -f $AUXSCRIPT
rm -f $FC
cat basisvectors | sed -e '/^$/d' | sed -e '/^\#/d; s/\ /\t/g;' | sed -e '1s/^/REMARK  crystal basis vector 1: (/; 1s/$/ )/; 2s/^/REMARK  crystal basis vector 2: (/; 2s/$/ )/; 3s/^/REMARK  crystal basis vector 3: (/; 3s/$/ )/' > tmpbasisvectors && echo 'REMARK  crystal`s basis vectors components in Angstrom.' > basisvectors &&  cat tmpbasisvectors | sed -e '/^$/d' >> basisvectors && rm -f tmpbasisvectors  ;
#####################################################################
SED_AUX=auxiliary_script_for_sed
echo '1s/^/C    /;
2s/^/H    /;
3s/^/C    /;
4s/^/H    /;
5s/^/C    /;
6s/^/H    /;
7s/^/C    /;
8s/^/H    /;
9s/^/C    /;
10s/^/H    /;
11s/^/C    /;
12s/^/H    /;
13s/^/H    /;
14s/^/O    /;
15s/^/O    /;
16s/^/O    /;
17s/^/O    /;
18s/^/O    /;
#
19s/^/C    /;
20s/^/H    /;
21s/^/C    /;
22s/^/H    /;
23s/^/C    /;
24s/^/H    /;
25s/^/C    /;
26s/^/H    /;
27s/^/C    /;
28s/^/H    /;
29s/^/C    /;
30s/^/H    /;
31s/^/H    /;
32s/^/O    /;
33s/^/O    /;
34s/^/O    /;
35s/^/O    /;
36s/^/O    /;
# #
37s/^/C    /;
38s/^/H    /;
39s/^/C    /;
40s/^/H    /;
41s/^/C    /;
42s/^/H    /;
43s/^/C    /;
44s/^/H    /;
45s/^/C    /;
46s/^/H    /;
47s/^/C    /;
48s/^/H    /;
49s/^/H    /;
50s/^/O    /;
51s/^/O    /;
52s/^/O    /;
53s/^/O    /;
54s/^/O    /;
#
55s/^/C    /;
56s/^/H    /;
57s/^/C    /;
58s/^/H    /;
59s/^/C    /;
60s/^/H    /;
61s/^/C    /;
62s/^/H    /;
63s/^/C    /;
64s/^/H    /;
65s/^/C    /;
66s/^/H    /;
67s/^/H    /;
68s/^/O    /;
69s/^/O    /;
70s/^/O    /;
71s/^/O    /;
72s/^/O    /;
' > $SED_AUX
for (( cnum=1; cnum<NUM; cnum++ ))
do
  sed -i -f $SED_AUX uc"$cnum"
done
rm -f $SED_AUX
###################################################################### 
cnum=1

#cp uc1 backup_uc1_0.xyz #Meng debug

if [ $FIBRIL -eq 1 ] #Meng mod
then #Meng mod

  for (( J=1; J<=YSIZE; J++ ))
  do
    for (( I=1; I<=XSIZE; I++))
    do
      [ "$I" -eq "1" -a "$J" -ne "$YSIZE" ] && sed -i -e '55,72d' uc"$cnum";
      [ "$J" -eq "1" -a "$I" -ne "1" -a "$I" -ne "$XSIZE" ] && sed -i -e \
                                                           '55,72d' uc"$cnum" ;
      [ "$I" -eq "$XSIZE" -a "$J" -ne "1" ] && sed -i -e '19,36d' uc"$cnum";
      [ "$J" -eq "$YSIZE" -a "$I" -ne "1" -a "$I" -ne "$XSIZE" ] && sed -i -e \
                                                              '19,36d' uc"$cnum" ;
      [ "$I" -eq "1" -a "$J" -eq "$YSIZE" ] && sed -i -e '19,36d;55,72d' uc"$cnum";
      [ "$J" -eq "1" -a "$I" -eq "$XSIZE" ] && sed -i -e '19,36d;55,72d' uc"$cnum";
      cnum=$cnum+1
    done
  done

fi
declare -i ALLATOMS
declare -i LESSATOMS
declare -i NATOMS
ALLATOMS=XSIZE*YSIZE*72
LESSATOMS=(XSIZE+XSIZE-1+YSIZE+YSIZE-1)
LESSATOMS=LESSATOMS*18

if [ $FIBRIL -eq 1 ] # Meng mod
then #Meng mod
  NATOMS=ALLATOMS-LESSATOMS
else #Meng mod
  NATOMS=ALLATOMS #Meng mod
fi #Meng mod

#NATOMS=ALLATOMS-LESSATOMS

list=`for (( cnum=1; cnum<NUM; cnum++ )); do echo "uc"$cnum""; done`
echo "$NATOMS 1" > $CRYSTAL
echo      >> $CRYSTAL
cat $list | sed -e '/^$/d' >> $CRYSTAL
echo      >> $CRYSTAL
rm -f $list
###############################################################################
###############################################################################
###############################################################################
###############################################################################
LAYER=layer
grep -E "^[A-Za-z]{1,2}" $CRYSTAL |tee "$LAYER".xyz| \
sed -r -e 's/[A-Za-z]{1,2}//' > $LAYER 
cat $DIM > $AUXSCRIPT
echo "load $LAYER" >> $AUXSCRIPT
declare -i K=2
for (( K=2; K<=ZSIZE; K++ ))
do
  echo >> $AUXSCRIPT
  echo "lay"$K"(:,1) = "$LAYER"(:,1)" >> $AUXSCRIPT
  echo "lay"$K"(:,2) = "$LAYER"(:,2)" >> $AUXSCRIPT
  echo "lay"$K"(:,3) = "$LAYER"(:,3) + c*("$K"-1)" >> $AUXSCRIPT
  echo "save 'lay"$K"' lay"$K" " >> $AUXSCRIPT
  echo "clear lay"$K" " >> $AUXSCRIPT
  echo >> $AUXSCRIPT
done
octave $AUXSCRIPT > /dev/null 2>&1 || octave_error ;
rm -f $AUXSCRIPT
cat "$LAYER".xyz | sed -r -e 's/^([A-Za-z]{1,2}).*$/\1/' | nl | \
sed -r -e 's/\s*([0-9]+)\s*([A-Za-z]{1,2})/\1s\/\^\/\2    \/;/' > $SED_AUX
for (( K=2; K<=ZSIZE; K++ ))
do
  sed -i -e '/^\#.*$/d' lay"$K"
  sed -i -f $SED_AUX lay"$K"
done
list=`for (( K=2; K<=ZSIZE; K++ )); do echo "lay"$K""; done`
declare -i TOTALATOMS
TOTALATOMS=NATOMS*ZSIZE
rm -f $CRYSTAL
echo "$TOTALATOMS 1" > $CRYSTAL
echo >> $CRYSTAL
all_layers=`echo ""$LAYER".xyz "$list""`
cat $all_layers | sed -e '/^$/d' >> $CRYSTAL
echo >> $CRYSTAL
rm -f $LAYER "$LAYER".xyz $SED_AUX $list

#############################################################################
#############################################################################
#############################################################################
vmdquit='vmdquit'
frlog='frag.log'
nfragpl='./nfrag.pl'
echo 'quit' > $vmdquit
PERL=`which perl`
echo "#!"$PERL"" > $nfragpl
echo 'while( $_ = <> )
{
  if(/Fragments:\s*(\d+)/)
    {
    print "$1\n";
    }
}' >> $nfragpl
chmod +x $nfragpl
declare -i nfrag=0
nfrag=`vmd -dispdev text "$CRYSTAL" -e "$vmdquit">"$frlog" 2>&1 && \
 grep Fragments "$frlog" | "$nfragpl" && rm -f "$vmdquit" "$nfragpl"`
[ "$nfrag" -ne 0 ] || { echo ' ERROR: Could not determine number of fragments. Please report this bug.' ; remove_crap ; exit 5 ; } ;
############################
vmdscript='vmdscript'
forbidden=''
remainder=''
declare -i a=nfrag;
declare -i b=1;
declare -i forb=0;
declare -i upper=nfrag-1;
declare -i logic=1
declare -i yea;
case $1 in
[0-9]*)
;;
fibril)
  vmdaux='vmdaux'
  fibril_frag_list="3 4 5 6 7 8 9 14 15 16 17 18 19 20 21 22 23 24 26 27 28 29 30 31 32 33 34 35 36 41 42 43 44 45 46 47"
  echo "set sel [ atomselect top \"fragment ${fibril_frag_list}\" ]" > $vmdaux
  echo '$sel writexyz crystal_fibril.xyz' >> $vmdaux
  echo 'quit' >> $vmdaux
  vmd -dispdev none "$CRYSTAL" -e "$vmdaux" > vmd_fibril_LOG.log 2>&1  && rm -f $CRYSTAL || vmd_error ;
  endless_failsafe crystal_fibril.xyz ; 
  mv -f crystal_fibril.xyz crystal.xyz
  nfrag=36 ;
;;
center)
  center_frag_list='' ;
  for (( b=0; b<XSIZE-1; b++ ));
  do
    yea=(2*b)+1 ;
    center_frag_list="$center_frag_list $yea" ;
  done
  vmdaux='vmdaux'
  echo "set sel [ atomselect top \"fragment ${center_frag_list}\" ]" > $vmdaux
  echo '$sel writexyz crystal_center.xyz' >> $vmdaux
  echo 'quit' >> $vmdaux
  vmd -dispdev none "$CRYSTAL" -e "$vmdaux" > vmd_center_LOG.log 2>&1  && rm -f $CRYSTAL || vmd_error ;
  endless_failsafe crystal_center.xyz ; 
  mv -f crystal_center.xyz crystal.xyz
  nfrag=XSIZE-1 ;
;;
origin)
  origin_frag_list='' ;
  for (( b=0; b<XSIZE; b++ ));
  do
    yea=2*b ;
    origin_frag_list="$origin_frag_list $yea" ;
  done
  vmdaux='vmdaux'
  echo "set sel [ atomselect top \"fragment ${origin_frag_list}\" ]" > $vmdaux
  echo '$sel writexyz crystal_origin.xyz' >> $vmdaux
  echo 'quit' >> $vmdaux
  vmd -dispdev none "$CRYSTAL" -e "$vmdaux" > vmd_origin_LOG.log 2>&1  && rm -f $CRYSTAL || vmd_error ;
  endless_failsafe crystal_origin.xyz ; 
  mv -f crystal_origin.xyz crystal.xyz
  nfrag=XSIZE ;
;;
esac

echo "for { set i 0 } { \$i < "$nfrag" } { incr i } {" > $vmdscript ;
echo '  set sel [atomselect top "fragment $i"]' >> $vmdscript ;
echo '  $sel writepdb frag_$i.pdb' >> $vmdscript ;
echo '}' >> $vmdscript ;
echo 'quit' >> $vmdscript ;
#vmd -dispdev none "$CRYSTAL" -e "$vmdscript" > /dev/null 2>&1
vmd -dispdev none "$CRYSTAL" -e "$vmdscript" > vmdLOG.log 2>&1  && rm -f $vmdscript || vmd_error ;
grep 'PDB WRITE ERROR' vmdLOG.log  > /dev/null 2>&1  && too_big_error ;
##########################################################
atomtypes=`cat atomtypes_II`
substrpl=./substr.pl
echo "#!"$PERL"" > $substrpl
echo "@atom=qw("$atomtypes");" >> $substrpl
echo '$max = scalar @atom;' >> $substrpl
echo '$i=0;' >> $substrpl
echo '$resid=1;' >> $substrpl
echo 'while( $_ = <> )
{
substr($_,6,11)='\'\ \ \ \ \ \ \ \ \ \ \ \'';
substr($_,12,length($atom[$i]))=$atom[$i];
substr($_,17,4)='BGLC';
$position=26-length($resid);
substr($_,$position,length($resid))=$resid;
substr($_,56,1)='\'1\'';
substr($_,72,4)='CHA1';
print "$_";
$i++;
if($i==$max)
{
$i=0;
$resid++;
}
}' >> $substrpl
chmod +x $substrpl

declare -i f=0;
for (( f=0; f<nfrag; f++ ))
do
  sed -r -i -e '/^.*CRYST.*$/d; /^.*END.*$/d; s/ATOM  /HETATM/' frag_"$f".pdb 
  $substrpl < frag_"$f".pdb > frag_"$f".tmp.pdb
  rm -f frag_"$f".pdb
done
rm -f $substrpl
#######################################################
[ -z "$BASH" ] && BASH=`which bash`;
#PSFGEN=`which psfgen | sed -e 's/\ /\\\ /g'`
psfgensh='./psfgen.tcl'
declare -i c=0;
declare -i cm=0;
declare -i maxc=2*ZSIZE;
declare -i anti=0;
#echo "#!"$BASH"" > $psfgensh
echo "package require psfgen" >$psfgensh #Meng mod
#echo ""$PSFGEN" << ENDMOL" >> $psfgensh
echo 'topology ./bGLC.top' >> $psfgensh
echo >> $psfgensh

 antipl=./anti.pl
 echo "#!"$PERL"" > $antipl
 echo 'while( $_ = <> )
 {
 if (/^HETATM\s* C6\s* BGLCX\s* \d+\s* [+-]?\d+\.\d+\s* [+-]?\d+\.\d+\s* ([+-]?\d+\.\d+)\s* 1.00\s* 0.00\s* CHA1\s* C$/)
   {
   $ZC6=$1 ;
   }
 if (/^HETATM\s* O5\s* BGLCX\s* \d+\s* [+-]?\d+\.\d+\s* [+-]?\d+\.\d+\s* ([+-]?\d+\.\d+)\s* 1.00\s* 0.00\s* CHA1\s* O$/)
   {
   $ZO5=$1 ;
   }
 }
 if ( $ZC6 > $ZO5 )
   {
   print 1 ; 
   }
 if ( $ZC6 < $ZO5 )
   {
   print 0 ; 
   } ' >> $antipl
 chmod +x $antipl

for(( f=0; f<nfrag; f++ ))
do
  head -n 18 frag_${f}.tmp.pdb > ring
  anti=`$antipl < ring` ;
  rm -f ring ;
#
  if [ "$anti" = '0' ] ; then
    echo "segment M"$f" {
    pdb ./frag_"$f".tmp.pdb
    }" >> $psfgensh
    for(( c=maxc; c > 1; c-- ))
    do
      cm=c-1
      echo "patch 14bb M"$f":"$c" M"$f":"$cm"" >> $psfgensh
    done
    echo >> $psfgensh
    if [ "$PCB_c" = 'true' ] ; then
      echo "patch 14bb M"$f":"$c" M"$f":"$maxc"" >> $psfgensh
      echo >> $psfgensh
    fi
    continue ;
  fi
#
  if [ "$anti" = '1' ] ; then
    echo "segment M"$f" {
    pdb ./frag_"$f".tmp.pdb
    }" >> $psfgensh
    for(( c=maxc; c > 1; c-- ))
    do
      cm=c-1
      echo "patch 14bb M"$f":"$cm" M"$f":"$c"" >> $psfgensh
    done
    echo >> $psfgensh
    if [ "$PCB_c" = 'true' ] ; then
      echo "patch 14bb M"$f":"$maxc" M"$f":"$c"" >> $psfgensh
      echo >> $psfgensh
    fi
  fi
done
rm -f $antipl ; 

echo 'regenerate angles dihedrals' >> $psfgensh
echo  >> $psfgensh

for(( f=0; f<nfrag; f++ ))
do
  echo "coordpdb frag_"$f".tmp.pdb M"$f"" >> $psfgensh
done

echo >> $psfgensh
echo 'guesscoord' >> $psfgensh
echo 'writepsf crystal.psf' >> $psfgensh
echo 'writepdb crystal.pdb' >> $psfgensh
echo 'ENDMOL' >> $psfgensh
chmod +x $psfgensh
#$psfgensh > ./psfgen.log 2>&1 
vmd -dispdev text -eofexit <$psfgensh> ./psfgen.log
DOWEGOTIT='UNKNOWN' ;
grep -i 'MOLECULE MISSING' psfgen.log > /dev/null 2>&1  && psfgen_error ;
grep -i 'ERROR' psfgen.log > /dev/null 2>&1  && psfgen_error || {  DOWEGOTIT='ROGERTHAT' ; } ; 
##
echo "REMARK  on `date` by "$USERNAME"@"$HOSTNAME" on system" > whenwhowherehow ; echo "REMARK  `uname -a`" >> whenwhowherehow
mv -f crystal.pdb crystal.pdb.tmp && echo "REMARK generated with cellulose-builder. \
PHASE=$PHASE , PCB_c=$PCB_c ; ( $1 , $2 , $3 )." > crystal.pdb && cat whenwhowherehow basisvectors crystal.pdb.tmp | sed -e '/^$/d' >> crystal.pdb ;
for(( f=0; f<nfrag; f++ ))
do
  rm -f frag_"$f".tmp.pdb
done
rm -f whenwhowherehow basisvectors
###########################################
list=''
ls crystal*  > /dev/null  2>&1  && list=`ls crystal* 2> /dev/null` ;
[ -z "$list" ] || { for file in crystal*
                    do
                      sleep 1 ;
                      which date > /dev/null 2>&1  && dat=`date|sed -e 's/\ /\_/g'`  || dat='AAAAA' ;
                      newname=`echo ""$file"_"$dat""`
                      [ -d "$file" ] && { echo " WARNING: Renaming old directory \`"$file"\` ," ; echo " new name: _"$newname"" ; echo ; mv -f $file _$newname ; } ;
                    done 
                  } ;
[ -d crystal ] && { rm -rf crystal; mkdir -p crystal; } || mkdir -p crystal;
mv -f crystal.pdb crystal.psf crystal.xyz psfgen.tcl psfgen.log crystal  && remove_crap || { echo ' Unexpected error! Oops, this is embarrassing...' ; remove_crap ; exit 3 ; } ;

[ "$DOWEGOTIT" = 'ROGERTHAT' ] && print_thank_you ;
exit 0 ;
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
