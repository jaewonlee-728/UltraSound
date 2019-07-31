fileName = 'PA_Test_3371.989670.igtl';

fileName = 'PA_Test_3642.587865.igtl';
[IGTLMsg] = ReadSingleIGTLMsg(fileName);
[IGTLMsg2] = ReadSingleIGTLMsg(fileName);

% sampling time 
dt       =  1/40e6;
% speed of sound 
sos      =  1540;                        % unit: m/s

dx       =  double(0.3)/1000; % unit: mm > m

prf = double(IGTLMsg.Body.data);

 brf = kspaceLineRecon(prf, ...
                       dx, ...
                       dt, ...
                       sos);
 env = abs(hilbert(brf));
%% Display
imagesc(Ref_Im_x, Ref_Im_y,env);
