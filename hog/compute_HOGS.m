function hogs = compute_HOGS(vid,features,save_path,fname, hog_param)
    
    blockSize = hog_param(1,:); 
    numBlocks = hog_param(2,:); 
    numOr = hog_param(3,1); 
    flowMethod = 'Horn-Schunck';
    
    len = numBlocks(1,1)*numBlocks(1,2)*numOr;
    curr_frame = 0;
    num = size(features,1);
    hogs = zeros(num,len);
    
    for d = 1:num
        f = features(d,1);
        if mod(d,4000) == 0
            disp(['HOGS for feature ' num2str(d) ' of ' num2str(num)])
        end
        
        if f ~= curr_frame
            frames = il_rgb2gray(double(read(vid,f)));
            curr_frame = f;
        end
        
        point = features(d,2:3);
        
        hogsframe = extractHOGFeatures(frames,point,'CellSize',blockSize,...
                    'BlockSize',numBlocks,'NumBins',numOr,...
                    'UseSignedOrientation',true);
        hogs(d,:) = hogsframe;
        
         %Save periodically in case process is interrupted
        if mod(d,4000)==0
            save(fullfile(save_path,[fname,...
                '_hogs_so_far.mat']),'hogs','-v7.3');
            disp('Features saved');
        end
    end
end