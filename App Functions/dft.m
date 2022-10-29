function [YDFT,ThetaDFT,YcDFT,YsDFT] = dft(k,freq0,fsample)
%dft This function applies the dft alghorithm
%to any given input data k, freq0 is the model frequency, while fsample is
%the sampling frequency
    Nw=fsample/freq0;
    YcDFT=zeros((Nw/2),length(k)-Nw-1);
    YsDFT=zeros((Nw/2),length(k)-Nw-1);
    YDFT=zeros((Nw/2),length(k)-Nw-1);
    ThetaDFT=zeros((Nw/2),length(k)-Nw-1);
    for j= (-Nw+2):length(k)-Nw
        if j<1
            k1 =[zeros(1,abs(j)+1), k(1:(Nw+j-1))];
        else
            k1 = k(j:(Nw+j-1));
        end
        for jj=0:((Nw/2))-1
            xcc=2*mean(k1.*(cos((jj*1/Nw*2*pi)*(0:(Nw-1)))));
            xss=2*mean(k1.*(sin((jj*1/Nw*2*pi)*(0:(Nw-1)))));
            YcDFT(jj+1,j+Nw-1)=xcc;
            YsDFT(jj+1,j+Nw-1)=xss;
            YDFT(jj+1,j+Nw-1)=sqrt(xcc^2+xss^2);
            if xcc==0
                if xss==0
                ThetaDFT(jj+1,j+Nw-1)=0;
                else
                ThetaDFT(jj+1,j+Nw-1)=90;
                end
            else
            ThetaDFT(jj+1,j+Nw-1)=atand(xss/xcc);
            end
        end
    end
end

