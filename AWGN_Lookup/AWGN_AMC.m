Bpsk=load("BPSK_AWGN.mat").BP_awgn;
Qpsk=load("QPSK_AWGN.mat").QP_awgn;
Eight_psk=load("8_PSK_AWGN.mat").P8_awgn;
Sixteen_qam=load("16QAM_AWGN.mat").Q16_awgn;
Sixtyfour_qam=load("64QAM_AWGN.mat").Q64_awgn;

awgn=[Bpsk; Qpsk; Eight_psk; Sixteen_qam; Sixtyfour_qam;];

P_db=0:0.1:30;
awgn_amc=zeros(1,length(P_db));
for i=1:length(P_db)
    awgn_amc(i)=max(awgn(:,i));
end

plot(P_db,Bpsk,':r'); hold on; grid on;
plot(P_db,Qpsk,':g');
plot(P_db,Eight_psk,':m');
plot(P_db,Sixteen_qam,':y');
plot(P_db,Sixtyfour_qam,':c');
plot(P_db, awgn_amc,'-b');

title("AWGN channel Adaptive Modulation")
xlabel("Signal Power [dB]");
ylabel("Throughput [bps]");
legend("BPSK", "QPSK","8-PSK","16-QAM","64-QAM","Adaptive Modulation")