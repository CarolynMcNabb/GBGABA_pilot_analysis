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

echo "Creating hifi_b0_brain images for use in Feat b0 unwarping"

for sub in ${!subjects[@]}; do 
    i=${subjects[$sub]}
    s=${i//$"sub-"/}
    
    cd ${derivative_path}/${i}
    sessions=( $(ls -d ses-*))
    for ses in ${sessions}; do

        echo "Creating mean hifi_b0 image for ${i} ${ses} - will overwrite iout output from previous step"
       fslmaths ${derivative_path}/${i}/${ses}/fmap/${i}_${ses}_hifi_b0 -Tmean ${derivative_path}/${i}/${ses}/fmap/${i}_${ses}_hifi_b0
        echo "Performing brain extraction of hifi_b0 image for use in FEAT"
       bet ${derivative_path}/${i}/${ses}/fmap/${i}_${ses}_hifi_b0 ${derivative_path}/${i}/${ses}/fmap/${i}_${ses}_hifi_b0_brain 
       fslmaths ${derivative_path}/${i}/${ses}/fmap/${i}_${ses}_hifi_b0_brain -ero ${derivative_path}/${i}/${ses}/fmap/${i}_${ses}_hifi_b0_brain
        echo "Opening brain extracted image (${i}_${ses}) for user approval - remove ALL non-brain!!!"
        fsleyes ${derivative_path}/${i}/${ses}/fmap/${i}_${ses}_hifi_b0 ${derivative_path}/${i}/${ses}/fmap/${i}_${ses}_hifi_b0_brain -dr 0 10000 --cmap red-yellow &

    done
done



