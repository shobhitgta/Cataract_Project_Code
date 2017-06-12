function import_idt (file, tra_len)
% import_idt: matlab interface of importing idt features from binary files
% Input:
%       file: the name of iDT features
%       tra_len: the length of improved trajectories (default: 15)
% Output:
%       feature:  imported idt features

    fid = fopen(file,'rb');
    feat = fread(fid,[10+4*tra_len+96*3+108,inf],'float');
	feature = struct('info',[],'tra',[],'tra_shape',[],'hog',[],'hof',[],'mbhx',[],'mbhy',[]);
	if ~isempty(feat)
		feature.info = feat(1:10,:);
		feature.tra = feat(11:10+tra_len*2,:);
                feature.tra_shape = feat(11+tra_len*2:10+tra_len*4,:);
                ind = 10+tra_len*4;
		feature.hog = feat(ind+1:ind+96,:);
        hog = feature.hog;
		feature.hof = feat(ind+97:ind+204,:);
        hof = feature.hof;
		feature.mbhx = feat(ind+205:ind+300,:);
        mbhx = feature.mbhx;
		feature.mbhy = feat(ind+301:end,:);
        mbhy = feature.mbhy;
        filename = strcat(file(1:7),'.mat');
        data_path = '/home/shobhit/dev/Cataract_Project/IDT/features';
        save(fullfile(data_path,'hog',[filename]),'hog', '-v7.3');
        save(fullfile(data_path,'hof',[filename]),'hof', '-v7.3');
        save(fullfile(data_path,'mbhx',[filename]),'mbhx','-v7.3');
        save(fullfile(data_path,'mbhy',[filename]),'mbhy','-v7.3');
	end
    fclose(fid);
end
