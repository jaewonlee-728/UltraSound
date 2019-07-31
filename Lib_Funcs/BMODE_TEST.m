sd = igtlopen('10.162.34.104', 23978);

if sd == -1
  error('Could not connect to the server.');
end
figure;
for n=1:1000
  DATA = igtlreceive(sd);
  imagesc(DATA.Image');
  drawnow;
end

igtlclose(sd);