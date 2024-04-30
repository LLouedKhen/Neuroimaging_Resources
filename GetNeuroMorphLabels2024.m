
%where your SPM.mat file lives
datapath = {};
cd(dataPath)
load SPM.mat

%where your result coordinates live
cd '/Users/sysadmin/Documents/ImagingData/MediationAnalyses'

files = dir('X-M-Y_pvals_*.csv');
for i = 1:length(files)
thisFile = files(i).name;
t = readtable(thisFile);
theseC = table2array(t(:, 2:4));
XYZmm = theseC';
xA = spm_atlas('load','neuromorphometrics');
%XYZmm = [TabDat.dat{:,end}];
label = {};
for j=1:size(XYZmm,2)
  label{j} = spm_atlas('query',xA,XYZmm(:,j));
end
labels = label';
t.Region = labels;
writetable(t,[thisFile(1:end-4), 'Abdridged.csv']);
file = [thisFile(1:end-4), 'labels.mat'];
save(file, 'labels');
end
