%
% Example to use igtlreceive()
%

%%% read image data
%%sd = igtlopen('localhost', 18944);

sd = igtlopen('localhost', 8229);
sd = igtlopen('10.162.34.104', 23978); % B-Mode
sd = igtlopen('10.162.34.104', 23878); % RF

if sd == -1
  error('Could not connect to the server.');
end
figure;
for n=1:10
  DATA = igtlreceive(sd);
  imagesc(DATA.Image);
end

igtlclose(sd);