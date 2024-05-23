close all; clear; clc;

%% Parameter Setting
P_db=0:4:40;
P=10.^(P_db/10);
iter=10^5;
sq=sqrt(1/2);
ergodic_rate=zeros(1,length(P));
N=4; % MIMO Scale


for j=1:length(P)
    rate_sum=0;
    for i=1:iter
        H=sq*complex(randn(N),randn(N)); % channel generation
        A=normalize(inv(H)); % normalizing column vector of inverse channel matrix
        Z=A*H; % Zero-Forced channel
        for k=1:length(Z(1,:))
            rate_sum=rate_sum+log2(1+(norm(Z(k,k))^2)*P(j)/N);
        end
    end
    ergodic_rate(j)=rate_sum/iter;
end

plot(P_db,ergodic_rate(:),'g-'); hold on; grid on;
%plot(P_db,ergodic_rate(2,:),'b-');
%plot(P_db,ergodic_rate(3,:),'r-');
title('Ergodic Rate');
%legend('AWGN-SISO','Rayleigh-SISO','Rayleigh-4x4MIMO');
legend('Zero-Forcing 4x4MIMO')
xlabel('Transmit SNR [dB]'); ylabel('Ergodic Rate [bps]');