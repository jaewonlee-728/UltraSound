
function varargout = MTK_beamformDAQ2_lut(preBeamformed, varargin) 
%function [out] = MTK_beamformDAQ2_lut(preBeamformed, fulAprSz, channelSpacing)
% The following script take the pre-beamform data and creates beamfromed
% image by applying parallel beamformers to the same data. 
%
% input:
%   preBeamformed:  the first dimension should be scan lines and the second
%                   dimension should be the channel samples
%   fulAprSz:       size of the aperture beamformer
% 
%
% output:
%   out:            beamformed data
%
% Example:
%   bRF = beamformDAQ(RF, 32);
%
% Author: Reza Zahiri Azar
% Copyright Ultrasonix Medical Corporation - April 2010
%
% Modified by Muyinatu (Bisi) Bell to include look-up table -  November 22, 2013
% Modified by Hyun-Jae Kang                                 -  November 25, 2013


    fulAprSz = 32;
    channelSpacing = 55/128; % spacing for 55 mm transducer

    bDebug           = false;
    bLUT             = false;
    
    
    nVarargins       = length(varargin);
    i                = 1;

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
     %% Update variables with input data set
     while i <= nVarargins
        if isnumeric (varargin{i})
            if bDebug == true
%                 str = sprintf('%03d-th input data is number', i);
                disp(str);
            end
        else
            if bDebug == true
                str = sprintf('%03d-th input data is not number', i);
                disp(str);
                disp(varargin{i});
            end
            
            if strcmpi('M_debug', varargin{i}) == 1
                i                     = i+1;
                bDebug                = varargin{i};
            elseif strcmpi('M_AprSz', varargin{i}) == 1
                i                     = i+1;
                fulAprSz                = varargin{i};
            elseif strcmpi('M_USP_Pitch', varargin{i}) == 1
                i                     = i+1;
                channelSpacing        = varargin{i};
            elseif strcmpi('M_LUT', varargin{i}) == 1
                bLUT                  = true;
                i                     = i+1;
                delays                = varargin{i};
            end
        end
        i                = i  + 1;
     end
     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Fixed parameters
    c=1540;% [m/s]
    sampleSpacing = 1/40e6*c*1e3; % [mm] spacing between samples in photoacoustic imaging

    % The first dimension has to be lines and second dimension has to be samples
    if (size(preBeamformed,1) > size(preBeamformed,2))
        preBeamformed = preBeamformed';
        transposed = true;
    else
        transposed = false;
    end


    nl = size(preBeamformed,1);   % number of lines
    ns = size(preBeamformed,2);   % number of samples

    hlfAprSz = floor(fulAprSz/2);
    fulAprSz = hlfAprSz*2 + 1;

    x = -hlfAprSz: hlfAprSz;    % aperture indices

    % Create or load look up table
    tablename = ['lookuptable_channelSpacing' num2str(round(channelSpacing*1000)) 'num_numsamples'  num2str(ns) '.mat'];

    %if ~exist(tablename,'file')
    if bLUT == false
        offset = 0;             % distance between first sample and transducer element in milimeter
        nSampleOffset = round(offset/ sampleSpacing);    % offset in samples: 1st sample is actually 1+nSampleOffset sample
        delays = zeros(ns,fulAprSz);
        %for i = 1:nl    % for each line/channel
           % disp(['scanline #', num2str(i)]);

            for j=1:ns  % find the value for each sample
                % calc delays based on sample depth and receive aperture
                distance2probe =  (j + nSampleOffset) * sampleSpacing ;
                rad = sqrt( (x.*channelSpacing).^2 +  distance2probe^2 );
                delays(j,:) = (rad - rad(hlfAprSz+1))./ sampleSpacing; 
            end
        %end

%         %save (tablename, 'delays')
%     else
%         %load (tablename, 'delays')
    end

    out = zeros(size(preBeamformed));
    for j=1:ns  % find the value for each sample
        for i = 1:nl    % for each line/channel

            cntr = i;       % center of apreture
            apr = cntr + x; % full aperture indices
            chnls = zeros(1,fulAprSz);  % initialize channel values

            % find the corresponding value from each channel
            for k = 1:fulAprSz

                chlIndx = apr(k);
                if chlIndx<1, continue, end;
                if chlIndx>nl, continue, end;
                chlSmpl = round(j+delays(j,k));

                if chlSmpl<1, continue, end;
                if chlSmpl>ns, continue, end;
                chnls(k) = preBeamformed(chlIndx, chlSmpl);


            end;

            % beamforming
            out(i,j) = sum( chnls ) ;

        end;
    end
    
    if (transposed)    
        out = out';
    end
    
    if nargout == 0 || nargout ==1
         varargout{1}  = out;
     elseif nargout == 2
         varargout{1}  = out;
         varargout{2}  = delays;
     else
         error('Wrong number of output');
     end
    
    
end

