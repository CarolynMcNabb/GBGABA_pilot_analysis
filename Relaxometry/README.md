# Relaxometry analysis for Gut Brain GABA pilot
#### Carolyn McNabb 2021
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
module load ANTs/ITKv4
cd /storage/shared/research/cinn/2020/gbgaba/pilot_BIDs/derivatives/relaxometry/preprocessed/template
antsMultivariateTemplateConstruction.sh -d 3 -a 1 -m 30x50x20 -t GR -s CC -c 0 -o group_template ./*.nii.gz
```





---
## 1.4. Co-registration and segmentation using Nighres/ANTs 
### Some initial set-up stuff that only needs to be done once
The Neuroimaging at high resolution ([Nighres](https://nighres.readthedocs.io/en/latest/index.html)) package can be cloned from Gihub using the following [link](https://github.com/nighres/nighres)

In the ubuntu terminal window in a Vanilla Fat VM, type:
```
cd /storage/shared/research/cinn/2020/gbgaba/scripts
git clone https://github.com/nighres/nighres
module load anaconda
```

Build Nighres (instructions [here](https://nighres.readthedocs.io/en/latest/installation.html))
Make sure you have Java JDK and JCC installed and set up. You will likely need to point the JCC_JDK variable to your Java JDK installation
```
sudo apt-get install openjdk-8-jdk
export JCC_JDK=/usr/lib/jvm/java-8-openjdk-amd64
python3 -m pip install jcc
```

**Got a warning - WARNING: pip is configured with locations that require TLS/SSL, however the ssl module in Python is not available. WARNING: Keyring is skipped due to an exception: Failed to unlock the collection!**

Navigate to the Nighres directory you downloaded and unpacked, and run the build script:
```
cd nighres
./build.sh
```

Now install the python package
```
python3 -m pip install .
```

Test the installation to see if it worked
```
cd /storage/shared/research/cinn/2020/gbgaba/
python3 -c "import nighres"
cd /storage/shared/research/cinn/2020/gbgaba/scripts/nighres/examples
python3 example_01_tissue_classification.py
```

some debugging required: see https://stackoverflow.com/questions/40372537/cannot-mix-incompatible-qt-library-version-0x50501-with-this-library-version 
Etienne had to update QT library on my VM