function [YDFT,ThetaDFT,YcDFT,YsDFT] = dftr(k,freq0,fsample)
%dftr This function applies the dft recursive alghorithm for V1.9
%to any given input data k, freq0 is the model frequency, while fsample is
%the sampling frequency
    Nw=round(fsample/freq0,0);           %setting the window size
    k=transpose(k);                     %the inputt must be a column vector as ATP uses only that
    YcDFT=zeros((Nw/2+1),length(k));   %setting the variable size for optmization
    YsDFT=zeros((Nw/2+1),length(k));   %setting the variable size for optmization
    YDFT=zeros((Nw/2+1),length(k));    %setting the variable size for optmization
    ThetaDFT=zeros((Nw/2+1),length(k));%setting the variable size for optmization
    window= zeros(1,Nw);               %setting tthe zero window
    for j=1:length(k)                   %looping over the window number
        window=circshift(window,1);     %circling the window
        window_old=window(1);           %extracting the old value
        window_new=k(j);                % getting the new value
        window(1)=k(j);
         %putting the new value
        for jj=1:Nw/2+1                   % looping over the harmonics
            if jj==1;NN=1/Nw;else;NN=2/Nw;end     % if DC ten remove the 2 multiplication
            if j==1                             %if FIRST THEN THERE IS NO OLD REAL AND IMAGINARY
                YcDFT(jj,j)=0 +NN*(window_new-window_old)*cos((jj-1)*(j-1)*2*pi/Nw);   %plugging values into the equation
                YsDFT(jj,j)=0 +NN*(window_new-window_old)*sin((jj-1)*(j-1)*2*pi/Nw);    %plugging values into the equation
                YDFT(jj,j)=sqrt(YcDFT(jj,j)^2+YsDFT(jj,j)^2); %here I calculate the magnitude 
                ThetaDFT(jj,j)=atan2d(YsDFT(jj,j),YcDFT(jj,j));                            %calcualte angle
            else                                %if not the first the window 
                YcDFT(jj,j)=YcDFT(jj,j-1) + NN*(window_new-window_old)*cos((jj-1)*(j-1)*2*pi/Nw);
                YsDFT(jj,j)=YsDFT(jj,j-1) + NN*(window_new-window_old)*sin((jj-1)*(j-1)*2*pi/Nw);
                YDFT(jj,j)=sqrt(YcDFT(jj,j)^2+YsDFT(jj,j)^2); %here I calculate the magnitude 
                ThetaDFT(jj,j)=atan2d(YsDFT(jj,j),YcDFT(jj,j));                            %calcualte angle
            end
        end
    end
end

