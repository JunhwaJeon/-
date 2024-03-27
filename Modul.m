%% Modul 함수 : Modulation type에 따라 심볼 생성
function [x,code]=Modul(mod_type)
switch mod_type
    case {'BPSK', 'bpsk'}
        s=[1 ;-1];
        c=[0; 1];
        index=randi(2);
        x=s(index); code=c(index);
        mod_order=1;
    case {'QPSK','qpsk'}
        s=[1 ;1j ;-1 ;-1j ];
        c=[0 0;1 0;1 1;0 1];
        mod_order=2;
        index=randi(4);
        x=s(index); code=c(index,:);
    case {'8-PSK','8PSK','8psk','8-psk'}
        s=[1;sqrt(1/2)*(1+1j);1j;sqrt(1/2)*(-1+1j);-1;sqrt(1/2)*(-1-1j);-1j;sqrt(1/2)*(1-1j)];
        c=[0 0 0; 0 0 1; 1 0 1; 1 0 0; 1 1 0;1 1 1; 0 1 1; 0 1 0];
        mod_order=3;
        index=randi(8);
        x=s(index);
        code=c(index,:);
    case {'16-QAM','16QAM','16-qam','16qam'}
        s=[sqrt(1/10)*(1+1j); sqrt(1/10)*(3+1j); sqrt(1/10)*(3+3j); sqrt(1/10)*(1+3j);sqrt(1/10)*(-1+1j); sqrt(1/10)*(-3+1j); sqrt(1/10)*(-3+3j); sqrt(1/10)*(-1+3j);...
            sqrt(1/10)*(-1-1j); sqrt(1/10)*(-3-1j); sqrt(1/10)*(-3-3j); sqrt(1/10)*(-1-3j);sqrt(1/10)*(1-1j); sqrt(1/10)*(3-1j); sqrt(1/10)*(3-3j); sqrt(1/10)*(1-3j)];
        c=[1 1 1 1; 1 0 1 1; 1 0 1 0; 1 1 1 0;...
           0 1 1 1; 0 0 1 1; 0 0 1 0; 0 1 1 0;...
           0 1 0 1; 0 0 0 1; 0 0 0 0; 0 1 0 0;...
           1 1 0 1; 1 0 0 1; 1 0 0 0; 1 1 0 0];
        mod_order=4;
        index=randi(16);
        x=s(index); code=c(index,:);
end
end

