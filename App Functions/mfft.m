function [YFFT,ThetaFFT,YcFFT,YsFFT] = mfft(k,freq0,fsample)
%this is just an implementation for the exisiting MATLAB fft function just
%made the values more comperhensive for our electrical engineering rather
%than having a single window output I apply a sliding window output and put
%that output rather than being in a cmplx form into an easy to understand
%angle and magnitude for each frequency and ofcourse rather than having the
%output not averged I multiply it by an average factor as well so the
%output is simply the voltage and nothing more V2.0 sampling methods

%here I initialise the matrices used to improve performance
Nw=round(fsample/freq0,0);
YFFT=zeros(Nw/2,length(k));
YcFFT=zeros(Nw/2,length(k));
YsFFT=zeros(Nw/2,length(k));
ThetaFFT=zeros(Nw/2,length(k));
Buffer=zeros(1,Nw+1);
window=zeros(1,Nw);
%here I loop over the windows and I force them to slide
    for j=1:length(k)
        window = circshift(window,Nw-1); %here I rotate the matrix so the oldest element is at the end
        window(Nw)=k(j);       %here I add the new element in place of the old one
        Buffer=fft(window);
        YcFFT(1:(Nw/2),j) =real(Buffer(1:Nw/2)/(Nw/2));   %here i only take the real part
        YsFFT(1:(Nw/2),j) =imag(Buffer(1:Nw/2)/(Nw/2));   %here I only take the imaginary part
        YFFT(1:(Nw/2),j) =abs(Buffer(1:Nw/2)/(Nw/2));     %here I get the absloute value
        ThetaFFT(1:(Nw/2),j) =atan2d(-YsFFT(1:(Nw/2),j),YcFFT(1:(Nw/2),j)); %here I calculate the angle
    end
        YsFFT(1,(1:length(k)))=YFFT(1,(1:length(k)))/2;     %here I compensate for the DC not being divided by half Nw
        YsFFT(1,(1:length(k)))=YsFFT(1,(1:length(k)))/2;    %here I compensate for the DC not being divided by half Nw
    for jj=2:(Nw/2)
        theta=90+360*(jj-1)/(Nw)*(-1);
        for j =1:length(k)                                  % here I do some calculation to achieve constant phase with respect to starting point
            ThetaFFT(jj,j)=atan2d(sind(ThetaFFT(jj,j)-theta),cosd((ThetaFFT(jj,j)-theta)));
            if round(theta,0)==180 || round(theta,0)==-180
                theta=-theta;
            end
            theta=theta+360*(jj-1)/(Nw)*(-1);
        end
    end
end

