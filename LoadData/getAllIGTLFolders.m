function [ igtlSet, imageData ] = getAllIGTLFolders( folder )
%GETALLIGTLFOLDERS Summary of this function goes here
%   Detailed explanation goes here

listing = dir(folder);

isub = [listing(:).isdir]; %# returns logical vector
nameFolds = {listing(isub).name}';
start = 3;

for i = start:length(nameFolds)
    subFolder = [folder '\' nameFolds{i}];
    
    [ igtlSet{i-start+1}, imageData{i-start+1} ] = getAllIGTL( subFolder );
end

end

