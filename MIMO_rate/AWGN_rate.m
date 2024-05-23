close all; clear; clc;

%% Parameter Setting
P_db=0:4:40;
P=10.^(P_db/10);
iter=10^5;
sq=sqrt(1/2);
ergodic_rate=zeros(1,length(P));

% Monte Carlo Simulation
for j=1:length(P)
    rate_sum=0;
    for i=1:iter
        rate=log2(1+P(j));
        rate_sum=rate_sum+rate;
    end
    ergodic_rate(j)=rate_sum/iter;
end

save("AWGN_SISO_rate.mat","ergodic_rate");
plot(P_db,ergodic_rate,'b-'); grid on;