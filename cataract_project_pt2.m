% Computes codebook and calculates bow from HOG3D features for training and
% testing videos
 
path = 'F:\CataractProjectCode\Output\';
training_path = 'F:\CataractProjectCode\Output\features\pca';
test_path = 'F:\CataractProjectCode\Output\Test\features\pca';
training_save_path = 'F:\CataractProjectCode\Output\features\training_bow';
test_save_path = 'F:\CataractProjectCode\Output\Test\features\test_bow';

[train_feat, train_feat_cell, train_labels] = read_features(training_path);

nclus = 5000;
disp('Computing clusters...');
[~,centers] = kmeans(train_feat,nclus);
centers = centers';
save(fullfile(path,['codebook.mat']), 'centers');


disp('Computing bow for training videos...');
train_bow = compute_bow(train_feat_cell,train_labels,centers, training_save_path, 0);

disp('Computing bow for testing videos...');
[test_feat,test_feat_cell, test_labels] = read_features(test_path);
test_bow = compute_bow(test_feat_cell,test_labels,centers, test_save_path, 1);
