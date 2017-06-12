function bow = compute_bow_FV(all_feat, labels, means, covariances, priors, nclus, save_path, flag)

num_vids = length(all_feat);
bow{num_vids}{2} = [];

for i=1:num_vids
	disp(['Training for video ' num2str(i) ' of ' num2str(num_vids)])
    features = all_feat{i};
    numFeatures = size(features,1);
    dimension = size(features,2);
    disp(numFeatures);
    bow{i}{1} = zeros(2*dimension*nclus,1);
    bow{i}{2} = labels{i};
    bow{i}{1} = vl_fisher(features', means, covariances, priors);
    save(fullfile(save_path,['abcd_bow.mat']),'bow');
end

if (flag == 0)
    save(fullfile(save_path,['bow_hog.mat']),'bow');
else
    save(fullfile(save_path,['bow_hof.mat']),'bow');
end    
end