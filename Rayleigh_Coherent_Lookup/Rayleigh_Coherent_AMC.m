Throughput=load("Rayleigh_Coherent.mat");
Rayleigh=[Throughput.BP_rayleigh; Throughput.QP_rayleigh; ...
    Throughput.P8_rayleigh; Throughput.Q16_rayleigh; Throughput.Q64_rayleigh];

P_db=0:0.1:30;
rayleigh_amc=zeros(1,length(P_db));
for i=1:length(P_db)
    rayleigh_amc(i)=max(Rayleigh(:,i));
end

plot(P_db,Throughput.BP_rayleigh,':r'); hold on; grid on;
plot(P_db,Throughput.QP_rayleigh,':g');
plot(P_db,Throughput.P8_rayleigh,':m');
plot(P_db,Throughput.Q16_rayleigh,':y');
plot(P_db,Throughput.Q64_rayleigh,':c');
plot(P_db, rayleigh_amc,'-b');

title("Rayleigh channel Adaptive Modulation")
xlabel("Signal Power [dB]");
ylabel("Throughput [bps]");
legend("BPSK", "QPSK","8-PSK","16-QAM","64-QAM","Adaptive Modulation")