% =========================================================================
%> @brief 
%>  function IGTLHeader =  UnPackIGTLHeader(buf)
%>  Retrieve a Header information of OpenIGTLink Message from binary buffer.
%>  @param: Input  >> buf : binary data buffer based on uint8
%>  @param: Output >> IGTLHeader : Header information of OpenIGTLink Message
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

function IGTLHeader =  UnPackIGTLHeader(buf)

IGTLHeader.version  = typecast(uint8(buf(1:2)), 'uint16');
IGTLHeader.type     = deblank(char(buf(3:14))');
IGTLHeader.device   = deblank(char(buf(15:34))');
IGTLHeader.ts       = typecast(uint8(buf(35:42)), 'uint64');
IGTLHeader.bodysize = typecast(uint8(buf(43:50)), 'uint64');
IGTLHeader.crc      = typecast(uint8(buf(51:58)), 'uint64');

IGTLHeader          = IGTLHeaderByteConvert(IGTLHeader);
end