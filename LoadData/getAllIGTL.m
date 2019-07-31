function [ igtlSet, imageData ] = getAllIGTL( folder )
%GETALLIGTL Summary of this function goes here
%   Detailed explanation goes here

listing = dir(folder);

start = 3;
n = length(listing);

for i = start:n
    filename = [folder '\' listing(i).name];
    
    igtlSet(i-start+1) = ReadSingleIGTLMsg(filename);
    
    imageData(:,:,i-start+1) = igtlSet(i-start+1).Body.data;
end

end

