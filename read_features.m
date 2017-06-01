function [all_feat, labels] = read_features(path)

d = dir(path);
for a = length(d):-1:1
    fname = d(a).name;
    if fname(1) == '.'
        d(a) = [];
    end
end

feat = cell(length(d_train),1);
labels = cell(length(d_train),1);

disp('Reading data...');
for i=1:length(d_train)
    disp(['Video ' num2str(i) ' of ' num2str(length(d_train))]);
    fname=d_train(i).name;
    features = load(strcat(path,fname));
    features = features.pca_features;
    feat{i} = features;
    
    f = str2double(fname(5:7));
    if (f >= 133) || (f == 8)
        labels{i} = 0; %expert
%     elseif (f == 15) || (f >= 114)
%         labels{i} = 3; %novice
    else
%         labels{i} = 4; %novice
        labels{i} = 1; %novice
    end
end

disp('Converting to matrix...');
all_feat = cell2mat(feat);