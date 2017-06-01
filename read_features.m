function [all_feat, all_feat_cell, labels] = read_features(path)

d_train = dir(path);
for a = length(d_train):-1:1
    fname = d_train(a).name;
    if fname(1) == '.'
        d_train(a) = [];
    end
end

feat = cell(length(d_train),1);
labels = cell(length(d_train),1);

disp('Reading data...');
for i=1:length(d_train)
    disp(['Video ' num2str(i) ' of ' num2str(length(d_train))]);
    fname=d_train(i).name;
    features_video = load(fullfile(path,fname));
    features_video = features_video.mappedX;
    feat{i} = features_video;
    
	% -- Temporary code -- 
	f = fname(1:5);
    if (f == "v_bik")
        labels{i} = 0; %biking	
	elseif (f == "v_sho")
	     labels{i} = 1; %novice
    elseif (f == "v_spi")
	     labels{i} = 2; %novice
    else
		disp("ERROR");
		exit;
    end
	
	
	% -- Change this code according to actual dataset --
    
	%f = str2double(fname(5:7));
    %if (f >= 133) || (f == 8)
    %    labels{i} = 0; %expert	
	%elseif (f == 15) || (f >= 114)
	%     labels{i} = 3; %novice
    %else
	%    labels{i} = 4; %novice
    %    labels{i} = 1; %novice
    %end
	
	
end

disp('Converting to matrix...');
all_feat_cell = feat;
all_feat = cell2mat(feat);