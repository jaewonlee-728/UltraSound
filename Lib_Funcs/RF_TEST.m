sd = igtlopen('10.162.34.104', 23877);

if sd == -1
  error('Could not connect to the server.');
end
figure;
colormap(gray);
for n=1:100
  DATA = igtlreceive(sd);
  %rf = DATA.Image;
  rf = double(DATA.Image);
  %%%%%%%%%%%%%%%%%%%%%
  
  %%%%%%%%%%%%%%%%%%%%
  env = abs(hilbert(rf));
  %imagesc(DATA.Image);
  imagesc(env);
  
  drawnow;
end

igtlclose(sd);



function RealPAImage(ptichofElem)

sd = igtlopen('10.162.34.104', 23877);

if sd == -1
  error('Could not connect to the server.');
end
figure;
colormap(gray);
for n=1:100
  DATA = igtlreceive(sd);
  %rf = DATA.Image;
  rf = double(DATA.Image);
  %%%%%%%%%%%%%%%%%%%%%
  %%% fbrf = beamforming(rf, ptichofElem, AprSz);
  %%%%%%%%%%%%%%%%%%%%
  env = abs(hilbert(rf));
  %imagesc(DATA.Image);
  imagesc(env);
  
  drawnow;
end

igtlclose(sd);

end