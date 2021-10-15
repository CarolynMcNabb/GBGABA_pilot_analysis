# Relaxometry analysis for Gut Brain GABA pilot
#### Carolyn McNabb 2021

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

---
## 1.2. Co-registration and segmentation using Nighres 
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
**Got a warning - WARNING: Keyring is skipped due to an exception: Failed to unlock the collection!**

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