sd = igtlopen('localhost', 8229);

if sd == -1
  error('Could not connect to the server.');
end
figure;
for n=1:10
    DATA = igtlreceive(sd);
    prf = DATA.Image;
    [ny,nx] = size(prf);
    sx = abs(DATA.Trans(1,1));
    sy = abs(DATA.Trans(2,2));
    Ref_Im_x = double([0 nx])*sx;
    Ref_Im_y = double([0 ny])*sy;
    imagesc(Ref_Im_x, Ref_Im_y,prf);
    drawnow;
end

igtlclose(sd);