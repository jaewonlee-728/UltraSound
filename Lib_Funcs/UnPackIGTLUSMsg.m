% =========================================================================
%> @brief 
%>  function USMsg = UnPackIGTLUSMsg(buf)
%>  Retrieve USMessage of OpenIGTLinkMUSiiC from binary data-buffer 
%>  @param: Input  >> buf   : binary data buffer based on uint8
%>  @param: Output >> USMsg : USMessage of OpenIGTLinkMUSiiC
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

function USMsg = UnPackIGTLUSMsg(buf)

% Version Number of ImageMessage
USMsg.h.version    = typecast(uint8(buf(1:2)), 'uint16');

% Data-Type of Image Data
% 1: Scalar
% 2: Vector
USMsg.h.type       = buf(3);

% Scalar-Type of Image Data
%  2: int8
%  3: uint8
%  4: int16
%  5: uint16
%  6: int32
%  7: uint32
% 10: float32 (matlab:single)
% 11: float64 (matlab:double)
USMsg.h.scalarType = buf(4);

% Endian for Image Data
% 1: BIG Endian
% 2: Little Endian
USMsg.h.endian     = buf(5);

% Coordinate System of Image Data
% 1: RAS
% 2: LPS
USMsg.h.coordinate = buf(6);

% Dimension of Image Data
USMsg.h.dim        = typecast(uint8(buf(7:12)), 'uint16');

% Get Temp-Matrix value
mat                 = typecast(uint8(buf(13:60)), 'single');

% Retrieve subspace_offset and subspace_dimension
% The offset of sub-volume
USMsg.h.sub_Off    = typecast(uint8(buf(61:66)), 'uint16');
% The dimension of sub-volume
USMsg.h.sub_dim    = typecast(uint8(buf(67:72)), 'uint16');

% Byte_Convert
[USMsg.h, mat]     = IGTLImageMsgHeaderByteConvert(USMsg.h, mat);

% Get Matrix and spacing
[USMsg.h.matrix, USMsg.h.spacing] = GetIGTLImageMatrix(mat);

% Retrieve image data
img_sz = double(USMsg.h.sub_dim);
dt_sz = prod(img_sz);
% Buffer Size;
buf_sz = size(buf);
buf_sz = prod(buf_sz);


if USMsg.h.scalarType == 2         %  2: int8
    data_end  = uint32(dt_sz + 72);
    USMsg.data = typecast(uint8(buf(73:data_end)), 'int8');
elseif USMsg.h.scalarType == 3     %  3: uint8
    data_end  = uint32(dt_sz + 72);
    USMsg.data = typecast(uint8(buf(73:data_end)), 'uint8');
elseif USMsg.h.scalarType == 4     %  4: int16
    data_end  = uint32(dt_sz*2 + 72);
    USMsg.data = typecast(uint8(buf(73:data_end)), 'int16');
elseif USMsg.h.scalarType == 5     %  5: uint16
    data_end  = uint32(dt_sz*2 + 72);
    USMsg.data = typecast(uint8(buf(73:data_end)), 'uint16');
elseif USMsg.h.scalarType == 6     %  6: int32
    data_end  = uint32(dt_sz*4 + 72);
    USMsg.data = typecast(uint8(buf(73:data_end)), 'int32');
elseif USMsg.h.scalarType == 7     %  7: uint32
    data_end  = uint32(dt_sz*4 + 72);
    USMsg.data = typecast(uint8(buf(73:data_end)), 'uint32');
elseif USMsg.h.scalarType == 10    % 10: float32 (matlab:single)
    data_end  = uint32(dt_sz*4 + 72);
    USMsg.data = typecast(uint8(buf(73:data_end)), 'single');
elseif USMsg.h.scalarType == 11    % 11: float64 (matlab:double)
    data_end  = uint32(dt_sz*8 + 72);
    USMsg.data = typecast(uint8(buf(73:data_end)), 'double');
end
    
% check image data
data_sz = size(USMsg.data);

diff = buf_sz - data_end;

% Get Ultrasound Data
if(prod(data_sz) == dt_sz)
    USMsg.data = reshape(USMsg.data, USMsg.h.sub_dim(2),USMsg.h.sub_dim(1),USMsg.h.sub_dim(3));
else
    disp('Error');
    USMsg.data = zeros(USMsg.h.sub_dim(1),USMsg.h.sub_dim(2),USMsg.h.sub_dim(3));
end

USMsg.uh = GetUSMsgHeader(uint8(buf(data_end+1:end)));

end