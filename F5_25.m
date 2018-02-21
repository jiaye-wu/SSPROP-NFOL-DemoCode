% This script is to simulate Fig 5.25 on Page 182, Nonlinear Fiber Optics (5th Edition)
% By Jiaye Wu, Copyright 2018. Distribute under Apache licence 2.0 and Additional Terms of Use.
% Ultilizing SSPROP-NFOL, https://github.com/TerenceWSK/SSPROP-NFOL.

close all

T = 200;                                % time window (period)
nt = 2^12;                              % number of points
dt = T/nt;                              % timestep (dt)
t = ((1:nt)'-(nt+1)/2)*dt;              % time vector

alpha = 0;
betap = [0,0,-1,0];						% dispersion polynomial

gamma = 1^2;                            % N^2
w = wspace(T,nt);                       % angular frequency vector
vs = -fftshift(w/(2*pi));                % shifted for plotting

zz = 0:0.01:2;                          % draw distance

order = 4;

Umesh = zeros(length(zz),length(t));
Vmesh = zeros(length(zz),length(t));

counter = 1;
    
for zLD = 0:0.01:2

    z = zLD;
    nz = 500;                               % total number of steps
    dz = z/nz;                              % step-size

    u0 = solitonpulse(t,0,1,order);
    u1 = sspropc(u0,dt,dz,nz,alpha,betap,gamma,0.1,0.03);
    U = fftshift(abs(dt*fft(u1)/sqrt(2*pi)).^2);

    Umesh(counter,:) = abs(u1).^2;
    Vmesh(counter,:) = U;

    counter = counter + 1;

end

subplot(1,2,1)
mesh(t, zz, Umesh)
xlabel('Time ($T/T_0$)','Interpreter','latex','fontsize',16)
ylabel('Distance ($z/L_D$)','Interpreter','latex','fontsize',16)
axis([-20 60 0 2]); 
title('(a)')
angle = [0,90];
view(angle)
map = gray;
map = map(end:-1:1,:);
colormap(map)
colorbar
hold on
    
subplot(1,2,2)
mesh(vs, zz, Vmesh)
xlabel('$(\nu-\nu_0)T_0$','Interpreter','latex','fontsize',16)
ylabel('Distance ($z/L_D$)','Interpreter','latex','fontsize',16)
axis([-4 6 0 2]); 
title('(b)')
angle = [0,90];
view(angle)
map = gray;
map = map(end:-1:1,:);
colormap(map)
colorbar

