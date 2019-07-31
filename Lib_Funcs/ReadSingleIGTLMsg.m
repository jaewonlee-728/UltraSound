% =========================================================================
%> @brief 
%>  function [IGTLMsg] = ReadSingleIGTLMsg(fileName)
%> 
%>  Reading Single IGTL Message from *.igtl file.
%>  *.igtl file is created by dumping IGTL Message itself to hard disk
%>  This function read single *.igtl file, and then generate single IGTL
%>  Message
%>  @param: Input >> fileName : the file path of *.igtl file
%>  @param: Output >> IGTLMsg : OpenIGTLink Message
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


function [IGTLMsg] = ReadSingleIGTLMsg(fileName)

% Define the size of Header of OpenIGTLink Message
IGTL_HEADER_SIZE = 58;

% Open file
fid = fopen(fileName, 'r');

if(fid == -1)
    error('Cannot open the file');
end

% Read a Header of OpenIGTLink Message
HBuf = uint8(fread(fid, IGTL_HEADER_SIZE, 'uint8'));
% Retrieve a Header of OpenIGTLink Message
IGTLMsg.IGTLHeader = UnPackIGTLHeader(HBuf);

% Read a Body of OpenIGTLink Message
BBuf = uint8(fread(fid,IGTLMsg.IGTLHeader.bodysize, 'uint8')); 

% Retrieve a Body of OpenIGTLink Message
if(strcmp((IGTLMsg.IGTLHeader.type),'IMAGE'))
    if(findstr(IGTLMsg.IGTLHeader.device,'US'))% || findstr(IGTLMsg.Header.type,'RF'))
        IGTLMsg.Body = UnPackIGTLUSMsg(BBuf);
    else
        IGTLMsg.Body = UnPackIGTLImageMsg(BBuf);
    end
end

fclose(fid);
end

