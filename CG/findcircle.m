% findcircle - returns the coordinates of a circle in an image using the Hough transform
% and Canny edge detection to create the edge map.
%
% Usage: 
% [row, col, r] = findcircle(image,lradius,uradius,scaling, sigma, hithres, lowthres, vert, horz)
%
% Arguments:
%	image		    - the image in which to find circles
%	lradius		    - lower radius to search for
%	uradius		    - upper radius to search for
%	scaling		    - scaling factor for speeding up the Hough transform
%	sigma		    - amount of Gaussian smoothing to apply for creating edge map.
%	hithres		    - threshold for creating edge map
%	lowthres	    - threshold for connected edges
%	vert		    - vertical edge contribution (0-1)
%	horz		    - horizontal edge contribution (0-1)
%	
% Output:
%	circleiris	    - centre coordinates and radius of the detected iris boundary
%	circlepupil	    - centre coordinates and radius of the detected pupil boundary
%	imagewithnoise	- original eye image, but with location of noise marked with
%			          NaN values
%

function [row, col, r] = findcircle(image,lradius,uradius,scaling, sigma, hithres, lowthres, vert, horz)

lradsc = round(lradius*scaling);
uradsc = round(uradius*scaling);
rd = round(uradius*scaling - lradius*scaling);

% generate the edge image
[I2 or] = canny(image, sigma, scaling, vert, horz);     % canny function for edgemap
I3 = adjgamma(I2, 1.9);                                 % to adjust gamma portion i.e to enhance the contrast
I4 = nonmaxsup(I3, or, 1.5);                            % for performing non-maxima suppression on an image using an orientation image, 
%figure, imshow(I4);title('aa');

edgeimage = hysthresh(I4, hithres, lowthres);           % For edge marking
%figure,imshow(edgeimage);

% perform the circular Hough transform
h = houghcircle(edgeimage, lradsc, uradsc);

maxtotal = 0;

% find the maximum in the Hough space, and hence the parameters of the circle
for i=1:rd
    
    layer = h(:,:,i);
    [maxlayer] = max(max(layer));
    
    
    if maxlayer > maxtotal
        
        maxtotal = maxlayer;
        
        
        r = int32((lradsc+i) / scaling);
        
        [row,col] = ( find(layer == maxlayer) );
        
        
        row = int32(row(1) / scaling); % returns only first max value
        col = int32(col(1) / scaling);    
        
    end
    
    
end