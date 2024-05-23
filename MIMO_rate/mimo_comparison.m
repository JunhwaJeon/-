close all; clear; clc;

iter=10^6;
awgn_H=ones(4,4);
awgn_D=svd(awgn_H);
awgn_rate=0; ray_rate=0;

for i=1:iter
    H=sqrt(1/2)*complex(randn(4),randn(4));
    D=svd(H);
    for j=1:4
        awgn_rate=awgn_rate+norm(1+awgn_D(j)^2);
        ray_rate=ray_rate+norm(1+D(j)^2);
    end
end

rayleigh=ray_rate/iter;
awgn=awgn_rate/iter;