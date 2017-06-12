function hofs = compute_HOFS(vid,features,save_path,fname, hof_param)
    
    blockSize = hof_param(1,:); 
    numBlocks = hof_param(2,:); 
    numOr = hof_param(3,1); 
    flowMethod = 'Horn-Schunck'; 
       
    curr_frame = 0;
    num = size(features,1);
    len = numBlocks(1,1)*numBlocks(1,2)*numBlocks(1,3)*numOr;
    hofs = zeros(num,len);
    
    for z = 1:num
        f = features(z,1);
        if mod(z,4000) == 0
            disp(['HOFS for feature ' num2str(z) ' of ' num2str(num)])
        end
        
        if f ~= curr_frame
            curr_frame = f;
        end
        
        point = features(z,2:3);
        
        blockSize = [6 6 6]; 
        numBlocks = [3 3 2]; 
        numOr = 5; 
        flowMethod = 'Horn-Schunck'; 
        
        xlimit = size(vid,1);
        ylimit = size(vid,2);
        flimit = size(vid,3) - 1;
        
        xstart = (point(1,2) - floor((blockSize(1,1)*numBlocks(1,1))/2)); 
        xend = (point(1,2) + ceil((blockSize(1,1)*numBlocks(1,1))/2) - 1); 
        
        if(xstart < 1 || xend > xlimit)
            if(z == 1)
                disp("here1");
            end
            continue;
        end
        
        ystart = (point(1,1) - floor((blockSize(1,2)*numBlocks(1,2))/2)); 
        yend = (point(1,1) + ceil((blockSize(1,2)*numBlocks(1,2))/2) - 1); 
        
        if(ystart < 1 || yend > ylimit)
            if(z == 1)
                disp("here2");
            end
            continue;
        end
        
        fstart = f - floor((blockSize(1,3)*numBlocks(1,3) + 1)/2); 
        fend = f + floor((blockSize(1,3)*numBlocks(1,3) + 1)/2);
        
        if(fstart < 1 || fend > flimit)
            if(z == 1)
                disp("here3");
            end
            continue;
        end
        
        sampledVid = vid(xstart:xend, ystart:yend, fstart:fend);
        
        [hofsframe, ~] = ...
        Video2DenseHOFVolumes(sampledVid, blockSize, numBlocks, numOr, flowMethod);
        %hofsframe = extractHOGFeatures(frames,point,'CellSize',[3 3],...
        %            'BlockSize',[2 2],'NumBins',4,...
        %            'UseSignedOrientation',true);
        hofs(z,:) = hofsframe;
        
         %Save periodically in case process is interrupted
        if mod(z,4000)==0
            save(fullfile(save_path,[fname,...
                '_hofs_so_far.mat']),'hofs','-v7.3');
            disp('Features saved');
        end
    end
    
    % Removing any zero rows
    hofs = hofs(any(hofs,2),:);
end