function [YDFT,ThetaDFT,YcDFT,YsDFT] = dft(k,freq0,fsample)
%dft This function applies the dft alghorithm for V2.0
%to any given input data k, freq0 is the model frequency, while fsample is
%the sampling frequency
    Nw=round(fsample/freq0,0);           %setting the window size
    k=transpose(k);
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
        for jj=0:((Nw/2))                    %jj is the number of the harmonic 0 is DC while 1 is Fundmental and so on
            if jj==0                         %as zero component is only the mean      
                YcDFT(jj+1,j+Nw-1)=mean(k1.*(cos((jj*1/Nw*2*pi)*(0:(Nw-1))))); %here we just plugin the numbers note: tthe mean is the addition over the number of elements
                YsDFT(jj+1,j+Nw-1)=mean(k1.*(sin((jj*1/Nw*2*pi)*(0:(Nw-1))))); %here we just plugin the numbers note: tthe mean is the addition over the number of elements
                YDFT(jj+1,j+Nw-1)=sqrt(YcDFT(jj+1,j+Nw-1)^2+YsDFT(jj+1,j+Nw-1)^2); %here I calculate the magnitude
                ThetaDFT(jj+1,j+Nw-1)=atan2d(YsDFT(jj+1,j+Nw-1),YcDFT(jj+1,j+Nw-1));                            %calculate angle
            else
                YcDFT(jj+1,j+Nw-1)=2*mean(k1.*(cos((jj*1/Nw*2*pi)*(0:(Nw-1))))); %here we just plugin the numbers note: tthe mean is the addition over the number of elements
                YsDFT(jj+1,j+Nw-1)=2*mean(k1.*(sin((jj*1/Nw*2*pi)*(0:(Nw-1))))); %here we just plugin the numbers note: tthe mean is the addition over the number of elements
                YDFT(jj+1,j+Nw-1)=sqrt(YcDFT(jj+1,j+Nw-1)^2+YsDFT(jj+1,j+Nw-1)^2); %here I calculate the magnitude 
                ThetaDFT(jj+1,j+Nw-1)=atan2d(YsDFT(jj+1,j+Nw-1),YcDFT(jj+1,j+Nw-1));                            %calcualte angle
            end

        end
    end
    for jj=2:(1+Nw/2)           % here I do some calculation to achieve constant phase with respect to starting point
        theta=90+360*(jj-1)/(Nw)*(-1);  
        for j =1:length(k)
            ThetaDFT(jj,j)=-atan2d(sind(ThetaDFT(jj,j)-theta),cosd((ThetaDFT(jj,j)-theta)));
            if round(theta,0)==180 || round(theta,0)==-180
                theta=-theta;
            end
            theta=theta+360*(jj-1)/(Nw)*(-1);
        end
    end
end

