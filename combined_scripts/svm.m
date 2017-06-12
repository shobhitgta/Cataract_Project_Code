function svm (kernel, C, nclus)
    
    % kernel : 0 -> Linear, 2-> RBF
    % C : Cost Coefficient
    
    vid_path = 'F:\Cataract_Project\BOW-STIP\classification\';
    data_path = 'F:\Cataract_Project\BOW-STIP\svm\';
    
    for i = 1:7
        vid_path_train = strcat(vid_path,'training\fold', num2str(i),'\nclus_', num2str(nclus),'\hog-hof\bow_fused.mat');
        vid_path_test = strcat(vid_path,'testing\fold', num2str(i),'\nclus_', num2str(nclus),'\hog-hof\bow_fused.mat');
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
        model = svmtrain(training_label_vector, training_instance_matrix, ['-t ', num2str(kernel),' -c ', num2str(C)]);
        [predicted_label, accuracy, decision_values] = svmpredict(testing_label_vector, testing_instance_matrix, model);

        filename = strcat('nclus_', num2str(nclus),'\kerenl', num2str(kernel), '\hog-hof\', num2str(i),'_result.mat');
        save(fullfile(data_path,[filename]),'predicted_label', 'accuracy', '-v7.3');
    end
end