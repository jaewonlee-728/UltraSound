% =========================================================================
%> @brief 
%>  Convert little endain to big endian of input-value (float32/single)
%>  @param: Input  >> input : input value 
%>  @param: Output >> v     : Converted input value
% =========================================================================

% /***************************************************************************
% Copyright 
% MUSiiC Laboratory
% Hyun-Jae Kang,Emad M Boctor
% Johns Hopkins Medical Institutions
% Department of Radiology, Division of Medical Imaging Physics
% 
% For commercial use/licensing, please contact Emad Boctor, Ph.D. at eboctor@jhmi.edu.
% ***************************************************************************/
function [v] = BYTE_SWAP_FLOAT32(input)

input = single(input);
input = typecast(input,'uint32');
bS = typecast(input, 'uint8');
bSS = bS(end:-1:1);
v = typecast(bSS, 'uint32');
v = typecast(v,'single');
v = v(end:-1:1);
end