function [YDFT,ThetaDFT,YcDFT,YsDFT] = dft(k,freq0,fsample)
%dft This function applies the dft alghorithm
%to any given input data k, freq0 is the model frequency, while fsample is
%the sampling frequency
    Nw=fsample/freq0;           %setting the window size
    YcDFT=zeros((Nw/2+1),length(k));   %setting the variable size for optmization
    YsDFT=zeros((Nw/2+1),length(k));   %setting the variable size for optmization
    YDFT=zeros((Nw/2+1),length(k));    %setting the variable size for optmization
    ThetaDFT=zeros((Nw/2+1),length(k));%setting the variable size for optmization
    for j= (-Nw+2):length(k)-Nw+1             %j is the window number 
        if j<1                              %if j is less than 1 put zeros to fill k1
            k1 =[zeros(1,abs(j)+1), k(1:(Nw+j-1))]; %k1 is the window data
        else
            k1 = k(j:(Nw+j-1));             %if not put k1 as the data location from point j to the end of the window
        end
        for jj=0:((Nw/2))                   %jj is the number of the harmonic 0 is DC while 1 is Fundmental and so on
            YcDFT(jj+1,j+Nw-1)=2*mean(k1.*(cos((jj*1/Nw*2*pi)*(0:(Nw-1))))); %here we just plugin the numbers note: tthe mean is the addition over the number of elements
            YsDFT(jj+1,j+Nw-1)=2*mean(k1.*(sin((jj*1/Nw*2*pi)*(0:(Nw-1))))); %here we just plugin the numbers note: tthe mean is the addition over the number of elements
            YDFT(jj+1,j+Nw-1)=sqrt(YcDFT(jj+1,j+Nw-1)^2+YsDFT(jj+1,j+Nw-1)^2); %here I calculate the magnitude
            if YcDFT(jj+1,j+Nw-1)==0                                         %here I am just avoiding undefined numbers
                if YsDFT(jj+1,j+Nw-1)==0                                     % if both sine and cos somehow equal zero which can only happen at the first window I am avoiding a null value by putting zero this window is not good so no proplem
                ThetaDFT(jj+1,j+Nw-1)=0;        
                else                                                         %as tan 90 is undefined
                ThetaDFT(jj+1,j+Nw-1)=90;
                end
            else
            ThetaDFT(jj+1,j+Nw-1)=atand(YsDFT(jj+1,j+Nw-1)/YcDFT(jj+1,j+Nw-1));                            %if there is no proplem then calculate normally
            end
        end
    end
end

