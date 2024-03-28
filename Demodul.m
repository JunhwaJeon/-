%% Demodul 함수 : 수신 신호 s 에 대해 Modulation type에 따른 symbol demodulation
function [y,code]=Demodul(r, mod_type, demod_type, channel_info)
switch mod_type
    case {'BPSK', 'bpsk'}
        s=[1 ;-1];
        c=[0; 1];
    case {'QPSK','qpsk'}
        s=[1 ;1j ;-1 ;-1j ];
        c=[0 0;1 0;1 1;0 1];
    case {'8-PSK','8PSK','8psk','8-psk'}
        s=[1;sqrt(1/2)*(1+1j);1j;sqrt(1/2)*(-1+1j);-1; ...
            sqrt(1/2)*(-1-1j);-1j;sqrt(1/2)*(1-1j)];
        c=[0 0 0; 0 0 1; 1 0 1; 1 0 0; 1 1 0; ...
           1 1 1; 0 1 1; 0 1 0];
    case {'16-QAM','16QAM','16-qam','16qam'}
        s=[sqrt(1/10)*(1+1j); sqrt(1/10)*(3+1j); sqrt(1/10)*(3+3j); sqrt(1/10)*(1+3j);...
            sqrt(1/10)*(-1+1j); sqrt(1/10)*(-3+1j); sqrt(1/10)*(-3+3j); sqrt(1/10)*(-1+3j);...
            sqrt(1/10)*(-1-1j); sqrt(1/10)*(-3-1j); sqrt(1/10)*(-3-3j); sqrt(1/10)*(-1-3j);...
            sqrt(1/10)*(1-1j); sqrt(1/10)*(3-1j); sqrt(1/10)*(3-3j); sqrt(1/10)*(1-3j)];
        c=[1 1 1 1; 1 0 1 1; 1 0 1 0; 1 1 1 0;...
           0 1 1 1; 0 0 1 1; 0 0 1 0; 0 1 1 0;...
           0 1 0 1; 0 0 0 1; 0 0 0 0; 0 1 0 0;...
           1 1 0 1; 1 0 0 1; 1 0 0 0; 1 1 0 0];
end

switch demod_type
    case 'Rayleigh_coherent'
        dist=linspace(0,0,length(s));
        r2=r*conj(channel_info)/abs(channel_info);
        for k=1:length(s)
            dist(k)=norm(r2-s(k));
        end
        [~,l]=min(dist);
        y=s(l); code=c(l,:);
    case {'Noncoherent',isempty(demod_type)==True}
        dist=linspace(0,0,length(s));
        for k=1:length(s)
            dist(k)=norm(r-s(k));
        end
        [~,l]=min(dist);
        y=s(l); code=c(l,:);
end
end