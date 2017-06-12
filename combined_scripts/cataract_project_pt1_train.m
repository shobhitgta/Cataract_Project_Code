function cataract_project_pt1_train(hog_param, hof_param, hog_pca, hof_pca)
    % Compute STIP features and 3D HOG descriptors for each video
    %cd ['/Users/SV/Documents/Desktop/LoS/Data/Cataract/Skill/',...
    %   'Becca_SV/CataractProjectCode/']

    vid_path = 'F:\Cataract_Project\videos';
    save_path = 'F:\Cataract_Project\BOW-STIP\features';
    ground_truth = 'F:\Cataract_Project\ground_truth\skillgt.mat';
    
    % mkdir '/Users/SV/Desktop/LoS/Data/Cataract/Skill/Becca_SV/output/features';
    % mkdir ['/Users/SV/Desktop/LoS/Data/Cataract/Skill/Becca_SV/output/',...
    %     'features/hog3d'];
    % mkdir ['/Users/SV/Desktop/LoS/Data/Cataract/Skill/Becca_SV/output/',...
    %     'features/stip'];
    % mkdir ['/Users/SV/Desktop/LoS/Data/Cataract/Skill/Becca_SV/output/',...
    %     'features/hof'];

    input = load(ground_truth);
    input = input.cvmat;
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
        number = fname(5:7);
        number = str2num(number);
        
        for i = 1:40
            if(input(i,1) == number)
                fold_number = input(i,3);
                break;
            end
        end
        
        
        vid = VideoReader(fullfile(vid_path,fname));
        disp(['Computing STIP for ' fname '...'])
        save_path_stip = strcat(save_path, '\stip\fold', num2str(fold_number));
        features = compute_STIP(vid, vox_size, max_feat);
        save(fullfile(save_path_stip,...
                [fname,'_STIP_features.mat']),'features');


        %-- HOG3D --
        %disp(['Computing HOG3D for ' fname(1:7) '...'])
        %hog3d = compute_HOG3D(vid, features, vox_size,save_path,fname);
        %save(fullfile(save_path,'features','hog3d',...
        %    [fname(1:7),'_hog3d_features.mat']),'hog3d','-v7.3');


        %-- HOGS --
        disp(['Computing HOGS for ' fname '...'])
        save_path_hog = strcat(save_path,'\hog\fold',num2str(fold_number));
        hogs = compute_HOGS(vid, features, save_path_hog,fname, hog_param);
        save(fullfile(save_path_hog,...
                [fname,'_hogs_features.mat']),'hogs','-v7.3');

        % -- HOFS --
        disp(['Computing HOFS for ' fname '...'])
        vid = load_video(vid_path,fname);
        vid = double(vid);
        save_path_hof = strcat(save_path,'\hof1\fold', num2str(fold_number));
        hofs = compute_HOFS(vid, features, save_path_hof,fname, hof_param);
        save(fullfile(save_path_hof,...
                [fname,'_hofs_features.mat']),'hofs','-v7.3');

    end

    %Reducing the Dimension of the Descriptor.
    %compute_pca(hog_pca, hof_pca, 0);
end