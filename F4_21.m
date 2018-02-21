% This script is to simulate Fig 4.21 on Page 119, Nonlinear Fiber Optics (5th Edition)
% By Jiaye Wu, Copyright 2018. Distribute under Apache licence 2.0 and Additional Terms of Use.
% Ultilizing SSPROP-NFOL, https://github.com/TerenceWSK/SSPROP-NFOL.

close all

T = 60;              					% FFT window size / rep rate
nt = 2^12;                              % number of points in FFT
dt = T/nt;                              % normalized time step

t = ((1:nt)'-(nt+1)/2)*dt;              % vector of t values
w = wspace(t);                          % vector of w values
vs = fftshift(w/(2*pi));                % used for plotting

s = 0.01;								% toptical/(2*pi*T0)
C = 0;
m = 1;
alpha = 0;
betap = [0,0,+1];						% dispersion polynomial
N2 = 10.^2;

for TimeOfRun = 1:1:4
    
    if TimeOfRun == 1 || TimeOfRun == 2
        z = 0.2;                           		% total distance
    end
    
    if TimeOfRun == 3 || TimeOfRun == 4
        z = 0.4;                           		% total distance
    end
        
    nz = 1000;                              % total number of steps
    dz = z/nz;                              % step-size
    
    u0 = exp(-0.5 .* (1 + 1j .* C) .* (t .^ (2 .* m)));
    %u0 = exp(-(t - 3 .* s .* u0 .* z));
    u = sspropc(u0,dt,dz,nz,alpha,betap,N2,0,2*pi*s);    
    U = fftshift(abs(dt*fft(u)/sqrt(2*pi)).^2);

    subplot(2,2,TimeOfRun)
    if TimeOfRun == 1 || TimeOfRun == 3
        plot(t,abs(u).^2)
        
        if TimeOfRun == 1
            xlim([-6 6]);
            ylim([0 0.4]);
        end
        
        if TimeOfRun == 3
            xlim([-10 10]);
            ylim([0 0.25]);
        end
        grid on;
        xlabel('Time, $T/T_0$','Interpreter','latex','fontsize',16)
        ylabel('Intensity','Interpreter','latex','fontsize',16)
        hold on
    end
    
    if TimeOfRun == 2 || TimeOfRun == 4
        plot (vs,U);        
        xlim([-4 4]); 
        if TimeOfRun == 2
            ylim([0 0.15]);
        end
        if TimeOfRun == 4
            ylim([0 0.1]);
        end
        grid on;
        xlabel('Frequency, $(\nu-\nu_0)T_0$','Interpreter','latex','fontsize',16)
        ylabel('Intensity','Interpreter','latex','fontsize',16)
        hold on
    end
    
end


