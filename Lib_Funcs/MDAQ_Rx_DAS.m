sd = igtlopen('localhost', 8229);

if sd == -1
  error('Could not connect to the server.');
end

pnx = 0;
pny = 0;
psx = 0;
psy = 0;

pfulAprSz = 0;
fulAprSz  = 32;
lut       = [];
channelSpacing = 0.3;

figure;
for n=1:10
    DATA = igtlreceive(sd);
    prf = DATA.Image;
    %%% Get information of Pre-beamformed RF data
    [ny,nx] = size(prf);
    sx = abs(DATA.Trans(1,1));
    sy = abs(DATA.Trans(2,2));
    
    if pnx ~= nx || pny ~= ny || psx ~= sx || psy ~= sy
        tic;
        [brf, lut] = MTK_beamformDAQ2_lut(prf, 'M_AprSz', fulAprSz, ...
                                               'M_USP_Pitch', sx);
%         [brf] = beamformDAQ2_lutb(prf, fulAprSz, channelSpacing);
        %% Update
         pnx = nx;
         pny = ny;
         psx = sx;
         psy = sy;
         disp(' LUT is generated');
         toc
    else
        tic;
        [brf, lut] = MTK_beamformDAQ2_lut(prf, 'M_AprSz', fulAprSz, ...
                                               'M_USP_Pitch', sx, ...
                                               'M_LUT', lut);

%         [brf] = beamformDAQ2_lutb(prf, fulAprSz, channelSpacing);
                                           
        %% Update
         pnx = nx;
         pny = ny;
         psx = sx;
         psy = sy;
         
         disp('LUT is used');
         toc
    end
    
    
    Ref_Im_x = double([0 nx])*sx;
    Ref_Im_y = double([0 ny])*sy;
    %% Envelope
    env = abs(hilbert(brf));
    %% Display
    imagesc(Ref_Im_x, Ref_Im_y,env);
    drawnow;
end

igtlclose(sd);