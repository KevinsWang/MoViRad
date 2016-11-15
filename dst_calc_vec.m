function d_est3=dst_calc_vec(x,y,fs,c,Tsweep,fmin,fmax,dmax)
Ts=Tsweep;
k=(fmax-fmin)/Ts;
t_sample=1/fs;
taw_max=dmax/c;
index=round(taw_max/t_sample);
y_down=y.*x;
y_crop=y_down(index+1:end);
%plot(abs(fft(y_crop)))
fft_y_t=fft(y_crop);

 fft_y=fft_y_t(1:round((2*dmax/c*k)*Ts));
 plot(abs(fft_y))
 ylim([0, 4]);
[maxm, d_ind_1]=findpeaks(abs(fft_y));
%d_ind=d_ind_1(find(maxm>0.1*max(maxm)));
[~, d_ind_2] = sort(maxm, 'descend');
d_ind = d_ind_1(d_ind_2(1:5));
d_ind = sort(d_ind);
%disp(d_ind');
N=length(fft_y_t);
accuracy=1/(t_sample*length(y_crop))/k*c/2;

d_est2=zeros(1,length(d_ind));
for r=1:length(d_ind)
    d_est1(r) = (d_ind(r)-1)*accuracy;
    d_est3(r) = (d_ind(r)-1)*accuracy + angle(d_ind(r))/fmin*c/2;
    if d_ind(r) == 1
        d_est2(r) = 0;
    else
        if fft_y(d_ind(r)-1)>fft_y(d_ind(r)+1)
            R=fft_y(d_ind(r)-1)/fft_y(d_ind(r));
            if (abs(R) > 1)
                disp('ERROR');
            end
            delta = -angle((R-1)/(R-cos(2*pi/N)-j*sin(2*pi/N)))*N/(2*pi);
            d_est2(r)=(d_ind(r)-2+delta)*accuracy;
        else
            R=fft_y(d_ind(r))/fft_y(d_ind(r)+1);
            if (abs(R) < 1);
                disp('Error 2');
            end
            delta = -angle((R-1)/(R-cos(2*pi/N)-j*sin(2*pi/N)))*N/(2*pi);
            d_est2(r)=(d_ind(r)-1+delta)*accuracy;
        end
    end
end
 
end
