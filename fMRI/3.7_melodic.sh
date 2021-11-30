#Carolyn McNabb 
#November 2021
#GBGABA BRAIN DATA PILOT ANALYSIS 
#3.7_melodic.sh runs FSL's melodic - Melodic will perform ICA on the group as a whole (i.e. all participants at once). It will create components that will be used in the dual regression.


#Key:
#-i = input file
#-o = output directory
#-v = switch on diagnostic messages
#--nobet = no brain extraction
bgthreshold=10 # brain/nonbrain threshold - this needs to be on if not performing bet
tr=2.16 #for the GBGABA study
mmthresh=0.5 # the threshold for mixture modelling
dim=30 # number of components you want out
#Ostats produces a folder containing threshold and probability maps.

#!/bin/bash

module load fsl6.0 #load fsl - if you are using a machine other than the virtual machine at University of Reading, you can comment out this line.

bids_path=/storage/shared/research/cinn/2020/gbgaba/pilot_BIDS
analysis_path=${bids_path}/derivatives/fMRI/analysis
script_path=/storage/shared/research/cinn/2020/gbgaba/scripts

echo "MELODIC running - will produce ${dim} components"
melodic -i ${script_path}/melodic_inputlist.txt -o ${analysis_path}/melodic_components --nobet --bgthreshold=${bgthreshold} --tr=${tr} --mmthresh=${mmthresh} --dim=${dim}


