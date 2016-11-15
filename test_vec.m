[state, p] = paths_extract('sweeps/10s_sweep.wav', 'breathing/Brady_v2.wav', 340, 50e-3, 40e-2, 10e3, 20e3, 2);
close all;

%close all
plot(p');

