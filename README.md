# GBGABA_pilot_analysis
Carolyn McNabb 2021 - Find me at https://github.com/CarolynMcNabb</br>
 *MRI analysis scripts for Gut Brain GABA pilot*
 
This is a work in progress! As code is based on pilot data, modifications will most likely be made for the main study. 


 
### 1. fMRI
 
 - Have gone with single-band data based on reproducibility results reported by [Golestani et al. (2017)](https://www.frontiersin.org/articles/10.3389/fnins.2017.00546/full) 

 - Inclusion of HR data still to do 
 - Use Rapidtide to deal with CO2 effects
 

### 2. Fieldmap
 
 - Using GRE fieldmap instead of blip up/down for fieldmap generation
 
 
 ### 3. MP2RAGE
 
 - Use magnitude reconstruction and retro-recon for MP2RAGE. See instructions [here](Protocol_setup/RetroReconGuide.md)
 
 
 ### 4. MRS

 - Sensory motor cortex voxel placement: See supplementary materials for [Stagg et al., 2011](https://doi.org/10.1016/j.cub.2011.01.069) and [Stagg et al., 2014](https://doi.org/10.7554/eLife.01465.001)
 - Lipid saturation for motor cortex voxel - Suggestions from Georg Oeltzschner:
 > *Regarding motor cortex voxel, consider adding a lipid saturation band over the adjacent skull to minimize artefacts from fat. If it prompts you for a frequency input, use -3.4 ppm (which is calculated relative to water, i.e. 1.3 ppm, which is the frequency of the lipid signals).*


 