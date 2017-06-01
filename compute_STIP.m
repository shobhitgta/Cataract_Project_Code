function features = compute_STIP(vid, vox_size, max_feat)
v = vox_size;
%boundary of frames to calculate STIP features
start = 1 + floor(vox_size/2);
finish = vid.NumberOfFrames - floor(vox_size/2);

feat_loc = zeros(max_feat * (finish-start+1), 3);

% Calculate STIP features
pos = 1;
for k = start:finish
    
    im = read(vid,k);
    height = vid.height;
    width = vid.width;
    
    % from Recognize.m
    f1=il_rgb2gray(double(im));
    %[ysize,xsize]=size(f1); %using x,y coordinate system, not row, column
    nptsmax=max_feat;
    kparam=0.04;
    pointtype=1;
    sxl2=4;
    sxi2=2*sxl2;
    
    % detect points
    [posinit,~] = STIP(f1,kparam,sxl2,sxi2,pointtype,nptsmax);
    %save posinit;
    
    %eliminate points outside boundaries of voxel
    %columns outside range of voxel
    c1 = posinit(:,1) < floor(v/2) + 1;
    c2 = posinit(:,1) > width - floor(v/2) - 1;
    %rows outside range of voxel
    c3 = posinit(:,2) < floor(v/2) + 1;
    c4 = posinit(:,2) > height - floor(v/2) -1;
    c = c1 | c2 | c3 | c4;
    posinit(c,:) = [];
    
    feat_loc(pos:(pos + size(posinit,1)-1),1) = k;
    feat_loc(pos:(pos + size(posinit,1)-1),2:3) = posinit(1:size(posinit,1),1:2);
    pos = pos + size(posinit,1);
end

feat_loc((feat_loc(:,1) == 0),:) = [];

%randomly choose which features to keep
total_features = size(feat_loc,1);
num_features = floor(0.12*total_features);
feat = randsample(total_features,num_features);
%column 1 frame, column 2 column, column 3 row
features = feat_loc(feat,:);
%sort features by frame
features = sortrows(features, 1);
