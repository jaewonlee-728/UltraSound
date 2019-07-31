% =========================================================================
%> @brief 
%>  function [ProbeInfo] = InitializeProbeInfo()
%> 
%>  Initialize Header of USMessage
%>  @param: Input  >> 
%>  @param: Output >> ProbeInfo   : Information of Probe
% =========================================================================
%> ========================================================================
%> ************* Data_Type of Output **************************************
% ProbeInfo::
%        - ProbeInfo.Enabled                   
%        - ProbeInfo.Demo
%           %> ID of the probe. The code pins programmed into connector.
%        - ProbeInfo.ID 
%           %> Name of probe
%        - ProbeInfo.Name 
%           %> Type of probe. See the probeType enumeration.
%        - ProbeInfo.Type  
%           %> Transmit offset in number of elements
%        - ProbeInfo.TxOffset  
%           %> The name of Vendor
%        - ProbeInfo.Vendor_Name 
%           %> The model number of Vendor
%        - ProbeInfo.Vendor_Model   
%           %> Angle of entry for the biopsy needle in 1/1000th of degree.
%        - ProbeInfo.Biopsy_Angle   
%           %> Depth of entry for the biopsy needle in microns.
%        - ProbeInfo.Biopsy_Depth  
%           %> Initial target distance at probe surface in microns.
%        - ProbeInfo.Biopsy_Distance  
%           %> Default width in pixels of the biopsy guide.
%        - ProbeInfo.Biopsy_Width  
%           %> Central frequency of probe in Hz.
%        - ProbeInfo.Freq_Center   
%           %> Frequency bandwidth in Hz
%        - ProbeInfo.Freq_BandWidth  
%           %> Maximum focus distance in microns for calculating dynamic receive time delays.
%        - ProbeInfo.MaxFocusDistance 
%           %> Maximum steer angle allowable in 1/1000th of degree.
%        - ProbeInfo.MaxSteerAngle   
%           %> Minimum focus distance for one Doppler scanline.
%        - ProbeInfo.MaxFocusDistDoppler   
%           %> Minimum line duration for one scanline in microseconds.
%        - ProbeInfo.LineDuration 
%           %> Field of view of the motor range in 1/1000th of degree.
%        - ProbeInfo.Motor_FOV   
%           %> Code for how the motor gets to home position.
%        - ProbeInfo.Motor_HomeMethod   
%           %> If the motor makes audible noise, set this flag to correct it
%        - ProbeInfo.Motor_MinTimeBtwPluses  
%           %> Radius of motor.
%        - ProbeInfo.Motor_Radius 
%           %> Maximum number of motor steps if the probe has a motor
%        - ProbeInfo.Motor_Steps   
%     
%        - ProbeInfo.Motor_HomeCorrection  
%           %> Number of elements in the probe.
%        - ProbeInfo.NumOfElement   
%           %> Pin offset if the probe element #0 starts at a different pin.
%        - ProbeInfo.PinOffset    
%           %> Pitch, or the distance between elements in microns.
%        - ProbeInfo.Pitch  
%           %> Radius of probe in 1/1000th of degree.
%        - ProbeInfo.Radius                    
%        - ProbeInfo.Support_FreeHand          
%        - ProbeInfo.Support_TempAngleSensor  
%        - ProbeInfo.Support_Trus              
%        - ProbeInfo.MuxWrap_Rx                
%        - ProbeInfo.MuxWrap_Tx                
%        - ProbeInfo.ElevationLength           
%        - ProbeInfo.MaxPwPrp                  
%        - ProbeInfo.InvertedElements  
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


function [ProbeInfo] = InitializeProbeInfo()
    ProbeInfo.Enabled                   = 1;
    ProbeInfo.Demo                      = 1;
    ProbeInfo.ID                        = 1;
    ProbeInfo.Name                      = 1;
    ProbeInfo.Type                      = 1;
    ProbeInfo.TxOffset                  = 1;
    ProbeInfo.Vendor_Name               = 1;
    ProbeInfo.Vendor_Model              = 1;
    ProbeInfo.Biopsy_Angle              = 1;
    ProbeInfo.Biopsy_Depth              = 1;
    ProbeInfo.Biopsy_Distance           = 1;
    ProbeInfo.Biopsy_Width              = 1;
    ProbeInfo.Freq_Center               = 1;
    ProbeInfo.Freq_BandWidth            = 1;
    ProbeInfo.MaxFocusDistance          = 1;
    ProbeInfo.MaxSteerAngle             = 1;
    ProbeInfo.MaxFocusDistDoppler       = 1;
    ProbeInfo.LineDuration              = 1;
    ProbeInfo.Motor_FOV                 = 1;
    ProbeInfo.Motor_HomeMethod          = 1;
    ProbeInfo.Motor_MinTimeBtwPluses    = 1;
    ProbeInfo.Motor_Radius              = 1;
    ProbeInfo.Motor_Steps               = 1;
    ProbeInfo.Motor_HomeCorrection      = 1;
    ProbeInfo.NumOfElement              = 1;
    ProbeInfo.PinOffset                 = 1;
    ProbeInfo.Pitch                     = 1;
    ProbeInfo.Radius                    = 1;
    ProbeInfo.Support_FreeHand          = 1;
    ProbeInfo.Support_TempAngleSensor   = 1;
    ProbeInfo.Support_Trus              = 1;
    ProbeInfo.MuxWrap_Rx                = 1;
    ProbeInfo.MuxWrap_Tx                = 1;
    ProbeInfo.ElevationLength           = 1;
    ProbeInfo.MaxPwPrp                  = 1;
    ProbeInfo.InvertedElements          = 1;
end

