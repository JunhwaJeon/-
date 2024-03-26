%% Demodul 함수 : 수신 신호 s 에 대해 Modulation type에 따른 symbol demodulation
function [y,code]=Demodul(r, mod_type)
switch mod_type
    case mod_type=='BPSK' | mod_type=='bpsk'
        s=[1 ;-1];
        c=[0; 1];
    case mod_type=='QPSK' | mod_type=='qpsk'
        s=[1 ;1j ;-1 ;-1j ];
        c=[0 0;1 0;1 1;0 1];
    case mod_type=='8-PSK' | mod_type=='8PSK' | mod_type=='8psk' | mod_type=='8-psk'
        s=[1;sqrt(1/2)*(1+1j);1j;sqrt(1/2)*(-1+1j);-1; ...
            sqrt(1/2)*(-1-1j);-1j,sqrt(1/2)*(1-1j)];
        c=[0 0 0; 0 0 1; 1 0 1; 1 0 0; 1 1 0; ...
           1 1 1; 0 1 1; 0 1 0];
    case mod_type=='16-QAM' | mod_type=='16QAM' | mod_type=='16-qam' | mod_type=='16qam'
        s=[sqrt(1/10)*(1+1j); sqrt(1/10)*(3+1j); sqrt(1/10)*(3+3j); sqrt(1/10)*(1+3j);...
            sqrt(1/10)*(-1+1j); sqrt(1/10)*(-3+1j); sqrt(1/10)*(-3+3j); sqrt(1/10)*(-1+3j);...
            sqrt(1/10)*(-1-1j); sqrt(1/10)*(-3-1j); sqrt(1/10)*(-3-3j); sqrt(1/10)*(-1-3j);...
            sqrt(1/10)*(1-1j); sqrt(1/10)*(3-1j); sqrt(1/10)*(3-3j); sqrt(1/10)*(1-3j)];
        c=[1 1 1 1; 1 0 1 1; 1 0 1 0; 1 1 1 0;...
           0 1 1 1; 0 0 1 1; 0 0 1 0; 0 1 1 0;...
           0 1 0 1; 0 0 0 1; 0 0 0 0; 0 1 0 0;...
           1 1 0 1; 1 0 0 1; 1 0 0 0; 1 1 0 0];
end
dist=linspace(0,0,length(s(:,1)));
for k=1:length(s(:,1))
    dist(k)=abs(r-s(k,1));
end
[m,l]=min(dist);
y=s(l); code=c(l);
end