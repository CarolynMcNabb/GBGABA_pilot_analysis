#Carolyn McNabb 
#September 2021
#GBGABA BRAIN DATA PILOT ANALYSIS 
#1.4.0_mkdir_template.sh will copy the brain-extracted T1 images from selected participants (which you need to define in the script below)
#!/bin/bash

module load ANTs/ITKv4 #load ANTs - if you are using a machine other than the virtual machine at University of Reading, you can comment out this line.

#set up paths

bids_path=/storage/shared/research/cinn/2020/gbgaba/pilot_BIDS
derivative_path=${bids_path}/derivatives/relaxometry/preprocessed
template_path=${derivative_path}/template

#set up variables
dim=3 #image dimensions
stat=1 #image statistic 1=mean of normalised intensities
iter=30x50x20 #Max-iterations in each registration
trans=GR #transformation model used for nonlinear registration; GR = Greedy SyN
sim=CC #similarity metric CC=cross correlation, which is the best but not necessarily the fastest 
par=0 #parallel computing, 0=run serially; 5=SLURM
output=group_template #output name
input=./*.nii.gz #input files

mkdir -p ${template_path}

cd ${derivative_path}

for sub in 003 004 005 008; do #list the participants you want to include in the template here
    i=$(echo "sub-${sub}")
    
    cd ${derivative_path}/${i}

    for ses in 01; do
        s=$(echo "ses-${ses}")
            
            cd ${template_path}

            antsMultivariateTemplateConstruction.sh -d ${dim} -a ${stat} -m ${iter} -t ${trans} -s ${sim} -c ${par} -o ${output} ${input}

    done
done