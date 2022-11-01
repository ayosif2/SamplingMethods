function [Yp] = PeakBased(k,freq0,Tsample)
%PeakBased This function applies the three sample predictive alghorithm for
%V1.8
%to any given input data k, freq0 is the model frequency, while Tsample is
%the sampling time
            Yp=zeros(1,length(k)); %initiating the size of the matrix to improve performance
            Yp(1)=(1/(2*pi*freq0))*sqrt((k(1)/Tsample)^2+(2*pi*freq0*k(1))^2); %applting the alghorism on the first one which is always fault
            %applying the alghoerism
            for j=2:length(k)      
                Yp(j)=(1/(2*pi*freq0))*sqrt(((k(j)-k(j-1))/Tsample)^2+(2*pi*freq0*k(j))^2);  %Yp: the magnitude of the wave at that sample
            end
end

