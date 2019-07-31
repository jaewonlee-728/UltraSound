% =========================================================================
%> @brief 
%> [USMsg] = InitializeUSMsgRF()
%>  Initialize Header of USMessage
%>  @param: Input  >> none
%>  @param: Output >> USh   : Header of USMessage
% =========================================================================
%> ========================================================================
%> ************* Data_Type of Input/ Output *******************************
%> USMessage - IGTLHeader
%>       |      - version              // Version of IGTLink Message
%>       |      - type                 // Message type
%>       |      - device               // Device name
%>       |      - ts                   // Time stamp
%>       |      - bodysize             // Body size of IGTLink Message
%>       |      - crc                  // CRC
%>       - Body
%>             - h                     // The Header of ImageMessage
%>              |   - version          // Version of ImageMessage
%>              |   - type             // Type of Image Data
%>              |   - scalar Type      // Data type of Image Data 
%>              |   - endian           // Endian of this Message
%>              |   - coordinate       // Coordinate system 
%>              |   - dim              // Dimension of Image Data <3x1 unint16>
%>              |   - sub_off          // Sub-Offset of Image Data
%>              |   - sub_dim          // Sub-dimension of Image Data
%>              |   - matrix           // Transformation matrix of Image Data
%>              |   - spacing          // Spacing values of Image Data <1x3 single>
%>             - data                  // Image Data
%>             - uh                    // The Header of USMessage
%>              |   - TYPE             // Data Type
%>              |   - txf              // transmit frequency of ultrasound probe
%>              |   - sf               // sampling frequency of ultrasound machine
%>              |   - dr               // frame rate or pulse repetition period in Doppler modes
%>              |   - ls               // Line density : can be used to calculate element spsacing fi pitch and native # elements is known
%>              |   - sa               // Steering Angle of Ultrasound image
%>              |   - Probe            // ID of ultrasound Probe
%>              |   - EA               // Extension Angle
%>              |   - elements         // The number of elements in the probe that acquire the image
%>              |   - pitch            // The spacing between elements of the probe that acquired the image
%>              |   - radius           // The curvature of the probe that acquired the image
%>              |   - probe_angle      // The field of view of the probe that acquired the image. (Phased array)
%>              |   - tx_offset        // For phased array, the number of elements that are offset in the steered image.
%>                   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%>                  %%% Version 2.0
%>              |   - Motor_Radius     // Motor Radius for 3D Ultrasound Data
%>              |   - Frames           // Total Number of RF-Frames of 3D RF-Volume
%>              |   - Frame_Index      // The index of RF-Frame in 3D RF-Volume
%>              |   - Focus_Spacing    // The spacing between focus points
%>              |   - Focus_Depth      // The depth of first focus point
%>              |   - Extra_int32_1    // TBD
%>              |   - Extra_int32_2    // TBD
%>              |   - Extra_int32_3    // TBD
%>              |   - Extra_int32_4    // TBD
%>              |   - Extra_int32_5    // TBD
%>              |   - Motor_Dir        // The Direction of 2D fram in 3D Volume
%>              |   - Focus_Count      // The number of Focus point
%>              |   - Extra_int8_1     // TBD
%>              |   - Extra_int8_2     // TBD
%>              |   - Extra_int8_3     // TBD
%> ========================================================================
% /***************************************************************************
% Copyright 
% MUSiiC Laboratory
% Hyun-Jae Kang,Emad M Boctor
% Johns Hopkins Medical Institutions
% Department of Radiology, Division of Medical Imaging Physics
% 
% For commercial use/licensing, please contact Emad Boctor, Ph.D. at eboctor@jhmi.edu.
% ***************************************************************************/


function [USMsg] = InitializeUSMsgRF()


USMsg.IGTLHeader.version  = int32(1);
USMsg.IGTLHeader.type     = 'IMAGE';
USMsg.IGTLHeader.device   = 'US';
USMsg.IGTLHeader.ts       =  uint64(0);
USMsg.IGTLHeader.bodysize =  uint64(0);
USMsg.IGTLHeader.crc      =  uint64(0);


% Version Number of ImageMessage
USMsg.Body.h.version    = int32(1);
% Data-Type of Image Data
% 1: Scalar
% 2: Vector
USMsg.Body.h.type       = int32(1);
% Scalar-Type of Image Data
%  2: int8
%  3: uint8
%  4: int16
%  5: uint16
%  6: int32
%  7: uint32
% 10: float32 (matlab:single)
% 11: float64 (matlab:double)
USMsg.Body.h.scalarType = int32(4);
% Endian for Image Data
% 1: BIG Endian
% 2: Little Endian
USMsg.Body.h.endian     = int32(1);
% Coordinate System of Image Data
% 1: RAS
% 2: LPS
USMsg.Body.h.coordinate = int32(1);
% dim 
USMsg.Body.h.dim(1) = int32(0);
USMsg.Body.h.dim(2) = int32(0);
USMsg.Body.h.dim(3) = int32(0);
%sub_off
USMsg.Body.h.sub_off(1) = int32(0);
USMsg.Body.h.sub_off(2) = int32(0);
USMsg.Body.h.sub_off(3) = int32(0);
%sub_dim
USMsg.Body.h.sub_dim(1) = int32(0);
USMsg.Body.h.sub_dim(2) = int32(0);
USMsg.Body.h.sub_dim(3) = int32(0);
% matrix
USMsg.Body.h.mat        = eye(4);
%spacing        // Spacing values of Image Data <1x3 single>
USMsg.Body.h.spacing(1) = single(0);
USMsg.Body.h.spacing(2) = single(0);
USMsg.Body.h.spacing(3) = single(0);

%  Initialize Header of USMessage
USMsg.Body.uh = InitializeUSMsgHeader();
end
