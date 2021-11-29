# GBGABA PILOT ANALYSIS
Carolyn McNabb


## fMRI analysis using FSL's ICA
Uses FSL 6.0.1 on an ubuntu MATE 16.04 operating system (8GB). 


3.1 perform brain extraction of T1w scan for each participant using FSL's bet function. In the Ubuntu terminal, type:
```
3.1_brainextraction.sh
```
If brain extraction was unsuitable (you can check which subjects you were unhappy with in the brain_extraction_checks.txt file), you can run 3.1.1_betcleanup.sh to improve the extraction for those participants. Before running, you will need to open the script and edit the code to include only those subjects that need additional clean up (line 17). Once this is done, save the script and in the Ubuntu terminal, type:
```
3.1.1_betcleanup.sh
```

3.2. Create a B0 fieldmap for bias field correction during registration in FEAT. In the Ubuntu terminal, type:
```
3.2_fieldmap.sh
```

3.3. Run the first FEAT step (FEATpreproc) to produce independent components that will be used for motion correction. For this step, you need to have put the FEATpreproc.fsf file in a folder that you can access and amend the path to that folder in the 3.3_FEATpreproc.sh script. After doing that, in the Ubuntu terminal, type:
```
3.3_FEATpreproc.sh
```

3.4. Perform additional motion correction with FIX 
FIX issues (FSL’s ICA-based noise removal)
 
When using FIX, you first need to update the path to the Matlab folder in your bash profile so that FIX can find it.
 
Type:
```
gedit ~/.bash_profile
```
In your bash profile add a line:
``` 
export FSL_FIX_MATLAB_ROOT="/usr/local/MATLAB/R2017b"
```
save your bash profile
 
open a new terminal
``` 
module load fix1.065
``` 
----- 
# the following are from the gutmic study - still to be sorted for the gbgaba study but you will be able to modify these scripts

3.5. Warp functional data from subject space into standard space. In Ubuntu terminal window, type:
```
3.5_warp2std.sh
```

3.6. Smooth the functional data (now in standard space) using a 5 mm Gausian kernel and then downsample to 2mm (currently in 1mm space) to increase speed of MELODIC. In ubuntu terminal, type:
```
3.6_smoothdownsample.sh
```
In addition, create a GLM containing the faecal GABA, Glutamate and Glutamine levels from LCMS. In R, run the following script:
```
3.6_GLMSetup.R
```
After doing this, open the GLM gui in FSL. In the ubuntu terminal, type:
```
Glm
```

<table>
   <tr>
       <td>In Glm setup window:
       
1. Change first drop down menu to "Higher-level/non-timeseries design"
1. Change #inputs to 20 (i.e. number of participants)

In General Linear Model window:
1. Change "Number of main EVs" to 5
1. Click "Paste" 

In Higher-level model - paste window:
1. Click "clear"
1. Paste GLM from 3.6_GLMSetup.R by highlighting and copying all content from GLM_faecalLCMS.csv, then clicking inside the paste window using the scroller button of your mouse.
1. Click "OK"

In General Linear Model window:
1. Enter the following names for the EVs:
    "age","hand","GABA","Glutamate", "Glutamine"
1. Click on "Contrasts & F-tests" tab
1. Change number of "Contrasts" to 6
1. Change number of F tests to 3
1. Contrasts should be set up as follows:
<table>
  <tr>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td>F1</td>
      <td>F2</td>
      <td>F3</td>

  <tr>
      <td>GABA+</td>
      <td>0</td>
      <td>0</td>
      <td>1</td>
      <td>0</td>
      <td>0</td>
      <td>🟨</td>
      <td></td>
      <td></td>
   </tr>
   <tr>
       <td>GABA-</td>
       <td>0</td>
       <td>0</td>
       <td>-1</td>
       <td>0</td>
       <td>0</td>
      <td></td>
      <td></td>
      <td></td>
   </tr>
  <tr>
      <td>Glutamate+</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>1</td>
      <td>0</td>
      <td></td>
      <td>🟨</td>
      <td></td>
   </tr>
   <tr>
       <td>Glutamate-</td>
       <td>0</td>
       <td>0</td>
       <td>0</td>
       <td>-1</td>
       <td>0</td>
       <td></td>
      <td></td>
      <td></td>
   </tr>
     <tr>
      <td>Glutamine+</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>1</td>
      <td></td>
      <td></td>
      <td>🟨</td>
   </tr>
   <tr>
       <td>Glutamine-</td>
       <td>0</td>
       <td>0</td>
       <td>0</td>
       <td>0</td>
       <td>-1</td>
       <td></td>
      <td></td>
      <td></td>
   </tr>
</table>

1. Save as "ICA_LCMS" in "/storage/shared/research/cinn/2018/GUTMIC/CM_scripts/GLMs"
1. Exit Glm GUI

</td>
   </tr>
</table>
Notes: GLM files can be found in the GLMs folder in the github directory https://github.com/CarolynMcNabb/GUTMIC_pilot_analysis.git 


3.7. Create group-level independent components using FSL's MELODIC. In the ubuntu terminal, type:
```
3.7_melodic.sh
```

3.8. Run dual regression in FSL to estimate a "version" of each of the group-level spatial maps for each subject. Dual regression regresses the group-spatial-maps into each subject's 4D dataset to give a set of timecourses (stage 1) and then regresses those timecourses into the same 4D dataset to get a subject-specific set of spatial maps (stage 2). In the ubuntu terminal, type:
```
3.8_dualregression.sh
```

3.9. Dual regression will not perform an ANOVA and only t-tests can be viewed in the dual regression output directory at present. To run F-tests you need to run randomise on the dual regression output. Although this isn't necessary for the GUTMIC pilot, it may be required for the GutBrainGABA study so I include it here for completeness. In the ubuntu terminal window, type:
```
3.9_randomise.sh
```


## To do:
- Motion correction
    * FIX 
    
## Notes to self (private repository)

1. readout time=  ([(EPI factor (89))/(parallel image (1) )-1]*echo spacing (0.58 ms))/1000=.05104

1. Using topup to generate fieldmap results in poor bet performance on magnitude (hifi_b0) image so instead, use GRE fieldmap for unwarping

1. sub-001 does not have fMRI data

