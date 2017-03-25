clear;

[filename1,pathname1]=uigetfile({'*.mat','Mat file'},'Select an tempalte');
load(fullfile(pathname1,filename1));
template1=template_Final;
mask1=mask_Final;

[filename1,pathname1]=uigetfile({'*.mat','Mat file'},'Select an tempalte');
load(fullfile(pathname1,filename1));
template2=template_Final;
mask2=mask_Final;

scales=1;

hd = gethammingdistance(template1, mask1, template2, mask2, scales);
hd
