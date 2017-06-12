function vid = load_video(vid_path,fname) 
    vid = VideoReader(fullfile(vid_path,fname));
    data = read(vid, Inf);
    for f = 1:vid.NumberofFrames
        J = rgb2gray(read(vid,f));   % CONVERT COLOR TO GRAY
        gFrames(:,:,f) = J(:,:);                     % GRAY FRAMES
    end
    clear vid;
    vid = gFrames;
    clear gFrames;
end