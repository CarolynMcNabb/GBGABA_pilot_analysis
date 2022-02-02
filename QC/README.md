# GBGABA MRI Quality Control
Carolyn McNabb 2021 - Find me at https://github.com/CarolynMcNabb</br>
Quality control analysis uses [visualqc](https://raamana.github.io/visualqc/installation.html) on a MacOS Big Sur operating system.</br> 
All analysis scripts are available [here](https://github.com/CarolynMcNabb/GBGABA_pilot_analysis/tree/main/QC)


## Initial setup
In terminal on MacOS, type:
```
pip install -U visualqc
```

## Check functional data quality
In MacOS terminal, type:
```
visualqc_func_mri --bids_dir=/Volumes/gold/cinn/2020/gbgaba/pilot_BIDS --out_dir /Volumes/gold/cinn/2020/gbgaba/pilot_BIDS/derivatives/QC  --id_list /Volumes/gold/cinn/2020/gbgaba/pilot_BIDS/derivatives/QC/qc_sub_list.txt --name_pattern 'ses-01/func/*_task-rest_bold.nii.gz' 
```

## Check T1w (MPRAGE) anatomical data quality
In MacOS terminal, type:
```
visualqc_anatomical --bids_dir=/Volumes/gold/cinn/2020/gbgaba/pilot_BIDS --out_dir /Volumes/gold/cinn/2020/gbgaba/pilot_BIDS/derivatives/QC/anat/T1w  --id_list /Volumes/gold/cinn/2020/gbgaba/pilot_BIDS/derivatives/QC/qc_sub_list.txt --mri_name 'ses-01/anat/sub*_T1w.nii.gz' 
```

## Check MP2RAGE anatomical data quality
```
visualqc_anatomical --bids_dir=/Volumes/gold/cinn/2020/gbgaba/pilot_BIDS --out_dir /Volumes/gold/cinn/2020/gbgaba/pilot_BIDS/derivatives/QC/anat/mp2rage  --id_list /Volumes/gold/cinn/2020/gbgaba/pilot_BIDS/derivatives/QC/qc_sub_list.txt --mri_name 'ses-01/anat/sub*_T1w.nii.gz' 
```