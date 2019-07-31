% =========================================================================
%> @brief 
%>  function IMGMsg = UnPackIGTLImageMsg(buf)
%>  Retrieve OpenIGTLink ImageMessage from binary data-buffer 
%>  @param: Input  >> buf : binary data buffer based on uint8
%>  @param: Output >> IMGMsg : OpenIGTLink ImageMessage
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

function IMGMsg = UnPackIGTLImageMsg(buf)

% Version Number of ImageMessage
IMGMsg.h.version    = typecast(uint8(buf(1:2)), 'uint16');

% Data-Type of Image Data
% 1: Scalar
% 2: Vector
IMGMsg.h.type       = buf(3);

% Scalar-Type of Image Data
%  2: int8
%  3: uint8
%  4: int16
%  5: uint16
%  6: int32
%  7: uint32
% 10: float32 (matlab:single)
% 11: float64 (matlab:double)
IMGMsg.h.scalarType = buf(4);

% Endian for Image Data
% 1: BIG Endian
% 2: Little Endian
IMGMsg.h.endian     = buf(5);

% Coordinate System of Image Data
% 1: RAS
% 2: LPS
IMGMsg.h.coordinate = buf(6);

% Dimension of Image Data
IMGMsg.h.dim        = typecast(uint8(buf(7:12)), 'uint16');

% Get Temp-Matrix value
mat                 = typecast(uint8(buf(13:60)), 'single');

% Retrieve subspace_offset and subspace_dimension
% The offset of sub-volume
IMGMsg.h.sub_Off    = typecast(uint8(buf(61:66)), 'uint16');
% The dimension of sub-volume
IMGMsg.h.sub_dim    = typecast(uint8(buf(67:72)), 'uint16');

% Byte_Convert
[IMGMsg.h, mat]     = IGTLImageMsgHeaderByteConvert(IMGMsg.h, mat);

% Get Matrix and spacing
[IMGMsg.h.matrix, IMGMsg.h.spacing] = GetIGTLImageMatrix(mat);

% Retrieve image data
% 
% if IMGMsg.h.scalarType == 2         %  2: int8
%     IMGMsg.data = typecast((buf(73:end)), 'int8');
% elseif IMGMsg.h.scalarType == 3     %  3: uint8
%     IMGMsg.data = typecast((buf(73:end)), 'uint8');
% elseif IMGMsg.h.scalarType == 4     %  4: int16
%     IMGMsg.data = typecast((buf(73:end)), 'int16');
% elseif IMGMsg.h.scalarType == 5     %  5: uint16
%     IMGMsg.data = typecast((buf(73:end)), 'uint16');
% elseif IMGMsg.h.scalarType == 6     %  6: int32
%     IMGMsg.data = typecast((buf(73:end)), 'int32');
% elseif IMGMsg.h.scalarType == 7     %  7: uint32
%     IMGMsg.data = typecast((buf(73:end)), 'uint32');
% elseif IMGMsg.h.scalarType == 10    % 10: float32 (matlab:single)
%     IMGMsg.data = typecast((buf(73:end)), 'single');
% elseif IMGMsg.h.scalarType == 11    % 11: float64 (matlab:double)
%     IMGMsg.data = typecast((buf(73:end)), 'double');
% end

bImg = false;
if IMGMsg.h.scalarType == 2         %  2: int8
    IMGMsg.data = typecast(uint8(buf(73:end)), 'int8');
    disp(' Data type int8');
elseif IMGMsg.h.scalarType == 3     %  3: uint8
    IMGMsg.data = typecast(uint8(buf(73:end)), 'uint8');
    bImg = true;
    disp(' Data type uint8');
elseif IMGMsg.h.scalarType == 4     %  4: int16
    IMGMsg.data = typecast(uint8(buf(73:end)), 'int16');
    disp(' Data type int16');
elseif IMGMsg.h.scalarType == 5     %  5: uint16
    IMGMsg.data = typecast(uint8(buf(73:end)), 'uint16');
    disp(' Data type uint16');
elseif IMGMsg.h.scalarType == 6     %  6: int32
    IMGMsg.data = typecast(uint8(buf(73:end)), 'int32');
    disp(' Data type int32');
elseif IMGMsg.h.scalarType == 7     %  7: uint32
    IMGMsg.data = typecast(uint8(buf(73:end)), 'uint32');
    disp(' Data type uint32');
elseif IMGMsg.h.scalarType == 10    % 10: float32 (matlab:single)
    IMGMsg.data = typecast(uint8(buf(73:end)), 'single');
    disp(' Data type single');
elseif IMGMsg.h.scalarType == 11    % 11: float64 (matlab:double)
    IMGMsg.data = typecast(uint8(buf(73:end)), 'double');
    disp(' Data type double');
end
    
% check image data
data_sz = size(IMGMsg.data);
img_sz = double(IMGMsg.h.sub_dim);
% if(prod(data_sz) == prod(img_sz))
%     IMGMsg.data = reshape(IMGMsg.data, IMGMsg.h.sub_dim(1),IMGMsg.h.sub_dim(2),IMGMsg.h.sub_dim(3));
%     IMGMsg.data = imrotate(IMGMsg.data,-90);
%     IMGMsg.data = flipdim(IMGMsg.data, 2);
% else
%     disp('Error');
%     IMGMsg.data = zeros(IMGMsg.h.sub_dim(1),IMGMsg.h.sub_dim(2),IMGMsg.h.sub_dim(3));
% end
    
if(prod(data_sz) == prod(img_sz))
    if(bImg == true)
        IMGMsg.data = reshape(IMGMsg.data, IMGMsg.h.sub_dim(1),IMGMsg.h.sub_dim(2),IMGMsg.h.sub_dim(3));
        IMGMsg.data = imrotate(IMGMsg.data,-90);
        IMGMsg.data = flipdim(IMGMsg.data, 2);
    else
        IMGMsg.data = reshape(IMGMsg.data, IMGMsg.h.sub_dim(2),IMGMsg.h.sub_dim(1),IMGMsg.h.sub_dim(3));
    end
else
    disp('Error');
    IMGMsg.data = zeros(IMGMsg.h.sub_dim(1),IMGMsg.h.sub_dim(2),IMGMsg.h.sub_dim(3));
end
end
