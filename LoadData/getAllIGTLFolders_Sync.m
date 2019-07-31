function [ igtlSet, imageDataL, imageDataR, imageDataDAQ ] = getAllIGTLFolders_Sync( folder )
%GETALLIGTLFOLDERS Summary of this function goes here
%   Detailed explanation goes here

listing = dir(folder);

isub = [listing(:).isdir]; %# returns logical vector
nameFolds = {listing(isub).name}';
start = 3;

for i = start:length(nameFolds)
    subFolder = [folder '\' nameFolds{i}];
    
    [ igtlSet{i-start+1}, imageDataL{i-start+1},imageDataR{i-start+1},imageDataDAQ{i-start+1} ] = getAllIGTL_DAQCAM( subFolder );
end

end

