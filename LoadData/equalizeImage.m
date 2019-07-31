function [ newIm ] = equalizeImage( images )
%EQUALIZEIMAGE Summary of this function goes here
%   Detailed explanation goes here

[r, c, n] = size(images);

for i = 1:n
    for j = 1:c
        newIm(:,j,i) = images(:,j,i) - mean(images(51:500,j,i));
    end
end
newIm(1:50,:,:) = 0;

end

