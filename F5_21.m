% This script is to simulate Fig 5.21 on Page 176, Nonlinear Fiber Optics (5th Edition)
% By Jiaye Wu, Copyright 2018. Distribute under Apache licence 2.0 and Additional Terms of Use.
% Ultilizing SSPROP-NFOL, https://github.com/TerenceWSK/SSPROP-NFOL.

close all

counter = 1;

T = 100;                                % time window (period)
nt = 2^12;                              % number of points
dt = T/nt;                              % timestep (dt)
t = ((1:nt)'-(nt+1)/2)*dt;              % time vector

alpha = 0;
betap = [0,0,-10];						% dispersion polynomial
gamma = 2^2;                            % N^2

w = wspace(T,nt);                       % angular frequency vector
vs = fftshift(w/(2*pi));                % shifted for plotting

order = 2;
s = 0.2;

for zLD = 0:0.5:5
    
    Line = 'b';
    zLDLabel1 = strcat('$T/T_0, z/L_D = $',num2str(zLD));
    zLDLabel2 = strcat('$(\nu-\nu_0)T_0, z/L_D = $',num2str(zLD));
    
    z = zLD;
    nz = 500;                               % total number of steps
    dz = z/nz;                              % step-size
    
    u0 = solitonpulse(t,0,1,order);
    u1 = sspropc(u0,dt,dz,nz,alpha,betap,gamma,0,s);
    U = fftshift(abs(dt*fft(u1)/sqrt(2*pi)).^2);    
   
    figure(1)
    subplot(3,4,counter)
    plot(t, abs(u1).^2, Line)
    xlabel(zLDLabel1,'Interpreter','latex','fontsize',16)
    ylabel('Intensity','Interpreter','latex','fontsize',16)
    xlim([-10 10]);
    %axis([-10 10 0 30]); 
    %text(3.5,3,'N = 3')
    
    figure(2)
    subplot(3,4,counter)
    plot(vs, U, Line)
    xlabel(zLDLabel2,'Interpreter','latex','fontsize',16)
    ylabel('Intensity','Interpreter','latex','fontsize',16)
    xlim([-4 4]);
    %axis([-4 4 0 15]); 
    
    counter = counter + 1;
end

