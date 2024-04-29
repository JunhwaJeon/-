%% AWGN Lookup Table
close all; clear; clc;
BP_awgn=BLER(20,'BPSK','AWGN','Noncoherent');

QP_awgn=BLER(20,'QPSK','AWGN','Noncoherent');

P8_awgn=BLER(20,'8-PSK','AWGN','Noncoherent');

Q16_awgn=BLER(20,'16-QAM','AWGN','Noncoherent');

Q64_awgn=BLER(20,'64-QAM','AWGN','Noncoherent');

save("AWGN_Lookup.mat")

