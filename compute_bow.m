function bow = compute_bow(all_feat, labels, centers, save_path,flag)

if(flag == 0)
	vid_path = 'F:\CataractProjectCode\Videos_Train\';
else if (flag == 1)
	vid_path = 'F:\CataractProjectCode\Videos_Test\';

d=dir(vid_path);
num_vids = length(all_feat);
bow{num_vids}{2} = [];

for i=1:num_vids
	fname=d(i).name;
    disp(['Training for video ' num2str(i) ' of ' num2str(num_vids)])
    features = all_feat{i};
    numFeatures = size(features,1);
    disp(numFeatures);
    bow{i}{1} = zeros(size(centers,2),1);
    bow{i}{2} = labels{i};
    for j=1:numFeatures
        if( mod(j,50) == 0 )
            disp('Ho rha hai');
        end
        minVal = realmax;
        for k = 1:size(centers,2)
            dist = pdist2(double(features(j,:)), double(centers(:,k))');
            if dist < minVal
                minVal = dist;
                index = k;
            end
        end
        bow{i}{1}(index) = (bow{i}{1}(index))+1;
    end
    bow{i}{1} = bow{i}{1}/numFeatures;
    save(fullfile(save_path,[fname,'_bow.mat']),'bow');
end

end