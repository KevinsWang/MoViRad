%% 10s, 18k-20k
Fs = 44.1e3;
ch = gen_chirp(10e3, 20e3, 50e-3, Fs, 200);
pause(3)
sound(ch, Fs);

%audiowrite('sweeps/10s_sweep.wav', ch, Fs);

%% 60s, 20kHz
% Fs = 44.1e3;
% ch = gen_chirp(0, 20e3, 60, Fs, 1);
% sound(ch, Fs)
[y, Fs] = audioread('Record_0001.wav');

nfft = 8e3;
noverlap = 5e3;
spectrogram(y, nfft, noverlap, nfft, Fs);
title('60s, 20kHz Chirp, Motorola Droid Turbo (Fs=44.1kS/s)')

%% 2s, 18-20kHz, 5x
% Fs = 44.1e3;
% ch = gen_chirp(18e3, 20e3, 2, Fs, 5);
% sound(ch, Fs);

[y, Fs] = audioread('18k_to_20k_2s.wav');

nfft = 8e3;
noverlap = 5e3;
spectrogram(y, nfft, noverlap, nfft, Fs);
title('2s, 18-20kHz Chirp, 5x, Droid Turbo (Fs=44.1kS/s)')

%% 50ms, 18-20kHz, 10x
% Fs = 44.1e3;
% ch = gen_chirp(18e3, 20e3, 50e-3, Fs, 10);
% sound(ch, Fs);

[y, Fs] = audioread('Record_0003.wav');
y = y(55e3 : 85e3);
nfft = 512;
noverlap = 510;
spectrogram(y, nfft, noverlap, nfft, Fs, 'yaxis', 'MinThreshold', -80);
title('50ms, 18-20kHz Chirp, 10x, Droid Turbo (Fs=44.1kS/s)')