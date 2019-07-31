function [ igtlSet, imageDataL, imageDataR, imageDataDAQ ] = getAllIGTL( folder )
%GETALLIGTL Summary of this function goes here
%   Detailed explanation goes here

listing = dir(folder);

start = 3;
n = length(listing);

for i = start:n
    filename = [folder '\' listing(i).name];
    
    igtlSet(i-start+1) = ReadSingleIGTLMsg(filename);
    
    if mod(i-start+1,3)==1
    imageDataL(:,:,floor((i-start)/3)+1) = igtlSet(i-start+1).Body.data;
    end
    if mod(i-start+1,3)==2
    imageDataR(:,:,floor((i-start)/3)+1) = igtlSet(i-start+1).Body.data;
    end
    if mod(i-start+1,3)==0
    imageDataDAQ(:,:,floor((i-start)/3)+1) = igtlSet(i-start+1).Body.data;
    end
    
end

end

