function [ ch ] = gen_chirp( fstart, fstop, time, Fs, copies)
%GEN_CHIRP 
%   Chirp Signal Generator
%   Generates a chirp signal in time domain from frequency Fstart to Fstop
%   with length time and sampling rate Fs
%   
%   Parameters
%       fstart: starting frequency [Hz]
%       fstop:  stop frequency [Hz]
%       time:   time-length of single chirp [s]
%       Fs:     sampling rate [Samp/s]
%       copies: # of duplications of chirp 
%
%   Returns
%       ch: time domain chirp signal

t = 0 : 1/Fs : time;
y = chirp(t, fstart, time, fstop);

filt = 0;
if filt
    len_filt = floor(length(t)*0.01);
    tri_filt = linspace(0, 1, len_filt);

    y(1:len_filt) = y(1:len_filt) .* tri_filt;

    tri_filt = fliplr(tri_filt);
    y(end-len_filt+1 : end) = y(end-len_filt+1 : end) .* tri_filt;
end

if copies < 1
    copies = 1;
end
ch = repmat(y, 1, copies);

end

