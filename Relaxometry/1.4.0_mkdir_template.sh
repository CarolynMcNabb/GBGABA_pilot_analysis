#Carolyn McNabb 
#September 2021
#GBGABA BRAIN DATA PILOT ANALYSIS 
#1.4.0_mkdir_template.sh will copy the brain-extracted T1 images from selected participants (which you need to define in the script below)
#!/bin/bash


bids_path=/storage/shared/research/cinn/2020/gbgaba/pilot_BIDS
derivative_path=${bids_path}/derivatives/relaxometry/preprocessed
template_path=${derivative_path}/template

mkdir -p ${template_path}

cd ${derivative_path}

for sub in 003 004 005 008; do #list the participants you want to include in the template here
    i=$(echo "sub-${sub}")
    
    cd ${derivative_path}/${i}

    for ses in 01; do
        s=$(echo "ses-${ses}")
        cp ${derivative_path}/${i}/${ses}/${i}_${s}_MP2_T1_brain.nii.gz ${template_path}

    done
done