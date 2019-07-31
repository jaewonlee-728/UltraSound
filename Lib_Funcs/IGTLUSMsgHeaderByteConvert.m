% =========================================================================
%> @brief 
%>  Convert little endain to big endian of the Header information of USMessage 
%>  @param: Input  >> H     : Header information of USMessage 
%>  @param: Output >> H_C   : Converted Header information of USMessage
% =========================================================================
%> ========================================================================
%> ************* Data_Type of Input/ Output *******************************
%>
%>             - H_C                    // The Header of USMessage
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

function [H_C] = IGTLUSMsgHeaderByteConvert(H)
H_C.TYPE            = BYTE_SWAP_INT32(H.TYPE); %Data Type
H_C.txf             = BYTE_SWAP_INT32(H.txf); %transmit frequency of ultrasound probe
H_C.sf              = BYTE_SWAP_INT32(H.sf); %sampling frequency of ultrasound machine
H_C.dr              = BYTE_SWAP_INT32(H.dr); %frame rate or pulse repetition period in Doppler modes
H_C.ls              = BYTE_SWAP_INT32(H.ls); %Line density : can be used to calculate element spsacing fi pitch and native # elements is known

H_C.sa              = BYTE_SWAP_INT32(H.sa); %Steering Angle of Ultrasound image
H_C.Probe           = BYTE_SWAP_INT32(H.Probe); %ID of ultrasound Probe
H_C.EA              = BYTE_SWAP_INT32(H.EA); %Extension Angle
H_C.elements        = BYTE_SWAP_INT32(H.elements); %The number of elements in the probe that acquire the image
H_C.pitch           = BYTE_SWAP_INT32(H.pitch); %The spacing between elements of the probe that acquired the image


H_C.radius          = BYTE_SWAP_INT32(H.radius); %The curvature of the probe that acquired the image
H_C.probe_angle     = BYTE_SWAP_INT32(H.probe_angle); %The field of view of the probe that acquired the image. (Phased array)
H_C.tx_offset       = BYTE_SWAP_INT32(H.tx_offset); %For phased array, the number of elements that are offset in the steered image.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Version 2.0
H_C.Motor_Radius    = BYTE_SWAP_INT32(H.Motor_Radius); %Motor Radius for 3D Ultrasound Data
H_C.Frames          = BYTE_SWAP_INT32(H.Frames); %Total Number of RF-Frames of 3D RF-Volume

H_C.Frame_Index     = BYTE_SWAP_INT32(H.Frame_Index); %The index of RF-Frame in 3D RF-Volume
H_C.Focus_Spacing   = BYTE_SWAP_INT32(H.Focus_Spacing); %The spacing between focus points
H_C.Focus_Depth     = BYTE_SWAP_INT32(H.Focus_Depth); %The depth of first focus point
H_C.Extra_int32_1   = BYTE_SWAP_INT32(H.Extra_int32_1); %TBD
H_C.Extra_int32_2   = BYTE_SWAP_INT32(H.Extra_int32_2); %TBD

H_C.Extra_int32_3   = BYTE_SWAP_INT32(H.Extra_int32_3); %TBD
H_C.Extra_int32_4   = BYTE_SWAP_INT32(H.Extra_int32_4); %TBD
H_C.Extra_int32_5   = BYTE_SWAP_INT32(H.Extra_int32_5); %TBD
H_C.Motor_Dir       = H.Motor_Dir ;  %The Direction of 2D fram in 3D Volume
H_C.Focus_Count     = H.Focus_Count;  %The number of Focus point

H_C.Extra_int8_1    = H.Extra_int8_1;  %TBD
H_C.Extra_int8_2    = H.Extra_int8_2;  %TBD
H_C.Extra_int8_3    = H.Extra_int8_3;  %TBD
end
