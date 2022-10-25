function [Y,angle] = TwoSample(k,freq0,Tsample)
%TwoSample This function applies the three sample predictive alghorithm
%to any given input data k, freq0 is the model frequency, while Tsample is
%the sampling time
	Yc=k;
	Ys(1)=(Yc(1)*cos(2*freq0*pi*Tsample)-0)/sin(2*freq0*pi*Tsample);
    for j=2:length(k)
        Ys(j)=(Yc(j)*cos(2*freq0*pi*Tsample)-Yc(j-1))/sin(2*freq0*pi*Tsample);
    end
	for z=1:length(k)
        Y(z)=sqrt(Ys(z)^2+Yc(z)^2);
        angle(z)=atand(Ys(z)/Yc(z));
	end
end

