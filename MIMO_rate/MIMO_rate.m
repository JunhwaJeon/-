close all; clear; clc;

%% Parameter Setting
P_db=0:4:40;
P=10.^(P_db/10);
iter=10^5;
sq=sqrt(1/2);
ergodic_rate=zeros(3,length(P));
N=4; % MIMO Scale

for ant_case=1:3
    for j=1:length(P)
        rate_sum=0;
        for i=1:iter
            if ant_case==1 % AWGN-SISO
                rate_sum=rate_sum+log2(1+P(j));
            elseif ant_case==2 % Rayleigh-SISO
                h=sq*(randn()+1j*randn());
                rate_sum=rate_sum+log2(1+(norm(h)^2)*P(j));
            else % Rayleigh-4x4 MIMO
                H=sq*complex(randn(N),randn(N)); D=svd(H);
                for k=1:length(D)
                    rate_sum=rate_sum+log2(1+(norm(D(k))^2)*P(j)/N);
                end
            end
        end
        ergodic_rate(ant_case,j)=rate_sum/iter;
    end
end

save("Ergodic_rate.mat",'ergodic_rate');
plot(P_db,ergodic_rate(1,:),'g-'); hold on; grid on;
plot(P_db,ergodic_rate(2,:),'b-');
plot(P_db,ergodic_rate(3,:),'r-');
title('Ergodic Rate');
legend('AWGN-SISO','Rayleigh-SISO','Rayleigh-4x4MIMO');
xlabel('Transmit SNR [dB]'); ylabel('Ergodic Rate [bps]');