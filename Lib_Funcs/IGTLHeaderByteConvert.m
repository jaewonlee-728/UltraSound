% =========================================================================
%> @brief 
%>  Convert little endain to big endian of the Header information of OpenIGTLink Message 
%>  @param: Input  >> H     : Header of OpenIGTLink Message 
%>  @param: Output >> H_C   : Converted Header of OpenIGTLink Message
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

function IGTLHeader_C = IGTLHeaderByteConvert(IGTLHeader)

[computerType, maxSize, endian] = computer;
if endian == 'L'
    IGTLHeader_C.version    = BYTE_SWAP_UINT16(IGTLHeader.version);
    IGTLHeader_C.type       = IGTLHeader.type;
    IGTLHeader_C.device     = IGTLHeader.device;
    IGTLHeader_C.ts         = BYTE_SWAP_UINT64(IGTLHeader.ts);
    IGTLHeader_C.bodysize   = BYTE_SWAP_UINT64(IGTLHeader.bodysize);
    IGTLHeader_C.crc        = BYTE_SWAP_UINT64(IGTLHeader.crc); 
else
   IGTLHeader_C = IGTLHeader; 
end

end