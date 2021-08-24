#Carolyn McNabb 
#August 2021
#GBGABA BRAIN DATA PILOT ANALYSIS 
#3.2.2_topup.sh will estimate the susceptibility induced off-resonance field using FSL's topup and store output in derivatives/fMRI/preprocessed folder for that ppt

#!/bin/bash

module load fsl6.0 #load fsl - if you are using a machine other than the virtual machine at University of Reading, you can comment out this line.

code_path=/storage/shared/research/cinn/2020/gbgaba/scripts
derivative_path=/storage/shared/research/cinn/2020/gbgaba/pilot_BIDS/derivatives/fMRI/preprocessed

cd $derivative_path
subjects=( $(ls -d sub-* )) 


for sub in ${!subjects[@]}; do 
    i=${subjects[$sub]}
    s=${i//$"sub-"/}
    
    cd ${derivative_path}/${i}
    sessions=( $(ls -d ses-*))
    for ses in ${sessions}; do

        echo "Estimating susceptibilty induced distortion for ${i} ${ses} using FSL's topup - this will take a while"
topup --imain=${derivative_path}/${i}/${ses}/fmap/${i}_${ses}_b0_images.nii.gz --datain=${code_path}/acq_param.txt --config=${code_path}/b02b0.cnf --out=${derivative_path}/${i}/${ses}/fmap/${i}_${ses}_topup_output  --iout=${derivative_path}/${i}/${ses}/fmap/${i}_${ses}_hifi_b0 --fout=${derivative_path}/${i}/${ses}/fmap/${i}_${ses}_b0_field 


    done
done




