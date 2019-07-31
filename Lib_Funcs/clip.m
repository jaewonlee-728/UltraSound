function [ clippedVolume ] = clip( Volume, threshold )
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here

clippedVolume = Volume;
index = find(Volume < threshold);
clippedVolume(index) = 0;

end