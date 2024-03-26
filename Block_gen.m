%% Block_gen 함수 : Modulation type에 따라 Block length만큼의 symbol으로 구성된 block 생성
function [B,mod_order]=Block_gen(mod_type, block_length)
switch mod_type
    case mod_type=='BPSK' | mod_type=='bpsk'
        s=[1 ;-1];
        c=[0; 1];
        mod_order=1;
    case mod_type=='QPSK' | mod_type=='qpsk'
        s=[1 ;1j ;-1 ;-1j ];
        c=[0 0;1 0;1 1;0 1];
        mod_order=2;
    case mod_type=='8-PSK' | mod_type=='8PSK' | mod_type=='8psk' | mod_type=='8-psk'
        s=[1;sqrt(1/2)*(1+1j);1j;sqrt(1/2)*(-1+1j);-1; ...
            sqrt(1/2)*(-1-1j);-1j,sqrt(1/2)*(1-1j)];
        c=[0 0 0; 0 0 1; 1 0 1; 1 0 0; 1 1 0; ...
           1 1 1; 0 1 1; 0 1 0];
        mod_order=3;
    case mod_type=='16-QAM' | mod_type=='16QAM' | mod_type=='16-qam' | mod_type=='16qam'
        s=[sqrt(1/10)*(1+1j); sqrt(1/10)*(3+1j); sqrt(1/10)*(3+3j); sqrt(1/10)*(1+3j);...
            sqrt(1/10)*(-1+1j); sqrt(1/10)*(-3+1j); sqrt(1/10)*(-3+3j); sqrt(1/10)*(-1+3j);...
            sqrt(1/10)*(-1-1j); sqrt(1/10)*(-3-1j); sqrt(1/10)*(-3-3j); sqrt(1/10)*(-1-3j);...
            sqrt(1/10)*(1-1j); sqrt(1/10)*(3-1j); sqrt(1/10)*(3-3j); sqrt(1/10)*(1-3j)];
        c=[1 1 1 1; 1 0 1 1; 1 0 1 0; 1 1 1 0;...
           0 1 1 1; 0 0 1 1; 0 0 1 0; 0 1 1 0;...
           0 1 0 1; 0 0 0 1; 0 0 0 0; 0 1 0 0;...
           1 1 0 1; 1 0 0 1; 1 0 0 0; 1 1 0 0];
        mod_order=4;
end
B=zeros(2^mod_order,1+length(c(1,:)));
for i=1:block_length
    index=randi(2^mod_order);
    B(i,1)=s(index);
    for j=1:length(c(1,:))
        B(i,j+1)=c(index,j);
    end
end
end