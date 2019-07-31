% =========================================================================
%> @brief 
%>  function USh = InitializeUSMsgHeader()
%> 
%>  Initialize Header of USMessage
%>  @param: Input  >> none
%>  @param: Output >> USh   : Header of USMessage
% =========================================================================
%> ========================================================================
%> ************* Data_Type of Input/ Output *******************************
%>
%>             - USh                    // The Header of USMessage
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

function USh = InitializeUSMsgHeader()
%%% Version 1.0
USh.TYPE            = int32(0); %Data Type
USh.txf             = int32(0); %transmit frequency of ultrasound probe
USh.sf              = int32(0); %sampling frequency of ultrasound machine
USh.dr              = int32(0); %frame rate or pulse repetition period in Doppler modes
USh.ls              = int32(0); %Line density : can be used to calculate element spsacing fi pitch and native # elements is known

USh.sa              = int32(0); %Steering Angle of Ultrasound image
USh.Probe           = int32(0); %ID of ultrasound Probe
USh.EA              = int32(0); %Extension Angle
USh.elements        = int32(0); %The number of elements in the probe that acquire the image
USh.pitch           = int32(0); %The spacing between elements of the probe that acquired the image


USh.radius          = int32(0); %The curvature of the probe that acquired the image
USh.probe_angle     = int32(0); %The field of view of the probe that acquired the image. (Phased array)
USh.tx_offset       = int32(0); %For phased array, the number of elements that are offset in the steered image.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Version 2.0
USh.Motor_Radius    = int32(0); %Motor Radius for 3D Ultrasound Data
USh.Frames          = int32(0); %Total Number of RF-Frames of 3D RF-Volume

USh.Frame_Index     = int32(0); %The index of RF-Frame in 3D RF-Volume
USh.Focus_Spacing   = int32(0); %The spacing between focus points
USh.Focus_Depth     = int32(0); %The depth of first focus point
USh.Extra_int32_1   = int32(0); %TBD
USh.Extra_int32_2   = int32(0); %TBD

USh.Extra_int32_3   = int32(0); %TBD
USh.Extra_int32_4   = int32(0); %TBD
USh.Extra_int32_5   = int32(0); %TBD
USh.Motor_Dir       = int8(0);  %The Direction of 2D fram in 3D Volume
USh.Focus_Count     = int8(0);  %The number of Focus point

USh.Extra_int8_1    = int8(0);  %TBD
USh.Extra_int8_2    = int8(0);  %TBD
USh.Extra_int8_3    = int8(0);  %TBD

end
