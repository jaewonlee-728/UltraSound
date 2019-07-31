% =========================================================================
%> @brief 
%>  Convert little endain to big endian of the Header information of ImageMessage 
%>  @param: Input  >> H     : Header of ImageMessage 
%>  @param: Input  >> Tm    : temporary matrix of ImageMessage
%>  @param: Output >> H_C   : Converted Header of ImageMessage
%>  @param: Output >> Tm_C  : Converted temporary matrix of ImageMessage
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
function [H_C, Tm_C] = IGTLImageMsgHeaderByteConvert(H, Tm)

[computerType, maxSize, endian] = computer;
if endian == 'L'
    H_C.version    = BYTE_SWAP_UINT16(H.version);
    H_C.type       = H.type;
    H_C.scalarType = H.scalarType;
    H_C.endian     = H.endian;
    H_C.coordinate = H.coordinate;
    H_C.dim        = BYTE_SWAP_UINT16(H.dim);
    Tm_C           = BYTE_SWAP_FLOAT32(Tm);
    H_C.sub_Off    = BYTE_SWAP_UINT16(H.sub_Off);
    H_C.sub_dim    = BYTE_SWAP_UINT16(H.sub_dim);
else
    H_C = H;
    Tm_C = Tm;
end
