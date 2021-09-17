#Carolyn McNabb 
#September 2021
#GBGABA BRAIN DATA PILOT ANALYSIS 
#1.0_merge.sh will merge magnitude and phase images acquired using MP2RAGE
#!/bin/bash

module load fsl6.0 #load fsl - if you are using a machine other than the virtual machine at University of Reading, you can comment out this line.

bids_path=/storage/shared/research/cinn/2020/gbgaba/pilot_BIDS
derivative_path=${bids_path}/derivatives/quit/preprocessed

cd $bids_path
subjects=( $(ls -d sub-* )) 

for sub in ${!subjects[@]}; do 
    i=${subjects[$sub]}
    s=${i//$"sub-"/}
    
    cd ${bids_path}/${i}
    sessions=( $(ls -d ses-*))
    for ses in ${sessions}; do
 
        echo "Merging magnitude files for ${i} ${ses}"
        
        fslmerge -t ${derivative_path}/${i}/${ses}/${i}_${ses}_mag ${bids_path}/${i}/${ses}/anat/${i}_${ses}_TI1_magnitude_mp2rage.nii.gz ${bids_path}/${i}/${ses}/anat/${i}_${ses}_TI2_magnitude_mp2rage.nii.gz
        
        echo "Merging phase files for ${i} ${ses}"
        
        fslmerge -t ${derivative_path}/${i}/${ses}/${i}_${ses}_phase ${bids_path}/${i}/${ses}/anat/${i}_${ses}_TI1_phase_mp2rage.nii.gz ${bids_path}/${i}/${ses}/anat/${i}_${ses}_TI2_phase_mp2rage.nii.gz


    done
done