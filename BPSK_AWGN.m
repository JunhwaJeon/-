clear all; close all;
clc;

iter=10^7;
P=[0:1:15];
P_lin=10.^(P./10);
BER=zeros(length(P),1);

for j=1:length(P)
    err=0;
    for i=1:iter
        X=2*randi(1)-1;
        W=randn(1);
        if X==1
            if sqrt(P_lin(j))*X+W<0
                err=err+1;
            end
        else
            if sqrt(P_lin(j))*X+W>0
                err=err+1;
            end
        end
    end
    BER(j)=err/iter;
end

semilogy(P,BER);
xlabel('Transmit Power [dB]'); ylabel('Bit Error Rate');
xlim([0,15]);