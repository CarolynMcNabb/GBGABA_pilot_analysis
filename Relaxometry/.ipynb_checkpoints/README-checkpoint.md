# Relaxometry analysis for Gut Brain GABA pilot
### Carolyn McNabb 2021

## Merge magntitude and phase images using FSL
In ubuntu terminal window, type:
```
1.0_merge.sh
```

## Instructions for T1 Relaxometry using QUIT 
### The following commands were run on MacOS Big Sur version 11.6 

Quit toolbox is in: 
```
/Volumes/GoogleDrive/My Drive/Software/qi 
```

Open a bash terminal (macos terminal is fine) and modify path
```
PATH=$PATH:/Volumes/GoogleDrive/My\ Drive/Software/
export PATH
PATH=$PATH:/Volumes/GoogleDrive/My\ Drive/GitHub/GBGABA_pilot_analysis/Relaxometry
export PATH
```

Test QUIT toolbox is working by typing:
```
qi mp2rage --help
```

Create complex file and T1 image.
In the bash terminal (macos), type:
```
1.1_quit.sh
```


