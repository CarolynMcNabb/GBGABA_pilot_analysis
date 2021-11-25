%%% 0. CREDITS %%%
% This is a GUI generated Osprey jobFile. The code was kindly shared by Dr. Peter Van Schuerbeek (UZ Brussel)

%%% 1. SPECIFY SEQUENCE INFORMATION %%%
seqType = 'HERMES';
editTarget = {'GABA', 'GSH'};

%%% 2. SPECIFY DATA HANDLING AND MODELING OPTIONS %%%
opts.saveLCM = 0;
opts.savejMRUI = 0;
opts.saveVendor = 0;
opts.fit.method = 'Osprey';
opts.fit.includeMetabs = {'default'};
opts.fit.style = 'Separate';
opts.fit.range = [0.2 4.2];
opts.fit.rangeWater = [2.0 7.4];
opts.fit.bLineKnotSpace = 0.4;
opts.fit.fitMM = 1;

%%% 3. SPECIFY MRS DATA AND STRUCTURAL IMAGING FILES %%%
files = {'/Volumes/gold/cinn/2020/gbgaba/pilot_BIDS/sub-006/ses-01/mrs/motorcortex/hermes/meas_MID00051_FID49810_svs_edit_mgs_univ_HERMES_MC.dat'};
files_ref = {'/Volumes/gold/cinn/2020/gbgaba/pilot_BIDS/sub-006/ses-01/mrs/motorcortex/hermes_ref/meas_MID00053_FID49812_svs_edit_mgs_univ_H2O_HERMES_MC.dat'};
files_w = {'/Volumes/gold/cinn/2020/gbgaba/pilot_BIDS/sub-006/ses-01/mrs/motorcortex/water/meas_MID00049_FID49808_svs_se_30_MC_H2O.dat'};
files_mm = {};
files_nii = {'/Volumes/gold/cinn/2020/gbgaba/pilot_BIDS/sub-006/ses-01/anat/sub-006_ses-01_T1w.nii'};

%%% 4. SPECIFY OUTPUT FOLDER %%%
outputFolder = '/Volumes/gold/cinn/2020/gbgaba/pilot_BIDS/derivatives/Osprey/sub-006MC_HERMES';