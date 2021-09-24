# Relaxometry analysis for Gut Brain GABA pilot
### Carolyn McNabb 2021

## Merge magntitude and phase images using FSL
In ubuntu terminal window, type:
```
1.0_merge.sh
```

## Instructions for T1 Relaxometry using QUIT 

Quit toolbox is in: 
```
/Volumes/GoogleDrive/My Drive/Software/qi 
```

Open a bash terminal (macos terminal is fine) and modify path
```
PATH=$PATH:/Volumes/GoogleDrive/My\ Drive/Software/
export PATH
```

Test QUIT toolbox is working by typing:
```
qi mp2rage --help
```

Change directory into BIDS directory
```
cd /Volumes/gold/cinn/2020/gbgaba/pilot_BIDS/derivatives/quit/preprocessed/sub-003/ses-01
```
Run the following commands:

```
qi complex -m ./sub-003_ses-01_mag.nii.gz -p ./sub-003_ses-01_phase_rad.nii.gz -X ./sub-003_ses-01_mp2_x.nii

qi mp2rage ./sub-003_ses-01_mp2_x.nii --json=/Volumes/GoogleDrive/My\ Drive/GitHub/GBGABA_pilot_analysis/Relaxometry/mp2rage.json --beta=10000

```