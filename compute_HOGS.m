function hogs = compute_HOGS(vid,features,save_path,fname)
    
    curr_frame = 0;
    num = size(features,1);
    hogs = zeros(num,72);
    
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
        
        hogsframe = extractHOGFeatures(frames,point,'CellSize',[3 3],...
                    'BlockSize',[6 3],'NumBins',4,...
                    'UseSignedOrientation',true);
        hogs(d,:) = hogsframe;
        
         %Save periodically in case process is interrupted
        if mod(d,4000)==0
            save(fullfile(save_path,'features','hog72',[fname(1:7),...
                '_hogs_so_far.mat']),'hogs','-v7.3');
            disp('Features saved');
        end
    end
end