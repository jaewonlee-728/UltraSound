% =========================================================================
%> @brief 
%>  Retrieve Header of USMessage from binary data-buffer 
%>  @param: Input  >> buf   : binary data buffer based on uint8
%>  @param: Output >> USh   : Header of USMessage
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

function USh = GetUSMsgHeader(buf)
%>  Computing the size of buffer
bsz = prod(size(buf));
%>  Initialize Header of USMessage
USh = InitializeUSMsgHeader();

if(bsz >= 52) % For USMessage version 1.0
    %%% Version 1.0
    USh.TYPE            = typecast(uint8(buf(1:4)), 'int32'); %Data Type
    USh.txf             = typecast(uint8(buf(5:8)), 'int32'); %transmit frequency of ultrasound probe
    USh.sf              = typecast(uint8(buf(9:12)), 'int32'); %sampling frequency of ultrasound machine
    USh.dr              = typecast(uint8(buf(13:16)), 'int32'); %frame rate or pulse repetition period in Doppler modes
    USh.ls              = typecast(uint8(buf(17:20)), 'int32'); %Line density : can be used to calculate element spsacing fi pitch and native # elements is known

    USh.sa              = typecast(uint8(buf(21:24)), 'int32'); %Steering Angle of Ultrasound image
    USh.Probe           = typecast(uint8(buf(25:28)), 'int32'); %ID of ultrasound Probe
    USh.EA              = typecast(uint8(buf(29:32)), 'int32'); %Extension Angle
    USh.elements        = typecast(uint8(buf(33:36)), 'int32'); %The number of elements in the probe that acquire the image
    USh.pitch           = typecast(uint8(buf(37:40)), 'int32'); %The spacing between elements of the probe that acquired the image


    USh.radius          = typecast(uint8(buf(41:44)), 'int32'); %The curvature of the probe that acquired the image
    USh.probe_angle     = typecast(uint8(buf(45:48)), 'int32'); %The field of view of the probe that acquired the image. (Phased array)
    USh.tx_offset       = typecast(uint8(buf(49:52)), 'int32'); %For phased array, the number of elements that are offset in the steered image.  

    if (bsz == 97) % For USMessage version 2.0
    
        USh.Motor_Radius    = typecast(uint8(buf(53:56)), 'int32'); %Motor Radius for 3D Ultrasound Data
        USh.Frames          = typecast(uint8(buf(57:60)), 'int32'); %Total Number of RF-Frames of 3D RF-Volume

        USh.Frame_Index     = typecast(uint8(buf(61:64)), 'int32'); %The index of RF-Frame in 3D RF-Volume
        USh.Focus_Spacing   = typecast(uint8(buf(65:68)), 'int32'); %The spacing between focus points
        USh.Focus_Depth     = typecast(uint8(buf(69:72)), 'int32'); %The depth of first focus point
        USh.Extra_int32_1   = typecast(uint8(buf(73:76)), 'int32'); %TBD
        USh.Extra_int32_2   = typecast(uint8(buf(77:80)), 'int32'); %TBD

        USh.Extra_int32_3   = typecast(uint8(buf(81:84)), 'int32'); %TBD
        USh.Extra_int32_4   = typecast(uint8(buf(85:88)), 'int32'); %TBD
        USh.Extra_int32_5   = typecast(uint8(buf(89:92)), 'int32'); %TBD
        USh.Motor_Dir       = int8(buf(93));  %The Direction of 2D fram in 3D Volume
        USh.Focus_Count     = int8(buf(94));  %The number of Focus point

        USh.Extra_int8_1    = int8(buf(95));  %TBD
        USh.Extra_int8_2    = int8(buf(96));  %TBD
        USh.Extra_int8_3    = int8(buf(97));  %TBD
    end

end
    % Convert little endain to big endian of the Header information of USMessage 
    USh = IGTLUSMsgHeaderByteConvert(USh);
end