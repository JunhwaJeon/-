%% Block_gen 함수 : Modulation type에 따라 Block length만큼의 symbol으로 구성된 block 생성
function [B,mod_order]=Block_gen(mod_type, block_length)
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
B=zeros(block_length,1+mod_order);
for i=1:block_length
    [sym,code]=Modul(mod_type);
    for j=1:mod_order
        B(i,1)=sym;
        B(i,j+1)=code(j);
    end
end
end