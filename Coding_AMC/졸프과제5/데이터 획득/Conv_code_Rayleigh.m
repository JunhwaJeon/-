close all; clear; clc;
%% Rayleigh Channel에서 Convolution code, AMC 적용시 throughput 정보 얻기

%% Select Modulation Scheme
% BPSK for ~2dB QPSK for 2~7.5dB 8-PSK for 7.5~10dB 
% 16-QAM for 10~16dB 64-QAM for 16dB~

%% Parameter Setting
iter=10^5;
P_db=0:1:30;
P=10.^(P_db./10);

%% Error count, Throughput
Block_error=zeros(1,length(P));
Throughput=zeros(1,length(P));

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
        if SNR<2
            mod="BPSK";
            mod_order=1;
            s=[1 ;-1];
            c=[0; 1];
        elseif 2<=SNR && SNR<7.5
            mod="QPSK";
            mod_order=2;
            s=[1 ;1j ;-1 ;-1j ];
            c=[0 0;1 0;1 1;0 1];
        elseif 7.5<=SNR && SNR<10
            mod="8-PSK";
            mod_order=3;
            s=[1;sqrt(1/2)*(1+1j);1j;sqrt(1/2)*(-1+1j);-1; ...
            sqrt(1/2)*(-1-1j);-1j;sqrt(1/2)*(1-1j)];
            c=[0 0 0; 0 0 1; 1 0 1; 1 0 0; 1 1 0; ...
            1 1 1; 0 1 1; 0 1 0];
        elseif 10<=SNR && SNR<16
            mod="16-QAM";
            mod_order=4;
            s=[sqrt(1/10)*(1+1j); sqrt(1/10)*(3+1j); sqrt(1/10)*(3+3j); sqrt(1/10)*(1+3j);...
            sqrt(1/10)*(-1+1j); sqrt(1/10)*(-3+1j); sqrt(1/10)*(-3+3j); sqrt(1/10)*(-1+3j);...
            sqrt(1/10)*(-1-1j); sqrt(1/10)*(-3-1j); sqrt(1/10)*(-3-3j); sqrt(1/10)*(-1-3j);...
            sqrt(1/10)*(1-1j); sqrt(1/10)*(3-1j); sqrt(1/10)*(3-3j); sqrt(1/10)*(1-3j)];
            c=[1 1 1 1; 1 0 1 1; 1 0 1 0; 1 1 1 0;...
            0 1 1 1; 0 0 1 1; 0 0 1 0; 0 1 1 0;...
            0 1 0 1; 0 0 0 1; 0 0 0 0; 0 1 0 0;...
            1 1 0 1; 1 0 0 1; 1 0 0 0; 1 1 0 0];
        else
            mod="64-QAM";
            mod_order=6;
            s=sqrt(1/42)*...
            [(-7-7j);(-7-5j);(-7-3j);(-7-1j);(-7+1j);(-7+3j);(-7+5j);(-7+7j);...
            (-5-7j);(-5-5j);(-5-3j);(-5-1j);(-5+1j);(-5+3j);(-5+5j);(-5+7j);...
            (-3-7j);(-3-5j);(-3-3j);(-3-1j);(-3+1j);(-3+3j);(-3+5j);(-3+7j);...
            (-1-7j);(-1-5j);(-1-3j);(-1-1j);(-1+1j);(-1+3j);(-1+5j);(-1+7j);...
            (1-7j);(1-5j);(1-3j);(1-1j);(1+1j);(1+3j);(1+5j);(1+7j);...
            (3-7j);(3-5j);(3-3j);(3-1j);(3+1j);(3+3j);(3+5j);(3+7j);...
            (5-7j);(5-5j);(5-3j);(5-1j);(5+1j);(5+3j);(5+5j);(5+7j);...
            (7-7j);(7-5j);(7-3j);(7-1j);(7+1j);(7+3j);(7+5j);(7+7j)];
            c=[0 0 0 0 0 0; 0 0 0 0 0 1; 0 0 0 0 1 1; 0 0 0 0 1 0; 0 0 0 1 1 0; 0 0 0 1 1 1; 0 0 0 1 0 1; 0 0 0 1 0 0;...
               0 0 1 0 0 0; 0 0 1 0 0 1; 0 0 1 0 1 1; 0 0 1 0 1 0; 0 0 1 1 1 0; 0 0 1 1 1 1; 0 0 1 1 0 1; 0 0 1 1 0 0;...
               0 1 1 0 0 0; 0 1 1 0 0 1; 0 1 1 0 1 1; 0 1 1 0 1 0; 0 1 1 1 1 0; 0 1 1 1 1 1; 0 1 1 1 0 1; 0 1 1 1 0 0;...
               0 1 0 0 0 0; 0 1 0 0 0 1; 0 1 0 0 1 1; 0 1 0 0 1 0; 0 1 0 1 1 0; 0 1 0 1 1 1; 0 1 0 1 0 1; 0 1 0 1 0 0;...
               1 1 0 0 0 0; 1 1 0 0 0 1; 1 1 0 0 1 1; 1 1 0 0 1 0; 1 1 0 1 1 0; 1 1 0 1 1 1; 1 1 0 1 0 1; 1 1 0 1 0 0;...
               1 1 1 0 0 0; 1 1 1 0 0 1; 1 1 1 0 1 1; 1 1 1 0 1 0; 1 1 1 1 1 0; 1 1 1 1 1 1; 1 1 1 1 0 1; 1 1 1 1 0 0;...
               1 0 1 0 0 0; 1 0 1 0 0 1; 1 0 1 0 1 1; 1 0 1 0 1 0; 1 0 1 1 1 0; 1 0 1 1 1 1; 1 0 1 1 0 1; 1 0 1 1 0 0;...
               1 0 0 0 0 0; 1 0 0 0 0 1; 1 0 0 0 1 1; 1 0 0 0 1 0; 1 0 0 1 1 0; 1 0 0 1 1 1; 1 0 0 1 0 1; 1 0 0 1 0 0];
        end
        Source=randi([0 1],1,10*mod_order); % Generate Source Bits
        R_succ=true; % 수신 성공 여부
        T_sig=zeros(1,20); % Transmitted Signal
        R_sig=zeros(1,20); % Recieved Signal
        D_symb=[]; % Decoded/Detected Signal

        % Convolutional encoding
        trellis=poly2trellis(7, [133 171]);
        Encoded=convenc(Source,trellis);

        % Symbol mapping
        for j=1:20
            for k=1:length(c(:,1))
                if c(k,:)==Encoded(mod_order*(j-1)+1:mod_order*j)
                    index=k;
                    break
                end
            end
            T_sig(j)=s(index);
        end

        % Transmitting Symbol
        for j=1:20
            R_sig(j)=T_sig(j)*channel_info+sqrt(1/2)*(randn()+1j*randn());
        end

        % Detecting Symbol
        for j=1:20
            dist=linspace(0,0,length(s));
            for k=1:length(s)
                dist(k)=norm(R_sig(j)*conj(channel_info)/norm(channel_info)-norm(channel_info)*s(k));
            end
            [~,index]=min(dist);
            D_symb=[D_symb c(index,:)];
        end
    end
    Block_error(l)=BLE/iter;
    Throughput(l)=T_bit/iter;
end

save('Conv_Code_Rayleigh_AMC.mat',"Throughput");