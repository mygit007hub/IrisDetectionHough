[filename,pathname]=uigetfile({'*.bmp','image'},'Select an image');
[template_Final, mask_Final] = createiristemplate(fullfile(pathname,filename));

% [template_Final, mask_Final] = createiristemplate('1.bmp');
savefile = [fullfile(pathname,filename),'-template.mat'];
save(savefile, 'template_Final', 'mask_Final')
%save('template.mat');


