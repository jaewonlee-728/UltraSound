%> ========================================================================
%> @function 
%>       varargout = MTK_InitializeUSMsg_RF(varargin)
%>
%> @brief 
%>       Load a saved Pre-beamformed RF Data from Hard-Disk
%>
%> @Sub-functions:
%>       - MTK_InitializeUSMsg
%>          - MTK_InitializeUSMsgHeader
%>
%> @Input  param: 
%>
%>       - 'varargin': 'Name of option', 'Value of option'
%>          - M_debug:
%>            'Name  of option' : 'debug'
%>            'Value of option' : true/false
%>             Description      : Enable/Disable debugging messages.
%>             Default value    : false
%>
%>*********** Input parameters of 
%>*********** function: varargout = MTK_InitializeUSMsg(varargin)
%>
%>          - M_datatype:
%>            'Name  of option' : 'M_datatype'
%>            'Value of option' : numerical value (int32)
%>             Description      : Data-Type of Image Data
%>                                1: Scalar
%>                                2: Vector
%>
%>          - M_scalartype:
%>            'Name  of option' : 'M_scalartype'
%>            'Value of option' : numerical value (int32)
%>             Description      : Scalar-Type of Image Data
%>                                2: int8
%>                                3: uint8
%>                                4: int16
%>                                5: uint16
%>                                6: int32
%>                                7: uint32
%>                               10: float32 (matlab:single)
%>                               11: float64 (matlab:double)
%>
%>          - M_endian:
%>            'Name  of option' : 'M_endian'
%>            'Value of option' : numerical value (int32)
%>             Description      : Endian for Image Data
%>                                1: BIG Endian
%>                                2: Little Endian
%>
%>          - M_coordinate:
%>            'Name  of option' : 'M_coordinate'
%>            'Value of option' : numerical value (int32)
%>             Description      : Coordinate System of Image Data
%>                               1: RAS
%>                               2: LPS
%>
%>*********** Input parameters of 
%>*********** function: varargout = varargout = MTK_InitializeUSMsgHeader(varargin)
%>
%>          - M_TYPE:
%>            'Name  of option' : 'M_type'
%>            'Value of option' : numerical value (int32)
%>             Description      : Data Type
%>             Default value    : 0
%>
%>          - M_TXF:
%>            'Name  of option' : 'M_txf'
%>            'Value of option' : numerical value (int32)
%>             Description      : Transmit frequency of ultrasound probe
%>             Default value    : 0
%>
%>          - M_SF:
%>            'Name  of option' : 'M_sf'
%>            'Value of option' : numerical value (int32)
%>             Description      : Sampling frequency of ultrasound machine
%>             Default value    : 0
%>
%>          - M_Dr:
%>            'Name  of option' : 'M_dr'
%>            'Value of option' : numerical value (int32)
%>             Description      : Frame rate or pulse repetition period in 
%>                                Doppler modes
%>             Default value    : 0
%>
%>          - M_Ls:
%>            'Name  of option' : 'M_ls'
%>            'Value of option' : numerical value (int32)
%>             Description      : Line density : can be used to calculate 
%>                                               element spsacing if pitch 
%>                                               and native # elements is 
%>                                               known
%>             Default value    : 0
%>
%>          - M_Sa:
%>            'Name  of option' : 'M_sa'
%>            'Value of option' : numerical value (int32)
%>             Description      : Steering Angle of Ultrasound image
%>             Default value    : 0
%>
%>          - M_Probe:
%>            'Name  of option' : 'M_probe'
%>            'Value of option' : numerical value (int32)
%>             Description      : ID of ultrasound Probe
%>             Default value    : 0
%>
%>          - M_EA:
%>            'Name  of option' : 'M_ea'
%>            'Value of option' : numerical value (int32)
%>             Description      : Extension Angle
%>             Default value    : 0
%>
%>          - M_elements:
%>            'Name  of option' : 'M_elements'
%>            'Value of option' : numerical value (int32)
%>             Description      : The number of elements in the probe that 
%>                                acquire the image
%>             Default value    : 0
%>
%>          - M_pitch:
%>            'Name  of option' : 'M_pitch'
%>            'Value of option' : numerical value (int32)
%>             Description      : The spacing between elements of the probe
%>                                that acquired the image
%>             Default value    : 0
%>
%>          - M_radius:
%>            'Name  of option' : 'M_radius'
%>            'Value of option' : numerical value (int32)
%>             Description      : The curvature of the probe that acquired 
%>                                the image
%>             Default value    : 0
%>
%>          - M_probe_angle:
%>            'Name  of option' : 'M_probe_angle'
%>            'Value of option' : numerical value (int32)
%>             Description      : The field of view of the probe that 
%>                                acquired the image. 
%>                               (Phased array)
%>             Default value    : 0
%>
%>          - M_tx_offset:
%>            'Name  of option' : 'M_tx_offset'
%>            'Value of option' : numerical value (int32)
%>             Description      : For phased array, the number of elements 
%>                                that are offset in the 
%>                                steered image.
%>             Default value    : 0
%>
%>          - M_Motor_Radius:
%>            'Name  of option' : 'M_Motor_Radius'
%>            'Value of option' : numerical value (int32)
%>             Description      : Motor Radius for 3D Ultrasound Data
%>             Default value    : 0
%> 
%>          - M_Frames:
%>            'Name  of option' : 'M_Frames'
%>            'Value of option' : numerical value (int32)
%>             Description      : Total Number of RF-Frames of 3D RF-Volume
%>             Default value    : 0
%> 
%>          - M_Frame_Index:
%>            'Name  of option' : 'M_Frame_Index'
%>            'Value of option' : numerical value (int32)
%>             Description      : The index of RF-Frame in 3D RF-Volume
%>             Default value    : 0
%> 
%>          - M_Focus_Spacing:
%>            'Name  of option' : 'M_Focus_Spacing'
%>            'Value of option' : numerical value (int32)
%>             Description      : The spacing between focus points
%>             Default value    : 0
%> 
%>          - M_Focus_Depth:
%>            'Name  of option' : 'M_Focus_Depth'
%>            'Value of option' : numerical value (int32)
%>             Description      : The depth of first focus point
%>             Default value    : 0
%> 
%>          - M_Motor_Dir:
%>            'Name  of option' : 'M_Motor_Dir'
%>            'Value of option' : numerical value (int8)
%>             Description      : The Direction of 2D fram in 3D Volume
%>             Default value    : 0
%> 
%>          - M_Focus_Count:
%>            'Name  of option' : 'M_Focus_Count'
%>            'Value of option' : numerical value (int8)
%>             Description      : The number of Focus point
%>             Default value    : 0
%>
%> @Output param:
%>
%>       - USMsg_RF (USMessage)
%>         : Initialized Channel Data(Pre-beamfrom RF Data) Set  
%>
%>       - Number of outputs
%>          - 0 or 1 output 
%>               >> PreRF
%>
%> 
%> %% Load a saved Pre-beamformed RF Data from Hard-Disk
% ========================================================================

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
%>              |
%>              | %%% Version 2.0
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
%>
%> /***************************************************************************
%> Copyright 
%> MUSiiC Laboratory
%> Hyun-Jae Kang,Emad M Boctor
%> 
%> Department of Computer Science, Johns Hopkins University
%>
%> Johns Hopkins Medical Institutions
%> Department of Radiology, Division of Medical Imaging Physics
%> 
%> For commercial use/licensing, please contact Emad Boctor, Ph.D. at eboctor@jhmi.edu.
%> ***************************************************************************/

function varargout = MTK_InitializeUSMsg_RF(varargin)
   
    %% Initialized variables
    bDebug        = false;
    
    nVarargins    = length(varargin);
    i             = 1;
    
    
    %% Update variables with input data set
     while i <= nVarargins
        if isnumeric (varargin{i})
            if bDebug == true
                str = sprintf('%03d-th input data is number', i);
                disp(str);
            end
        else
            if bDebug == true
                str = sprintf('%03d-th input data is not number', i);
                disp(str);
                disp(varargin{i});
            end
            
            if strcmpi('M_debug', varargin{i}) == 1
                i          = i+1;
                bDebug     = varargin{i};
            end 
        end
        i=i+1;
     end
    
     %% Initialize USMeesage
     USMsg_RF = MTK_InitializeUSMsg(varargin{:});
     
     %% Output
     if nargout == 0 || nargout ==1
         varargout{1}  = USMsg_RF;
     else
         error('Wrong number of output');
     end 

    
end