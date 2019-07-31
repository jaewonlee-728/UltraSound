function [ combIm ] = combineImages( images, num )
%COMBINEIMAGES Summary of this function goes here
%   Detailed explanation goes here

n = length(images);

for i = 1:n
    images{i}(:,:,end+1) = 0;
    for j = 1:num
        combIm{i}(:,:,j) = images{i}(:,:,j) + images{i}(:,:,2*num-j+1);
    end
end

end

