sd = igtlopen('localhost', 8229);

if sd == -1
  error('Could not connect to the server.');
end
figure;
for n=1:50
    n
    DATA = igtlreceive(sd);
    prf = double(DATA.Image);
    [ny,nx] = size(prf);
    sx = abs(DATA.Trans(1,1));
    sy = abs(DATA.Trans(2,2));
    Ref_Im_x = double([0 nx])*sx;
    Ref_Im_y = double([0 ny])*sy;
    
    env = abs(hilbert(prf));
   
%     imagesc(Ref_Im_x, Ref_Im_y,env);
%     colormap(gray);
    plot(prf(1:1000,64));%plot(env(:,33))
    drawnow;
end

igtlclose(sd);

close all;