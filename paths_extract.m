function [state P ]=paths_extract(file_speaker,file_mic,c,Tsweep,dist_mic_speak,fmin,fmax,dmax)
[x_tot_vec fs]=audioread(file_speaker);
l=Tsweep*fs+1;
x_tot=x_tot_vec(1:(floor(length(x_tot_vec)/l)*l));
f=(length(x_tot)/l);
X=reshape(x_tot,l,f);
y_tot_vec=audioread(file_mic);
[corr lags]=xcorr(y_tot_vec,x_tot_vec);

N_shift=lags(find(corr==max(corr(end/2 : end/2 + 88e3))))-round(dist_mic_speak/(c/2)*fs);

y_tot_aligned=y_tot_vec(N_shift:N_shift+length(x_tot)-1);

Y=reshape(y_tot_aligned,l,f);
%Y=Y-repmat(mean(Y')', [1, f]);
for f_c=1:f
    %disp(f_c);
    P(:,f_c)=dst_calc_vec(X(:,f_c),Y(:,f_c),fs,c,Tsweep,fmin,fmax,dmax);
end
[r_p c_p]=size(P);

for c=1:r_p
    if (var(P(c,:))> (1e-3)^2)
        state(c)='d';
    else
        state(c)='s';
    end
end
end