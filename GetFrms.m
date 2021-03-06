function formants = GetFrms(SigTime,Fs)

    x = SigTime;
    x1 = x.*hamming(length(x));
    preemph = [1 0.1];
    x1 = filter(1,preemph,x1);

    a = lpc(x1,60);
    rts = roots(a);

    rts = rts(imag(rts)>=0);
    angz = atan2(imag(rts),real(rts));

    [frqs,indices] = sort(angz.*(Fs/(2*pi)));
    bw = -1/2*(Fs/(2*pi))*log(abs(rts(indices)));

    formants = zeros(1,length(frqs)+5);
    nn = 1;
    for kk = 1:length(frqs)
        if (frqs(kk) > 290 && bw(kk) <150)
            formants(nn) = frqs(kk);
            nn = nn+1;
        end
    end

end
%%

%GetFrms (SigTime,Fs)
