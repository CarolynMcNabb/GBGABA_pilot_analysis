# Instructions for T1 Relaxometry using QUIT 

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
cd /Volumes/gold/cinn/2020/gbgaba/pilot_BIDS/sub-002/ses-01/anat
```
Run the command:

```
qi mp2rage t1_map.nii.gz --out=/Volumes/gold/cinn/2020/gbgaba/pilot_BIDS/derivatives/quit/sub-002/ses-01/sub-002_ses-01_
```