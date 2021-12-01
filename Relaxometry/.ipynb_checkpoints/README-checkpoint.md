# Relaxometry analysis for Gut Brain GABA pilot
Carolyn McNabb 2021 - Find me at https://github.com/CarolynMcNabb</br>
All analysis scripts are available [here](https://github.com/CarolynMcNabb/GBGABA_pilot_analysis/tree/main/Relaxometry)

The first time you run these scripts, whether on the virtual machine (VM) or on MacOS, you will need to make the scripts executable. To do this, run the following command in the terminal, replacing [script_name] with the relavant script name and [path_to_script] with the relevant path to the directory where your scripts are kept. Note that this is likely to be a different path for the VM and MacOS. You only have to do this **ONCE** for each script.
```
chmod u+x path_to_script/script_name
```

Every time you log onto a terminal, you need to remind it where your scripts are (or you can modify your bash profile). Once again, replace [path_to_script] with your actual path. In the terminal, type:
```
PATH=$PATH:path_to_script
export PATH
```

#### *N.B. All the paths in the scripts are specific to my own directories - the paths for the VM should be able to be used without adjusting but the MacOS paths will obviously need to be changed to match your own before continuing.* 

___ 

## 1.0. Prepare images
Merge magntitude and phase images using FSL. In ubuntu terminal window, type:
```
1.0_merge.sh
```

## 1.1. Create T1 map and UNI image using QUIT 

QUantitative Imaging Tools ([QUIT](https://quit.readthedocs.io/en/latest/index.html)) can be installed from Github using the following [link](http://github.com/spinicist/QUIT/releases)

For my own reference, Quit toolbox is stored in:
```
/Volumes/GoogleDrive/My Drive/Software/qi 
```
 *The following commands were run on MacOS Big Sur version 11.6*
 
Open a bash terminal (macos terminal is fine) and modify path:
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

## 1.2. Create MP2RAGE brain mask using HD-BET 
HD-BET is available [here](https://github.com/MIC-DKFZ/HD-BET)

Theoretically this should work on the VM but I have had trouble installing it. It works on MacOS for now but I had to add the -device cpu to do this. This can be removed if used on the VM.
Make sure you have installed HD-BET before running this script (follow the README instructions on their github page).
In MacOS terminal, type:

```
1.2_hd_bet.sh
```

## 1.3. Get brain extracted T1 by using mask from HD-BET
This step should be conducted using the VM (Ubuntu). In the Ubuntu terminal, type:
```
1.3_mask_t1.sh
```

#### Now the data are ready for co-registraton and segmentation 

## 1.4. Create a group template based on GBGABA participants' data using ANTs 
Recommendation is to use about 10 participants' data to create the group template (allegedly, adding more than this doesn't actually improve the template but feel free to try!)

This step uses antsMultivariateTemplateConstruction.sh (N.B. I read a thread where this version performs better than antsMultivariateTemplateConstruction2.sh and so am going with the older version for now) - this can be reviewed later. 

#### Before running this step, you need to select 10 good looking T1 images that you want to use to create the template. All images to be added to the template should be in the same directory, and this script should be invoked from that directory.
In the ubuntu terminal, type:
```
1.4.0_mkdir_template.sh
```

### To do: This can be run using SLURM on the cluster [-c 5] 

In the Vanilla VM, load ANTs module and run antsMultivariateTemplateConstruction.sh - Note, this takes ages without SLURM.
```
1.4.1_construct_template.sh
```

Now register the group template to MNI space - standard MNI data are in the gbgaba/standard directory
```
1.4.2_template2mni.sh
```

## 1.5. Register and transform all subject data to MNI space
```
1.5_reg_and_transform.sh
antsRegistrationSyN then antsApplyTransforms
```

---
