function fused_bow = save_bow( bow_hog, bow_hof,save_path)
    l1 = length(bow_hog);
    l2 = length(bow_hof);
    fused_bow{l1}{2} = [];
    for i = 1 : l1
        if (bow_hog{i}{2} ~= bow_hof{i}{2})
            disp("Error save_bow.m");
            exit;
        end
        fused_bow{i}{1} = [bow_hog{i}{1}; bow_hof{i}{1}];
        fused_bow{i}{2} = bow_hog{i}{2};
    end
    save(fullfile(save_path,['bow_fused.mat']),'fused_bow');
end