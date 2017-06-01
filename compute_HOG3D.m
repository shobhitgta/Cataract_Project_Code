function desc = compute_HOG3D(vid, features, vox_size,save_path,fname)

v = vox_size;
vox = zeros(v,v,v);
xGrid = 8;
yGrid = 8;
tGrid = 8;
num = size(features,1);
desc = zeros(num, xGrid*yGrid*tGrid*20);
pos = 1;
curr_frame = 0;
for d=1:num
    f = features(d,1);
    if mod(d,4000)==0
        disp(['3DHOG for feature ' num2str(d) ' of ' num2str(num)]);
    end
    if (f ~= curr_frame)
        frames = il_rgb2gray(double(read(vid,[f-floor(v/2) f+floor(v/2)])));
        curr_frame = f;
    end
    col = features(d,2);
    row = features(d,3);
    cols = (col-floor(v/2)):(col+floor(v/2));
    rows = (row-floor(v/2)):(row+floor(v/2));
    
    for c = 1:v
        f = frames(:,:,:,c);
        for b = 1:v
            for a = 1:v
                vox(a,b,c) = f(rows(a),cols(b));
            end
        end
    end
    hog = hog3d(vox./255, xGrid, yGrid, tGrid);
    hog = reshape(hog,[1,xGrid*yGrid*tGrid*20]);
    desc(pos,:) = hog;
    pos = pos + 1;
    
    %Save periodically in case process is interrupted
    if mod(d,4000)==0
        save(strcat(save_path,fname(1:7),'_hog_features_so_far.mat'),'desc','-v7.3');
        disp('Features saved');
    end
end
end