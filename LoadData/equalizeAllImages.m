function [ eqIm ] = equalizeAllImages( images )
%EQUALIZEALLIMAGES Summary of this function goes here
%   Detailed explanation goes here

n = length(images);

for i = 1:n
    eqIm{i} = equalizeImage( images{i} );
end

end

