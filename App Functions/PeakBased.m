function [Yp] = PeakBased(k,freq0,Tsample)
%PeakBased This function applies the three sample predictive alghorithm
%to any given input data k, freq0 is the model frequency, while Tsample is
%the sampling time
            Yp(1)=(1/(2*pi*freq0))*sqrt((k(1)/Tsample)^2+(2*pi*freq0*k(1))^2);
            for j=2:length(k)
                Yp(j)=(1/(2*pi*freq0))*sqrt(((k(j)-k(j-1))/Tsample)^2+(2*pi*freq0*k(j))^2);
            end
end

