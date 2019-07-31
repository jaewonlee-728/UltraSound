% =========================================================================
%> @brief 
%>  Convert little endain to big endian of input-value (double)
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
function [v] = BYTE_SWAP_DOUBLE(input)
input = double(input);
bS = typecast(input, 'int8');
bSS = bS(end:-1:1);
v = typecast(bSS, 'double');
v = v(end:-1:1);
end