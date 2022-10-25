function [Y3,angle3] = ThreeSample(k,freq0,Tsample)
%ThreeSample This function applies the three sample predictive alghorithm
%to any given input data k, freq0 is the model frequency, while Tsample is
%the sampling time
    Yc3(1)=(0*cos(2*freq0*pi*Tsample)+0+k(1)*cos(2*freq0*pi*Tsample))/((2*(cos(2*freq0*pi*Tsample))^2)+1);
    Ys3(1)=(k(1)-0)/(2*sin(2*freq0*pi*Tsample));
    Yc3(2)=(0*cos(2*freq0*pi*Tsample)+0+k(1)*cos(2*freq0*pi*Tsample))/((2*(cos(2*freq0*pi*Tsample))^2)+1);
    Ys3(2)=(k(1)-0)/(2*sin(2*freq0*pi*Tsample));
    for j=3:length(k)
        Yc3(j)=(k(j-2)*cos(2*freq0*pi*Tsample)+k(j-1)+k(j)*cos(2*freq0*pi*Tsample))/((2*(cos(2*freq0*pi*Tsample))^2)+1);
    end
    for j=3:length(k)
        Ys3(j)=(k(j)-k(j-2))/(2*sin(2*freq0*pi*Tsample));
    end
    for z=1:length(k)
        Y3(z)=sqrt(Ys3(z)^2+Yc3(z)^2);
        angle3(z)=atand(Ys3(z)/Yc3(z));
    end
end

