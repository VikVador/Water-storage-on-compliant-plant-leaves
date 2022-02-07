function get_frame(u, filename, arg)
% ------------------------------
% Personnal Experimental Project
% ------------------------------
% @ Victor Mangeleer
% @ Arnaud Remi
%
% Documentation :
% -- get_frame takes a vector 'u' of frame indexes if arg == 'f' and 
%    returns the corresponding frames in the video whose path is 'filename'
% -- get_frame takes a vector 'u' of time index if arg == 't' and returns
%    the corresponding frames in the video whose path is 'filename'
% -- Finally, get_frame creates, save and open these frames
% -- if arg is empty, it is set as 'f' as default value


% default arg value is 'f'
if nargin == 2
    arg = 'f';
end

% Creates an object vidObj that contains the informations in the video
% whose path is 'filename'
vidObj = VideoReader(filename)

% convertion between time and frames if arg == 't'
if arg == 't'
   u = round(vidObj.FrameRate * u); 
end

% creation of the corresponding images
for img = 1:length(u)
    filename2 = strcat('frame',num2str(u(img)),'.jpg');
    b = read(vidObj, u(img));
    imwrite(b,filename2);
end

% opening these images
for img = 1 : length(u)
    winopen(strcat('frame',num2str(u(img)),'.jpg'));
end

end