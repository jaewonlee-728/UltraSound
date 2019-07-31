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

% sampling time 
dt       =  1/40e6;
% speed of sound 
sos      =  1540;                        % unit: m/s

figure;
for n=1:100
    DATA = igtlreceive(sd);
    %prf = DATA.Image;
    prf = double(DATA.Image);
    %%% Get information of Pre-beamformed RF data
    [ny,nx] = size(prf);
    sx = abs(DATA.Trans(1,1));
    sy = abs(DATA.Trans(2,2));
    
     % Setting input variables of kspaceLineRecon
     % pitch of ultrasound elements (spacing of ultrasound elements)
     dx       =  double(sx)/1000; % unit: mm > m
     
     %% Beamforming
     tic;
     brf = kspaceLineRecon(prf, ...
                           dx, ...
                           dt, ...
                           sos);
    
    toc
    Ref_Im_x = double([0 nx])*sx;
    Ref_Im_y = double([0 ny])*sy;
    %% Envelope
    env = abs(hilbert(brf));
    %% Display
    imagesc(Ref_Im_x, Ref_Im_y,env);
    drawnow;
end

igtlclose(sd);