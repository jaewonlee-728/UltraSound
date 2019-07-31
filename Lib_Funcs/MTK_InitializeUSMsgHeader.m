%> ========================================================================
%> @function 
%>       varargout = MTK_InitializeUSMsgHeader(varargin)
%>
%> @brief 
%>       Initialize the ultrasound header of USMessage.
%>
%> @Sub-functions:
%>      - No functions
%>
%> @Input  param: 
%>
%>       - 'varargin': 'Name of option', 'Value of option'
%>          - M_debug:
%>            'Name  of option' : 'M_debug'
%>            'Value of option' : true/false
%>             Description      : Enable/Disable debugging messages.
%>             Default value    : false
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
%>       - USMsgUHeader (Data Structure)
%>         : A header that includes the information about ultrasound data 
%>         : Please check the below diagram of data-structure of USMessage
%>
%>       - Number of outputs
%>          - 0 or 1 output 
%>               >> USMsgUHeader 
%>
%> 
%> ========================================================================
%> ========================================================================
%> ************* Data-Structure of USMessage     *******************************
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


function varargout = MTK_InitializeUSMsgHeader(varargin)
   
    %% Initialized variables
    bDebug        = false;
    
    %% Initialize local variables
     
    %%% Version 1.0
    %01 .Data Type
    TYPE            = int32(0);
    %02. Transmit frequency of ultrasound probe
    txf             = int32(0); 
    %03. Sampling frequency of ultrasound machine
    sf              = int32(0); 
    %04. Frame rate or pulse repetition period in Doppler modes
    dr              = int32(0); 
    %05. Line density : can be used to calculate element spsacing if pitch
    %    and native # elements is known
    ls              = int32(0); 

    %06. Steering Angle of Ultrasound image
    sa              = int32(0); 
    %07. ID of ultrasound Probe
    Probe           = int32(0); 
    %08. Extension Angle
    EA              = int32(0); 
    %09. The number of elements in the probe that acquire the image
    elements        = int32(0); 
    %10. The spacing between elements of the probe that acquired the image
    pitch           = int32(0); 

    %11. The curvature of the probe that acquired the image
    radius          = int32(0); 
    %12. The field of view of the probe that acquired the image. 
    %    (Phased array)
    probe_angle     = int32(0); 
    %13. For phased array, the number of elements that are offset in the 
    %    steered image.
    tx_offset       = int32(0); 
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%% Version 2.0
    %14. Motor Radius for 3D Ultrasound Data
    Motor_Radius    = int32(0); 
    %15. Total Number of RF-Frames of 3D RF-Volume
    Frames          = int32(0); 
     
    %16. The index of RF-Frame in 3D RF-Volume
    Frame_Index     = int32(0); 
    %17. The spacing between focus points
    Focus_Spacing   = int32(0); 
    %18. The depth of first focus point
    Focus_Depth     = int32(0); 
    %19. TBD
    Extra_int32_1   = int32(0); 
    %20. TBD
    Extra_int32_2   = int32(0); 

    %21. TBD
    Extra_int32_3   = int32(0); 
    %22. TBD
    Extra_int32_4   = int32(0); 
    %23. TBD
    Extra_int32_5   = int32(0); 
    %24. The Direction of 2D fram in 3D Volume
    Motor_Dir       = int8(0);  
    %25. The number of Focus point
    Focus_Count     = int8(0);  

    %26. TBD
    Extra_int8_1    = int8(0);  
    %27. TBD
    Extra_int8_2    = int8(0);  
    %28. TBD
    Extra_int8_3    = int8(0); 
    
    %%
    
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
                i                   = i+1;
                bDebug              = varargin{i};
            elseif strcmpi('M_type', varargin{i}) == 1
                i                   = i+1;
                TYPE                = int32(varargin{i});
            elseif strcmpi('M_txf', varargin{i}) == 1
                i                   = i+1;
                txf                 = int32(varargin{i});
            elseif strcmpi('M_sf', varargin{i}) == 1
                i                   = i+1;
                sf                  = int32(varargin{i});
            elseif strcmpi('M_dr', varargin{i}) == 1
                i                   = i+1;
                dr                  = int32(varargin{i});
            elseif strcmpi('M_ls', varargin{i}) == 1
                i                   = i+1;
                ls                  = int32(varargin{i});
            elseif strcmpi('M_sa', varargin{i}) == 1
                i                   = i+1;
                sa                  = int32(varargin{i});
            elseif strcmpi('M_probe', varargin{i}) == 1
                i                   = i+1;
                Probe               = int32(varargin{i});
            elseif strcmpi('M_ea', varargin{i}) == 1
                i                   = i+1;
                EA                  = int32(varargin{i});
            elseif strcmpi('M_elements', varargin{i}) == 1
                i                   = i+1;
                elements            = int32(varargin{i});
            elseif strcmpi('M_pitch', varargin{i}) == 1
                i                   = i+1;
                pitch               = int32(varargin{i});
            elseif strcmpi('M_radius', varargin{i}) == 1
                i                   = i+1;
                radius              = int32(varargin{i});
            elseif strcmpi('M_probe_angle', varargin{i}) == 1
                i                   = i+1;
                probe_angle         = int32(varargin{i});    
            elseif strcmpi('M_tx_offset', varargin{i}) == 1
                i                   = i+1;
                tx_offset           = int32(varargin{i});
            elseif strcmpi('M_motor_radius', varargin{i}) == 1
                i                   = i+1;
                Motor_Radius        = int32(varargin{i});
            elseif strcmpi('M_frames', varargin{i}) == 1
                i                   = i+1;
                Frames              = int32(varargin{i});
            elseif strcmpi('M_frame_index', varargin{i}) == 1
                i                   = i+1;
                Frame_Index         = int32(varargin{i});
            elseif strcmpi('M_focus_spacing', varargin{i}) == 1
                i                   = i+1;
                Focus_Spacing       = int32(varargin{i});
            elseif strcmpi('M_focus_depth', varargin{i}) == 1
                i                   = i+1;
                Focus_Depth         = int32(varargin{i});
            elseif strcmpi('M_motor_dir', varargin{i}) == 1
                i                   = i+1;
                Motor_Dir           = int8(varargin{i});
            elseif strcmpi('M_focus_count', varargin{i}) == 1
                i                   = i+1;
                Focus_Count         = int8(varargin{i});
            end 
        end
        
        i                = i+1;
     end
    
     %% Initialize USMeesage
     
     %%% Version 1.0
     %01 .Data Type
     USMsgUHeader.TYPE            = int32(TYPE);
     %02. Transmit frequency of ultrasound probe
     USMsgUHeader.txf             = int32(txf); 
     %03. Sampling frequency of ultrasound machine
     USMsgUHeader.sf              = int32(sf); 
     %04. Frame rate or pulse repetition period in Doppler modes
     USMsgUHeader.dr              = int32(dr); 
     %05. Line density : can be used to calculate element spsacing if pitch
     %    and native # elements is known
     USMsgUHeader.ls              = int32(ls); 

     %06. Steering Angle of Ultrasound image
     USMsgUHeader.sa              = int32(sa); 
     %07. ID of ultrasound Probe
     USMsgUHeader.Probe           = int32(Probe); 
     %08. Extension Angle
     USMsgUHeader.EA              = int32(EA); 
     %09. The number of elements in the probe that acquire the image
     USMsgUHeader.elements        = int32(elements); 
     %10. The spacing between elements of the probe that acquired the image
     USMsgUHeader.pitch           = int32(pitch); 

     %11. The curvature of the probe that acquired the image
     USMsgUHeader.radius          = int32(radius); 
     %12. The field of view of the probe that acquired the image. 
     %    (Phased array)
     USMsgUHeader.probe_angle     = int32(probe_angle); 
     %13. For phased array, the number of elements that are offset in the 
     %    steered image.
     USMsgUHeader.tx_offset       = int32(tx_offset); 
     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     %%% Version 2.0
     %14. Motor Radius for 3D Ultrasound Data
     USMsgUHeader.Motor_Radius    = int32(Motor_Radius); 
     %15. Total Number of RF-Frames of 3D RF-Volume
     USMsgUHeader.Frames          = int32(Frames); 
     
     %16. The index of RF-Frame in 3D RF-Volume
     USMsgUHeader.Frame_Index     = int32(Frame_Index); 
     %17. The spacing between focus points
     USMsgUHeader.Focus_Spacing   = int32(Focus_Spacing); 
     %18. The depth of first focus point
     USMsgUHeader.Focus_Depth     = int32(Focus_Depth); 
     %19. TBD
     USMsgUHeader.Extra_int32_1   = int32(Extra_int32_1); 
     %20. TBD
     USMsgUHeader.Extra_int32_2   = int32(Extra_int32_2); 

     %21. TBD
     USMsgUHeader.Extra_int32_3   = int32(Extra_int32_3); 
     %22. TBD
     USMsgUHeader.Extra_int32_4   = int32(Extra_int32_4); 
     %23. TBD
     USMsgUHeader.Extra_int32_5   = int32(Extra_int32_5); 
     %24. The Direction of 2D fram in 3D Volume
     USMsgUHeader.Motor_Dir       = int8(Motor_Dir);  
     %25. The number of Focus point
     USMsgUHeader.Focus_Count     = int8(Focus_Count);  

     %26. TBD
     USMsgUHeader.Extra_int8_1    = int8(Extra_int8_1);  
     %27. TBD
     USMsgUHeader.Extra_int8_2    = int8(Extra_int8_2);  
     %28. TBD
     USMsgUHeader.Extra_int8_3    = int8(Extra_int8_3);  


     %% Output
     if nargout == 0 || nargout ==1
         varargout{1}  = USMsgUHeader;
     else
         error('Wrong number of output');
     end 
     
    
end