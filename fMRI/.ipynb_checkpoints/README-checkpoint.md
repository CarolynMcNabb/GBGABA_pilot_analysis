## To do:
- Feat 
    * reg files will be used to warp to standard space
- Motion correction
    * FIX 
- Warp to standard space
```
    applywarp -r $d/rest_pre_FIX.feat/reg/standard.nii.gz  -i $d/rest_pre_FIX.feat/filtered_func_data_clean.nii.gz -o $d/fixed_fmri_standard -w $d/rest_pre_FIX.feat/reg/highres2standard_warp.nii.gz --premat=$d/rest_pre_FIX.feat/reg/example_func2highres.mat 
```
- Smooth
```
    fslmaths fixed_fmri_standard.nii.gz -s 2.1233226 fixed_smoothed_fMRI.nii.gz
```
    
- Downsample
```
    flirt -interp nearestneighbour -in fixed_smoothed_fmri.nii.gz -ref ../fnirted_average_v3_brain.nii.gz -applyisoxfm 2 -out lowres_rest_fixed.nii.gz
```
- create input list using low resolution data
```
    for d in * ; do
        if [ -e $d/lowres_rest_fixed.nii.gz ]
        then
            ls -d -1 $pwd/$d/lowres_rest_fixed.nii.gz >> inputlist_resting.txt
        fi
    done

```
-Run melodic

```
    melodic -i /storage/shared/research/cinn/2017/MOTIVC/oct17/inputlist_resting.txt -o /storage/shared/research/cinn/2017/MOTIVC/oct17/ICA_smoothed_20_components -v --nobet --bgthreshold=10 --tr=1.5 --mmthresh=0.5 --dim=20
```
- Dual regression
```
    dual_regression /storage/shared/research/cinn/2017/MOTIVC/oct17/ICA_smoothed_20_components/melodic_IC.nii.gz 1 /storage/shared/research/cinn/2017/MOTIVC/oct17/GLM_eigen_Ftest.mat /storage/shared/research/cinn/2017/MOTIVC/oct17/GLM_eigen_Ftest.con 5000 /storage/shared/research/cinn/2017/MOTIVC/oct17/DR_eigen_Ftest.DR `cat /storage/shared/research/cinn/2017/MOTIVC/oct17/inputlist_resting.txt`
```
- Randomise
```
    for i in 00 01 02 03 04 05 06 07 08 10 11 12 13 14 15 16 17 18 19
do 
echo "performing randomise on IC${i}"
randomise_parallel -i dr_stage2_ic00${i}.nii.gz -o randomise_ftest_ic${i} -d design.mat -t design.con -f ../GLM_eigen_Ftest.fts -n 5000 -D -T -x
done

```
    
## Notes to self (private repository)

1. readout time=  ([(EPI factor (89))/(parallel image (1) )-1]*echo spacing (0.58 ms))/1000=.05104

1. Using topup to generate fieldmap results in poor bet performance on magnitude (hifi_b0) image so instead, use GRE fieldmap for unwarping

1. Unlikely to need acq_param.txt and b02b0.cnf files if not using topup for fieldmap generation

1. sub-001 does not have fMRI data

