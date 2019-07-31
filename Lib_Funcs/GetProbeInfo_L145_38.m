
%> ========================================================================
%> @brief 
%>  function [ProbeInfo] = GetProbeInfo_L145_38()
%>
%>  @param: Input  >> fn      :: 
%>  @param: Output >> Vol     :: ProbeInfo (the information of given Probe)
%> 
%> %% Get the information of L145_38 probe
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
%>
%> /***************************************************************************
%> Copyright 
%> MUSiiC Laboratory
%> Hyun-Jae Kang,Emad M Boctor
%> Johns Hopkins Medical Institutions
%> Department of Radiology, Division of Medical Imaging Physics
%> 
%> For commercial use/licensing, please contact Emad Boctor, Ph.D. at eboctor@jhmi.edu.
%> ***************************************************************************/

       
function [ProbeInfo] = GetProbeInfo_L145_38()
    ProbeInfo.Enabled                   = 1;
    ProbeInfo.Demo                      = 0;
    ProbeInfo.ID                        = 2;
    ProbeInfo.Name                      = 'L14-5/38';
    ProbeInfo.Type                      = 2;
    ProbeInfo.TxOffset                  = 0.000000;
    ProbeInfo.Vendor_Name               = 'Prosonic';
    ProbeInfo.Vendor_Model              = 'L5-10/40EP(GPS)';
    ProbeInfo.Biopsy_Angle              = 40365;
    ProbeInfo.Biopsy_Depth              = 6000;
    ProbeInfo.Biopsy_Distance           = 49000;
    ProbeInfo.Biopsy_Width              = 4100;
    ProbeInfo.Freq_Center               = 9500000;
    ProbeInfo.Freq_BandWidth            = 9000000;
    ProbeInfo.MaxFocusDistance          = 100000;
    ProbeInfo.MaxSteerAngle             = 17500;
    ProbeInfo.MaxFocusDistDoppler       = 40000;
    ProbeInfo.LineDuration              = 60;
    ProbeInfo.Motor_FOV                 = 0;
    ProbeInfo.Motor_HomeMethod          = 0;
    ProbeInfo.Motor_MinTimeBtwPluses    = 0;
    ProbeInfo.Motor_Radius              = 0;
    ProbeInfo.Motor_Steps               = 0;
    ProbeInfo.Motor_HomeCorrection      = 0;
    ProbeInfo.NumOfElement              = 128;
    ProbeInfo.PinOffset                 = 0;
    ProbeInfo.Pitch                     = 300;
    ProbeInfo.Radius                    = 0;
    ProbeInfo.Support_FreeHand          = 1;
    ProbeInfo.Support_TempAngleSensor   = 0;
    ProbeInfo.Support_Trus              = 0;
    ProbeInfo.MuxWrap_Rx                = 0;
    ProbeInfo.MuxWrap_Tx                = 0;
    ProbeInfo.ElevationLength           = 0.7;
    ProbeInfo.MaxPwPrp                  = 800;
    ProbeInfo.InvertedElements          = 0;
end