%% Tone Gen
Fs = 44.1e3;

pause(5)
ch = gen_chirp(10e3, 20e3, 50e-3, Fs, 1);
 
sound(ch, Fs)
pause(1);

%audiowrite('10k_20k_1pt.wav', ch, Fs);
%% Filter
% 3 bursts @ 15cm
[y, Fs] = audioread('sweeps/moving_40cm.wav');

Fstop = 5e3;
Fpass = 8e3;
Astop = 85;
Apass = 0.25;

d = designfilt('highpassfir','StopbandFrequency',Fstop, ...
  'PassbandFrequency',Fpass,'StopbandAttenuation',Astop, ...
  'PassbandRipple',Apass,'SampleRate',Fs,'DesignMethod','equiripple');

hpf_data = filter(d, y);
t = (1:length(hpf_data))/Fs;
%plot(t, hpf_data)

%% Spectogram
nfft = 512;
noverlap = 500;
spectrogram(hpf_data, nfft, noverlap, nfft*2, Fs,'MinThreshold', -100, 'yaxis');
%xlim([2.7 ,3]);
%ylim([16.5, 21])

%% Correlation
len_tx = length(ch);
len_rx = length(hpf_data);

[acor, lag] = xcorr(hpf_data, ch);
%plot(lag, acor);

[~, I] = max(abs(acor));
lagDiff = lag(I);


%% Truncate + File Write
clipped_rx = hpf_data(lagDiff : lagDiff + len_tx-1);
audiowrite('rx_clipped_40cm.wav', clipped_rx, Fs);

%% Calc Dist
close all;
dst_calc('10k_20k_1pt.wav', 'rx_clipped_30cm.wav', 330)
title('30cm, with Brady [?]')
figure();
dst_calc('10k_20k_1pt.wav', 'rx_clipped_40cm.wav', 330)
title('40cm')
figure();
dst_calc('10k_20k_1pt.wav', 'rx_clipped_50cm.wav', 330)
title('50cm, with Brady [?]')


%% subtract shift from delta D between phone mic and laptop speaker

subplot(211); plot(ch);
subplot(212); plot(clipped_rx)



