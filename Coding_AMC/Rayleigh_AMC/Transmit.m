%% input symbol 을 Transmit 했을때 출력
function [output, channel_info]=Transmit(input,chan_type,sig_power_linear)
    switch chan_type
        case {'AWGN','awgn'}
            channel_info=sqrt(sig_power_linear);
            output=channel_info*input+sqrt(1/2)*(randn()+1j*randn());
        case 'Rayleigh'
            channel_info=sqrt(1/2)*(randn()+1j*randn())*sqrt(sig_power_linear);
            output=channel_info*input+sqrt(1/2)*(randn()+1j*randn());
    end
end