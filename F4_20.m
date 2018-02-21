% This script is to simulate Fig 4.20 on Page 118, Nonlinear Fiber Optics (5th Edition)
% By Jiaye Wu, Copyright 2018. Distribute under Apache licence 2.0 and Additional Terms of Use.
% Ultilizing SSPROP-NFOL, https://github.com/TerenceWSK/SSPROP-NFOL.

close all

T = 60;              					% FFT window size / rep rate
nt = 2^12;                              % number of points in FFT
dt = T/nt;                              % normalized time step
z = 20;                           		% total distance
nz = 1000;                              % total number of steps
dz = z/nz;                              % step-size

t = ((1:nt)'-(nt+1)/2)*dt;              % vector of t values
w = wspace(t);                          % vector of w values
vs = fftshift(w/(2*pi));                % used for plotting

s = 0.01;								% toptical/(2*pi*T0)

u0 = gaussian(t,0,2*(sqrt(log(2))));

u = sspropc(u0,dt,dz,nz,0,1,1,0,2*pi*s);
%I = exp(-0.5 .* (1 + 1j .* C) .* (TT0 .^ (2 .* m)))
U = fftshift(abs(dt*fft(u)/sqrt(2*pi)).^2);

plot (vs,U);
xlim([-4 6]);
grid on;
xlabel('Frequency, $(\nu-\nu_0)T_0$','Interpreter','latex','fontsize',16)
ylabel('Intensity','Interpreter','latex','fontsize',16)
text(2,0.16,'z/L_{NL} = 20, s = 0.01')
hold on
