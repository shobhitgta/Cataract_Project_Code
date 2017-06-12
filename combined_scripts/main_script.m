
%  ================ SET PARAMETERS =================

% hof_param and hog_param: 
%    1st row = block size in pixels
%    2nd row = number of blocks in volume
%    3rd row = first element is no of bins 
hof_param = [6 6 6;3 3 2;5 0 0];
hog_param = [3 3;6 3;4 0];
% number of principal components
hog_pca = 72;
hof_pca = 90;
%cluster_size
nclus = 4000;
%svm parameters :
%    kernel : 0 -> Linear, 2-> RBF
%    C : Cost Coefficient
kernel = 0;
C = 1;

%  ==================================================

addpath(genpath(['F:\Cataract_Project\bow_code\']));
addpath(genpath(['F:\Cataract_Project\hof\']));
addpath(genpath(['F:\Cataract_Project\hog\']));
addpath(genpath(['F:\Cataract_Project\HOG3D\']));
addpath(genpath(['F:\Cataract_Project\combined_scripts\']));
addpath(genpath(['F:\Cataract_Project\pca\']));
addpath(genpath(['F:\Cataract_Project\STIP\']));
addpath(genpath(['F:\Cataract_Project\svm\']));
    
cataract_project_pt1_train(hog_param, hof_param, hog_pca, hof_pca);
cataract_project_pt2(nclus);
svm(kernel, C, nclus);










%{
vid_path = 'F:\Cataract_Project\bow\';
data_path = 'F:\Cataract_Project\svm_result\';

% SVM
for i = 1:7
    vid_path_train = strcat(vid_path,'fold', num2str(i),'\train\bow_fused.mat');
    vid_path_test = strcat(vid_path,'fold', num2str(i),'\test\bow_fused.mat');
    data_train = load(vid_path_train);
    data_train = data_train.fused_bow;
    data_test = load(vid_path_test);
    data_test = data_test.fused_bow;
    training_instance_matrix = zeros(length(data_train),2*nclus);
    training_label_vector = zeros(length(data_train), 1);
    testing_instance_matrix = zeros(length(data_test),2*nclus);
    testing_label_vector = zeros(length(data_test), 1);
    for k=1:length(data_train)
        training_label_vector(k,1) = data_train{k}{2};
        training_instance_matrix(k,:) = data_train{k}{1}(:,1);
    end
    for k = 1:length(data_test)
        testing_label_vector(k,1) = data_test{k}{2};
        testing_instance_matrix(k,:) = data_test{k}{1}(:,1);
    end
    model = svmtrain(training_label_vector, training_instance_matrix);
    [predicted_label, accuracy, decision_values] = svmpredict(testing_label_vector, testing_instance_matrix, model);
    
    filename = strcat('fold', num2str(i),'_result.mat');
    save(fullfile(data_path,[filename]),'predicted_label', 'accuracy', '-v7.3');
end

%}