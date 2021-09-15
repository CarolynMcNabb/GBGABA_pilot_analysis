#Carolyn McNabb 
#April 2021
#GUTMIC BRAIN DATA PILOT ANALYSIS 
#2.0_dcm2bids.sh will run dcm2bids to convert all dicom images in the raw data file into BIDS formatted nifti images

#!/bin/bash

raw_path=/storage/shared/research/cinn/2020/gbgaba/raw
code_path=/storage/shared/research/cinn/2020/gbgaba/scripts/code
data_dir=/storage/shared/research/cinn/2020/gbgaba/pilot_BIDS
#for now, session ID is defined here but later, I will pull it from the subject name
ses=01

cd ${raw_path}
subjects=( $(ls -d GBGABA_pilot* )) 

cd ${data_dir}
for sub in ${!subjects[@]}; do 
i=${subjects[$sub]}
s=${i//$"GBGABA_pilot"/}
 
echo "Converting dicom data for ${i} to BIDS"

dcm2bids -d ${raw_path}/${i}/ -p ${s} -s ${ses} -c ${code_path}/dcm2bids_config.json 

done

#if you want to include session, you need to use the following code
#dcm2bids -d DICOM_DIR -p PARTICIPANT_ID -s SESSION_ID -c CONFIG_FILE
#need to find a way to store data in raw folder so that it can be divided into session