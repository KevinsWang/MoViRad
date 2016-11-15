%% Load Audio Files

% go to whichever directory holds the audio samples
% cd('audio samples')

% audioread loads the sound files
% y returns the vector 
% Fs returns the sampling rate
[y, Fs] = audioread('15k_20k_50ms.wav');
% audioread('10k_20k_50ms.wav');
% audioread('18k_20k_50ms.wav');

% sound() plays the file
sound(y);


%% Audio HW Info
info = audiodevinfo; % returns a struct with all audio I/O

%% Record Audio
% make a new recorder object
recorder1 = audiorecorder(44100,16,1,1); 

record(recorder1); % start recording
pause(5);          % wait for X long
stop(recorder1);   % stop recording

%% Get Audio
samples = recorder1.getaudiodata;