function [all_feat, all_feat_cell, labels] = read_features(path,k, flag, hog_flag)
    if (flag == 0)
        for z = 1:7
            if ( z == k )
                continue;
            end
            path_fold = strcat(path,'\fold',num2str(z),'\');
            d_train = dir(path_fold);
            for a = length(d_train):-1:1
                fname = d_train(a).name;
                if fname(1) == '.'
                    d_train(a) = [];
                end
            end

            feat = cell(length(d_train),1);
            labels_temp = cell(length(d_train),1);

            disp('Reading data...');
            for i=1:length(d_train)
                disp(['Video ' num2str(i) ' of ' num2str(length(d_train))]);
                fname=d_train(i).name;
                features_video = load(fullfile(path_fold,fname));
                if(hog_flag == 1)
                    features_video = features_video.hogs;
                else
                    features_video = features_video.hofs;
                end
                feat{i} = features_video;

                f = str2double(fname(5:7));
                if (f >= 133) || (f == 8)
                    labels_temp{i} = 0; %expert	
                elseif (f == 15) || (f >= 114) || (f == 14)
                     labels_temp{i} = 1; %novice
                else
                    labels_temp{i} = 1; %novice
                end


            end
            if(z == 1 || (k == 1 && z == 2))
                all_feat_cell = feat;
                %all_feat = cell2mat(feat);
                labels = labels_temp;
            else
                all_feat_cell = [all_feat_cell; feat];
                %all_feat = cell2mat(feat);
                labels = [labels; labels_temp];
            end
        end
        all_feat = cell2mat(all_feat_cell);
    else
        path_fold = strcat(path,'\fold',num2str(k),'\');
            d_train = dir(path_fold);
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
                features_video = load(fullfile(path_fold,fname));
                if(hog_flag == 1)
                    features_video = features_video.hogs;
                else
                    features_video = features_video.hofs;
                end
                feat{i} = features_video;

                f = str2double(fname(5:7));
                if (f >= 133) || (f == 8)
                    labels{i} = 0; %expert	
                elseif (f == 15) || (f >= 114) || (f == 14)
                     labels{i} = 3; %novice
                else
                    labels{i} = 4; %novice
                end


            end

            disp('Converting to matrix...');
            all_feat_cell = feat;
            all_feat = cell2mat(feat);
        end
end
