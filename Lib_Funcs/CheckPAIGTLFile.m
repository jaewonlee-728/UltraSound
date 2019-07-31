function CheckPAIGTLFile(fileName)

[IGTLMsg] = ReadSingleIGTLMsg(fileName);

prf = double(IGTLMsg.Body.data);
[ny,nx] = size(prf);
sx = IGTLMsg.Body.h.spacing(1);
sy = IGTLMsg.Body.h.spacing(2);
Ref_Im_x = double([0 nx])*sx;
Ref_Im_y = double([0 ny])*sy;

fulAprSz = 32;
channelSpacing = 55/128; % spacing for 55 mm transducer

 [brf] = beamformDAQ2_lutb(prf, fulAprSz, channelSpacing);
%  IGTLMsg.Body.uh.pitch = (55/128)*1000;
%  IGTLMsg.Body.uh.sf = 40e6;
%  PostBeam = MTK_DASBeamforming_PreBRF_USMsg(IGTLMsg);
%  brf = double(PostBeam.Body.data);
 env = abs(hilbert(brf));
 imagesc(Ref_Im_x, Ref_Im_y,env);
 drawnow;

end