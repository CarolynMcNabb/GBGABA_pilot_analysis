# GBGABA_pilot_analysis
 *MRI analysis scripts for Gut Brain GABA pilot*
 
 ## Proposed changes to acquisition protocol for main study:
 
### 1. fMRI
 
 - Collect SB multiband image for registration purposes
 - P>>A PE direction for multiband fMRI 
 - Eyes open resting, MB 6, no in-plane acceleration
 - We only need 600 TRs (900 currently)
 


### 2. Fieldmap
 
 - Use GRE fieldmap instead of blip up/down for fieldmap generation
 
 
 ### 3. MP2RAGE
 
 - Use magnitude reconstruction and retro-recon for MP2RAGE. See instructions [here](Protocol_setup/RetroReconGuide.md)
 
 
 ### 4. MRS

 - Sensory motor cortex voxel placement: See supplementary materials for [Stagg et al., 2011](https://doi.org/10.1016/j.cub.2011.01.069) and [Stagg et al., 2014](https://doi.org/10.7554/eLife.01465.001)
 - Striatal voxel placement: See [Dharmadhikari et al., 2015](https://doi.org/10.1016/j.neuroimage.2015.06.066) and [Quetscher et al., 2015](https://doi.org/10.1007/s00429-014-0873-y)
 - Consider smaller voxel for striatum (3.0 x 3.0 x 2.5 mm)
 - Lipid saturation for motor cortex voxel - Suggestions from Georg Oeltzschner:
 > *Striatum can be tricky. You might want to try different settings for the initial 3D shim (brain, advanced... I forget the names of it but you probably know what I mean!).
Regarding motor cortex voxel, consider adding a lipid saturation band over the adjacent skull to minimize artefacts from fat. If it prompts you for a frequency input, use -3.4 ppm (which is calculated relative to water, i.e. 1.3 ppm, which is the frequency of the lipid signals).*

## Proposed changes to analysis protocol for main study:

### 1. fMRI
 - Include SBref in Feat protocol for preprocessing stage
 