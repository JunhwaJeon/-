%% 각 파워당 BLER을 구하고, BLER 이용해 Throughput 정보 반환
function Throughput=BLER(block_length, mod_type, channel_type, demod_type)
% Parameters

iter=10^5;
P_db=0:0.1:30;
P=10.^(P_db./10);
Block_error=linspace(0,0,length(P));
Throughput=linspace(0,0,length(P));
switch mod_type
    case {'BPSK', 'bpsk'}
        mod_order=1;
    case {'QPSK','qpsk'}
        mod_order=2;
    case {'8-PSK','8PSK','8psk','8-psk'}
        mod_order=3;
    case {'16-QAM','16QAM','16-qam','16qam'}
        mod_order=4;
    case {'64-QAM','64QAM','64-qam','64qam'}
        mod_order=6;
end

for l=1:length(P)
    BLE=0; % 모든 시뮬레이션 후의 블록 에러 개수
for i=1:iter % Monte-Carlo simulation
    Block=Block_gen(mod_type,block_length);
    for j=1:block_length % Block 내의 각각 symbol에 대해
        [sym_temp,channel_info]=Transmit(Block(j,1),channel_type,P(l));
        [y,~]=Demodul(sym_temp,mod_type,demod_type,channel_info);
        if Block(j,1)~=y
            BLE=BLE+1;
            break;
        end
    end
end
    Block_error(l)=BLE/iter;
    Throughput(l)=(mod_order*block_length)*(1-Block_error(l));
end
end