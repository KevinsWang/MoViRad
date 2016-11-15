mobicomm 2016

first session FMCW


%% Load Music Files
[y1, Fs1] = audioread('10k_20k_50ms.wav');
[y2, Fs2] = audioread('15k_20k_50ms.wav');
[y3, Fs3] = audioread('18k_20k_50ms.wav');
[long, Fslong] = audioread('5k_15k_5s.wav');
[char, Fschar] = audioread('15k_20k_5s.wav');
[short, Fsshort] = audioread('5k_10k_50ms.wav');
[low, Fslow] = audioread('5k_10k_50ms.wav');
[doublelong, Fsdl] = audioread('18k_20k_long.wav');

%%
close all;
recorder1 = audiorecorder(44100,16,1,1); 

record(recorder1); % start recording
pause(1.5);
sound(short, Fs1);
pause(1.5);
stop(recorder1);   % stop recording

%%
Fstop = 1e3;
Fpass = 2e3;
Astop = 85;
Apass = 0.25;
Fs = 44.1e3;

d = designfilt('highpassfir','StopbandFrequency',Fstop, ...
  'PassbandFrequency',Fpass,'StopbandAttenuation',Astop, ...
  'PassbandRipple',Apass,'SampleRate',Fs,'DesignMethod','equiripple');

hpf_data = filter(d, recorder1.getaudiodata);
hold on;
subplot(211); 
plot(long);
subplot(212); 
plot(hpf_data);
%%
subplot(211); spectrogram(short, 128, 120, 128, 44.1e3);
subplot(212); spectrogram(hpf_data, 128*40, 128*39, 128*10, 44.1e3);
%%
rx_sig = recorder1.getaudiodata;
len_tx = size(short);
len_rx = size(rx_sig);

sweep_len = len_rx - len_tx;

[acor, lag] = xcorr(rx_sig, short);
[~, I] = max(abs(acor));
lagDiff = lag(I);

plot(lag, acor)
%%
clipped_rx = rx_sig(lagDiff : lagDiff + len_tx-1);
audiowrite('test1.wav', clipped_rx, Fs1);

%%
subplot(211); plot(clipped_rx);
subplot(212); plot(long);
%%

dst_calc('5k_10k_50ms.wav', 'test1.wav', 340)
