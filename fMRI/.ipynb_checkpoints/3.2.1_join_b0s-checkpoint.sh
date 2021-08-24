#Carolyn McNabb 
#April 2021
#GBGABA BRAIN DATA PILOT ANALYSIS 
#3.2.1_join_B0s.sh will paste B0 volumes together to create a new 4D file called b0_images to be stored in the derivatives/fMRI/preprocessed folder for that ppt

#!/bin/bash

module load fsl6.0 #load fsl - if you are using a machine other than the virtual machine at University of Reading, you can comment out this line.

bids_path=/storage/shared/research/cinn/2020/gbgaba/pilot_BIDS
derivative_path=${bids_path}/derivatives/fMRI/preprocessed

cd $bids_path
subjects=( $(ls -d sub-* )) 

for sub in ${!subjects[@]}; do 
    i=${subjects[$sub]}
    s=${i//$"sub-"/}
    
    cd ${bids_path}/${i}
    sessions=( $(ls -d ses-*))
    for ses in ${sessions}; do
 
        echo "Creating b0_images file for ${i} ${ses}"

        fslmerge -t ${derivative_path}/${i}/${ses}/fmap/${i}_${ses}_b0_images.nii.gz ${bids_path}/${i}/${ses}/fmap/${i}_${ses}_dir-RL_epi.nii.gz ${bids_path}/${i}/${ses}/fmap/${i}_${ses}_dir-LR_epi.nii.gz  #merge the dir-RL and dir-LR epi images from the main subject folder

    done
done
