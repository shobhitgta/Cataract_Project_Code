function cataract_project_pt2_FV(nclus)
    
    % Computes codebook and calculates bow from features for training and
    % testing videos

    path = 'F:\Cataract_Project\BOW-STIP\classification\training';
    training_path_hog = 'F:\Cataract_Project\BOW-STIP\features\hog';
    training_path_hof = 'F:\Cataract_Project\BOW-STIP\features\hof1';
    training_save_path = 'F:\Cataract_Project\BOW-STIP\classification\training';
    testing_save_path = 'F:\Cataract_Project\BOW-STIP\classification\testing';
    
    for i=1:7

        [train_feat_hog, train_feat_cell_hog, train_labels_hog] = read_features(training_path_hog,i,0,1);
        [train_feat_hof, train_feat_cell_hof, train_labels_hof] = read_features(training_path_hof,i,0,0);
        
        path_fold = strcat(path,'\fold',num2str(i),'\nclus_', num2str(nclus));
        disp('Computing clusters for hogs...');
        [means_hog, covariances_hog, priors_hog] = vl_gmm(train_feat_hog',nclus);
        
        disp('Computing clusters for hofs...');
        [means_hof, covariances_hof, priors_hof] = vl_gmm(train_feat_hof',nclus);
        
        training_save_path_fold = strcat(training_save_path, '\fold', num2str(i),'\nclus_', num2str(nclus),'\hog');
        disp('Computing hog bow for training videos...');
        train_bow_hog = compute_bow_FV(train_feat_cell_hog,train_labels_hog,means_hog, covariances_hog, priors_hog, nclus, training_save_path_fold, 0);
        disp('Computing hof bow for training videos...');
        training_save_path_fold = strcat(training_save_path, '\fold', num2str(i),'\nclus_', num2str(nclus),'\hof1');
        train_bow_hof = compute_bow_FV(train_feat_cell_hof,train_labels_hof,means_hof, covariances_hof, priors_hof, nclus, training_save_path_fold, 1);
        training_save_path_fold = strcat(training_save_path, '\fold', num2str(i),'\nclus_', num2str(nclus),'\hog-hof');
        %fused_bow = save_bow(train_bow_hog, train_bow_hof, training_save_path_fold);

        disp('Computing bow for testing videos...');
        [test_feat_hog,test_feat_cell_hog, test_labels_hog] = read_features(training_path_hog, i, 1, 1);
        [test_feat_hof,test_feat_cell_hof, test_labels_hof] = read_features(training_path_hof, i, 1, 0);
        test_save_path_fold = strcat(testing_save_path, '\fold', num2str(i),'\nclus_', num2str(nclus),'\hog');    
        disp('Computing hog bow for testing videos...');
        test_bow_hog = compute_bow(test_feat_cell_hog,test_labels_hog,means_hog, covariances_hog, priors_hog, nclus,  test_save_path_fold, 0);
        disp('Computing hof bow for testing videos...');
        test_save_path_fold = strcat(testing_save_path, '\fold', num2str(i),'\nclus_', num2str(nclus),'\hof1');    
        test_bow_hof = compute_bow(test_feat_cell_hof,test_labels_hof,means_hof, covariances_hof, priors_hof, nclus,  test_save_path_fold, 1);
        test_save_path_fold = strcat(testing_save_path, '\fold', num2str(i),'\nclus_', num2str(nclus),'\hog-hof');    
        %fused_bow_test = save_bow(test_bow_hog, test_bow_hof, test_save_path_fold);
    end
end