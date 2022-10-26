function [Y3,angle3] = ThreeSample(k,freq0,Tsample)
%ThreeSample This function applies the three sample predictive alghorithm
%to any given input data k, freq0 is the model frequency, while Tsample is
%the sampling time
    Yc3=zeros(1,length(k));         %initiating the size of the matrix to improve performance
    Yc3(1)=(0*cos(2*freq0*pi*Tsample)+0+k(1)*cos(2*freq0*pi*Tsample))/((2*(cos(2*freq0*pi*Tsample))^2)+1);  %do the first two stages which are faulty in this alghorism
    Ys3(1)=(k(1)-0)/(2*sin(2*freq0*pi*Tsample));
    Yc3(2)=(0*cos(2*freq0*pi*Tsample)+k(1)+k(2)*cos(2*freq0*pi*Tsample))/((2*(cos(2*freq0*pi*Tsample))^2)+1);
    Ys3(2)=(k(2)-0)/(2*sin(2*freq0*pi*Tsample));
        Y3=zeros(1,length(k));      %initiating the size of the matrix to improve performance
        angle3=zeros(1,length(k));  %initiating the size of the matrix to improve performance
    for j=3:length(k)               %here I apply the alghorism on each sample
        Yc3(j)=(k(j-2)*cos(2*freq0*pi*Tsample)+k(j-1)+k(j)*cos(2*freq0*pi*Tsample))/((2*(cos(2*freq0*pi*Tsample))^2)+1);
    end
    for j=3:length(k)
        Ys3(j)=(k(j)-k(j-2))/(2*sin(2*freq0*pi*Tsample));
    end
    %here I get the magnitude and angle
    for z=1:length(k)
        Y3(z)=sqrt(Ys3(z)^2+Yc3(z)^2);
        angle3(z)=atand(Ys3(z)/Yc3(z));
    end
end

