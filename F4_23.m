% This script is to simulate Fig 4.23 on Page 121, Nonlinear Fiber Optics (5th Edition)
% By Jiaye Wu, Copyright 2018. Distribute under Apache licence 2.0 and Additional Terms of Use.
% Ultilizing SSPROP-NFOL, https://github.com/TerenceWSK/SSPROP-NFOL.

close all

T = 100;                                % time window (period)
nt = 2^12;                              % number of points
dt = T/nt;                              % timestep (dt)
t = ((1:nt)'-(nt+1)/2)*dt;              % time vector

alpha = 0;

gamma = 2;                           % N^2
w = wspace(T,nt);                       % angular frequency vector
vs = fftshift(w/(2*pi));                % shifted for plotting

zz = 0:0.1:8;                           % draw distance

C = 0;
m = 1;

Umesh1 = zeros(length(zz),length(t));
Vmesh1 = zeros(length(zz),length(t));
Umesh2 = zeros(length(zz),length(t));
Vmesh2 = zeros(length(zz),length(t));

for TimeOfRun = 1:1:2
    
    if TimeOfRun == 1
        betap = [0,0,1,0];						% dispersion polynomial
    end
    
    if TimeOfRun == 2
        betap = [0,0,-0.1,0];						% dispersion polynomial
    end
    
    counter = 1;
    
    u0 = gaussian(t,0,1,1,m,C);
    
    for zLD = 0:0.1:8
    
        z = zLD;
        nz = 500;                               % total number of steps
        dz = z/nz;                              % step-size

        u1 = sspropc(u0,dt,dz,nz,alpha,betap,gamma,0.03);
        U = fftshift(abs(dt*fft(u1)/sqrt(2*pi)).^2);

        if TimeOfRun == 1
            Umesh1(counter,:) = abs(u1).^2;
            Vmesh1(counter,:) = U;
        end
        
        if TimeOfRun == 2
            Umesh2(counter,:) = abs(u1).^2;
            Vmesh2(counter,:) = U;
        end

        counter = counter + 1;

    end
    
end

subplot(1,4,1)
mesh(t, zz, Umesh1)
xlabel('Time ($T/T_0$)','Interpreter','latex','fontsize',16)
ylabel('Distance ($z/L_D$)','Interpreter','latex','fontsize',16)
xlim([-20,20])
ylim([0,8])
title('(a)')
angle = [0,90];
view(angle)
map = gray;
map = map(end:-1:1,:);
colormap(map)
colorbar
hold on
    
subplot(1,4,2)
mesh(vs, zz, Vmesh1)
xlabel('$(\nu-\nu_0)T_0$','Interpreter','latex','fontsize',16)
ylabel('Distance ($z/L_D$)','Interpreter','latex','fontsize',16)
xlim([-2,2])
ylim([0,8])
title('(b)')
angle = [0,90];
view(angle)
map = gray;
map = map(end:-1:1,:);
colormap(map)
colorbar

subplot(1,4,3)
mesh(t, zz, Umesh2)
xlabel('Time ($T/T_0$)','Interpreter','latex','fontsize',16)
ylabel('Distance ($z/L_D$)','Interpreter','latex','fontsize',16)
xlim([-10,50])
ylim([0,8])
%axis([-10 50 0 8 0 1]); 
title('(a)')
angle = [0,90];
view(angle)
map = gray;
map = map(end:-1:1,:);
colormap(map)
colorbar
hold on
    
subplot(1,4,4)
mesh(vs, zz, Vmesh2)
xlabel('$(\nu-\nu_0)T_0$','Interpreter','latex','fontsize',16)
ylabel('Distance ($z/L_D$)','Interpreter','latex','fontsize',16)
xlim([-3,1])
ylim([0,8])
%axis([-3 1 0 8 0 1]); 
title('(b)')
angle = [0,90];
view(angle)
map = gray;
map = map(end:-1:1,:);
colormap(map)
colorbar
