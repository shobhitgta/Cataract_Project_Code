% Compute STIP features and 3D HOG descriptors for each video
%cd ['/Users/SV/Documents/Desktop/LoS/Data/Cataract/Skill/',...
%   'Becca_SV/CataractProjectCode/']

vid_path = 'F:\CataractProjectCode\Videos_Train\';
save_path = 'F:\CataractProjectCode\Output\';

addpath(genpath(['F:\CataractProjectCode\STIP\']));
addpath(genpath(['F:\CataractProjectCode\HOG3D\']));
addpath(genpath(['F:\CataractProjectCode\pca\']));

% mkdir '/Users/SV/Desktop/LoS/Data/Cataract/Skill/Becca_SV/output/features';
% mkdir ['/Users/SV/Desktop/LoS/Data/Cataract/Skill/Becca_SV/output/',...
%     'features/hog3d'];
% mkdir ['/Users/SV/Desktop/LoS/Data/Cataract/Skill/Becca_SV/output/',...
%     'features/stip'];
% mkdir ['/Users/SV/Desktop/LoS/Data/Cataract/Skill/Becca_SV/output/',...
%     'features/hof'];

d=dir(vid_path);
for a = length(d):-1:1
   fname = d(a).name;
   if fname(1) == '.'
    d(a) = [];
   end
end

vox_size = 25;
max_feat = 50;
numFrames = 0;

for k=1:length(d)
    fname=d(k).name;
    vid = VideoReader(fullfile(vid_path,fname));
    disp(['Computing STIP for ' fname '...'])
    features = compute_STIP(vid, vox_size, max_feat);
    save(fullfile(save_path,'features','stip',...
        [fname,'_STIP_features.mat']),'features');
    
    
    % -- HOG3D --
    %disp(['Computing HOG3D for ' fname(1:7) '...'])
    %hog3d = compute_HOG3D(vid, features, vox_size,save_path,fname);
    %save(fullfile(save_path,'features','hog3d',...
    %    [fname(1:7),'_hog3d_features.mat']),'hog3d','-v7.3');
    
    
    % -- HOGS --
    disp(['Computing HOGS for ' fname '...'])
    hogs = compute_HOGS(vid, features, save_path,fname);
    save(fullfile(save_path,'features','hogs',...
        [fname,'_hogs_features.mat']),'hogs','-v7.3');
    
end

%Reducing the Dimension of the Descriptor.
% -- HOGS -- 
compute_pca(40,0);