function d_est2=dst_calc(file_speaker,file_mic,c)
tic
dmax=1;
fmin=10e3;
fmax=20e3;
Ts=50e-3;
k=(fmax-fmin)/Ts;
[x, fs]=audioread(file_speaker);
t_sample=1/fs;
%  y= [zeros(50,1); x(1:end-50)];
y=audioread(file_mic);
taw_max=dmax/c;
index=round(taw_max/t_sample);
y_down=y.*x;
y_crop=y_down(index+1:end);
plot(abs(fft(y_crop)))
fft_y_t=fft(y_crop);

fft_y=fft_y_t(1:round((2*dmax/c*k)*Ts));
accuracy=1/(t_sample*length(y_crop))/k*c/2
plot((0:length(fft_y)-1)*accuracy,abs(fft_y))
[maxm, d_ind_1]=findpeaks(abs(fft_y));
d_ind=d_ind_1(find(maxm>0.01*max(maxm)));
N=length(fft_y);

d_est2=zeros(1,length(d_ind));
for r=1:length(d_ind)
    if fft_y(d_ind(r)-1)>fft_y(d_ind(r)+1)
    R=fft_y(d_ind(r)-1)/fft_y(d_ind(r));
    delta=-angle((R-1)/(R-cos(2*pi/N)-j*sin(2*pi/N)))*N/(2*pi);
    d_est2(r)=(d_ind(r)-2+delta)*accuracy;
    else
    R=fft_y(d_ind(r))/fft_y(d_ind(r)+1);
    delta=-angle((R-1)/(R-cos(2*pi/N)-j*sin(2*pi/N)))*N/(2*pi);
    d_est2(r)=(d_ind(r)-1+delta)*accuracy;
    end
end
 
toc
end
