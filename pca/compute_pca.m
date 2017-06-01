function compute_pca(no_dims)

rawhogpath = ['F:\CataractProjectCode\Output\features\'];

d=dir(fullfile(rawhogpath,'hogs'));

for a = length(d):-1:1
    fname = d(a).name;
    if strcmp(fname(1), '.')
        d(a) = [];
    end
end
for i=1:length(d)
    fname = d(i).name;
    disp(['Computing pca for ' fname ' ' num2str(i)...
        '/' num2str(length(d))]);
    %clearvars 'hog3d';
    load(fullfile(rawhogpath, 'hogs' ,fname));
    feats = hogs;
    %pca_features = zeros(size(feats));
    
	[mappedX, mapping] = pca(feats,no_dims);
	
    save(fullfile(rawhogpath,'pca',[fname,...
        '_hogs_pca.mat']),'mappedX','-v7.3');
		
end