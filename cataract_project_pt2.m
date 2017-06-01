%Reducing the Dimension of the Descriptor.

% -- HOGS -- 
compute_pca(40);


% Computes codebook and calculates bow from HOG3D features for training and
% testing videos
 
%path = '/media/Seagate Backup Plus Drive/cataract/features/';
%training_path = '/media/Seagate Backup Plus Drive/cataract/features/training/pca/';
%test_path = '/media/Seagate Backup Plus Drive/cataract/features/testing/pca/';
%training_save_path = '/media/Seagate Backup Plus Drive/cataract/features/testing/bow/';
%test_save_path = '/media/Seagate Backup Plus Drive/cataract/features/testing/bow/';

%[train_feat, train_labels] = read_features(training_path);

%nclus = 5000;
%clear
%disp('Computing clusters...');
%[centers,~] = vl_kmeans(train_feat',nclus);
%save(strcat(path,'codebook.mat'), 'centers');

%{
disp('Computing bow for training videos...');
train_bow = compute_bow(train_feat,train_labels,centers, training_save_path);

[test_feat, test_labels] = read_features(test_path);

disp('Computing bow for testing videos...');
test_bow = compute_bow(test_feat,test_labels,centers, test_save_path);
%}