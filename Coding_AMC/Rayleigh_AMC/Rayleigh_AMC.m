close all; clear; clc;

%% Parameter Setting
iter=10^5;
P_db=0:1:30;
P=10.^(P_db./10);

%% Select Modulation Scheme
% BPSK for 0~6.5dB QPSK for 6.5~12.5dB 8-PSK for 12.5~15dB 
% 16-QAM for 15~21.2dB 64-QAM for 21.2dB~

%% Error count, Throughput
Block_error=linspace(0,0,length(P));
Throughput=linspace(0,0,length(P));

%% BLER, Throughput simulation
for l=1:length(P)
    BLE=0; % 모든 시뮬레이션 후의 블록 에러 개수
    T_bit=0; % 모든 시뮬레이션 후의 전송 성공한 비트 개수
    for i=1:iter % Monte-Carlo simulation
        % 전송 성공 여부
        T_success=true;

        % Obtaining SNR information
        channel_info=sqrt(1/2)*(randn()+1j*randn())*sqrt(P(l));
        SNR=10*log10(norm(channel_info)^2); % SNR in dB scale

        % Selecting Modulation Scheme with SNR information
        if SNR<6.5
            mod="BPSK";
            mod_order=1;
        elseif 6.5<=SNR && SNR<12.5
            mod="QPSK";
            mod_order=2;
        elseif 12.5<=SNR && SNR<15
            mod="8-PSK";
            mod_order=3;
        elseif 15<=SNR && SNR<21.2
            mod="16-QAM";
            mod_order=4;
        else
            mod="64-QAM";
            mod_order=6;
        end
        Block=Block_gen(mod,20);
        for j=1:20 % Block 내의 각각 symbol에 대해
            sym_temp=Block(j,1)*channel_info+sqrt(1/2)*(randn()+1j*randn());
            [y,~]=Demodul(sym_temp,mod,'Rayleigh_coherent',channel_info);
            if Block(j,1)~=y
                BLE=BLE+1;
                T_success=false;
                break;
            end
        end
        if T_success==true
            T_bit=T_bit+20*mod_order;
        end
    end
    Block_error(l)=BLE/iter;
    Throughput(l)=T_bit/iter;
end

save('Rayleigh_AMC.mat',"Throughput");