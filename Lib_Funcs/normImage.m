function [ image ] = normImage( image )
%NORMIMAGE Summary of this function goes here
%   Detailed explanation goes here

image = image - min(min(image));
image = image/max(max(image));

end

