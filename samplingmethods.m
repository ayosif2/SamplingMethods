%Sampling methods V1.61 (still thinking of a proper name)
%this application was devolped by Yossef Ahmed Samir Salama for the subject
%of fault analysis
%note the term tailing used in the comments means adding a full wave at the
%end(tail hence the name) of the previous wave
while(1)         %an infinit while loop to loop agaain if the user wishes to continue
    clc;clear;    % to have a clean start
    l=1;         % a flag that if is set means to propably start the system
    ReplyMode = input("do you want to analyse a wave[1] or draw the charchtarstics of a sampling function[2]? Ans: "); %here I ask the user for a reply of what mode he intends to use wave analysis or alghorithm charctarstics
    if ReplyMode == 1       %if the user put 1 then we sttart the wave analysis mode
        ReplyInputType = input('What type of input do you want to use M for Matrix input, F for file input , W for Wave Input? ans : ','s'); % allowing the user to choose his desired input type
        if ReplyInputType == 'M'  % if the user choose matrix input
            k = input('Inser the Wave Matrix in Matrix form ex: [1 2 3 4] or [1,2,3,4].   ans:'); %take matrix input from the user
            fsample=input("Sample frequency:(in Hz) \nf= ");    %taking the sampling frequency which doesn't change when tailing so it should only be taken at the start
            Tsample=1/fsample;
            freq0 = input("frequency of the model:(in Hz) f0= ");  % freq0: the model frequency f0, which doesn't change while tailing
        elseif ReplyInputType == 'F'    %if the user choose file input
            fprintf('supported extinsions: .txt, .dat, or .csv for delimited text files\n.xls, .xlsb, .xlsm, .xlsx, .xltm, .xltx, or .ods for spreadsheet files') %stating supported extensions
            ReplyInputFileType = input('\nChoose the extinsion of the file you want to Read Ex: (ans:xlsx) or ans:txt \nans: ','s');    %requsting the exttension for the input
            fprintf('make sure a file with name k.%s is in the same folder as the code',ReplyInputFileType);                            %Affirming the name of the file and the extension
            while 1
                inputReadyFile = input('\nAre the File Ready? Y/N Ans: ','s'); %making sure the file is ready
                if inputReadyFile=='Y'
                    break
                end
            end
            file=append('k','.',ReplyInputFileType); %here I set up the file name and extension
            k = readmatrix(file); %take file input from the user
            fsample=input("Sample frequency:(in Hz) \nf= ");    %taking the sampling frequency which doesn't change when tailing so it should only be taken at the start
            Tsample=1/fsample;
            freq0 = input("frequency of the model:(in Hz) f0= ");  % freq0: the model frequency f0, which doesn't change while tailing
        
        else
            while 1             %an infinite while loop to allow the adding of a tail at the end if the user so wishes 
                if l==1         %l is a falg that if set means it is the first time or the user wishes to restart so we reinitialise the non-changing values
                    k=[];       %k: it is samples vector which we are trying to generate, inittializes an empty k as it may have a vlaue if the user wished to restart from a working condition
                    fsample=input("Sample frequency:(in Hz) \nf= ");    %taking the sampling frequency which doesn't change when tailing so it should only be taken at the start
                    Tsample=1/fsample;                                  %Tsample: the time between two samples (dt)
                    freq0 = input("frequency of the model:(in Hz) f0= ");  % freq0: the model frequency f0, which doesn't change while tailing
                end
                %taking the data of the fundmental wave:
                amp=input("\nmax amplitude:(in volt or any thing)\na= ");           %amp: the maximum magnitude of the fundmental wave 
                phaseangle=input("\nphase shift of the wave in degrees\ndelta= ");  %phasangle: the phase shift compared to a referance the angle usually known as Delta
                freq=input("\nthe frequency of the wave is (in Hz) ");              %freq= the wave frequency in hertz
                simtime=input("\nsimulation time in seconds= ");                    %simtime: the simulation time period of the current wave,not the entire wave in case of tailing,
                samnumber=simtime/Tsample;                                          %samnumber: the number of samples 
                fprintf("\nthe resulting input wave is y=%fsin(%f*pi*t+%f) ",amp,(2*freq),phaseangle); %here I am prenting the wave which will be drawn for the user to make sure
                ReplyRestart = input('\nDo you want to restart? Y/N [Y]: ','s');    %ReplyRestart: it take the user input of whether or not he wants to restart
                if isempty(ReplyRestart)                                            %a fail safe if reply was put with an empty value to degault to NO
                    ReplyRestart = 'N';                                             
                elseif ReplyRestart=='Y'                                            %if it was yes then reset the application by putting the l=1 (flag)
                    l=1;                                                            %putting l=1 indicates that the sytem will work from the beginning again              
                    continue                                                        %continue from the beginning
                end                         
                len=length(k);                                                      %len is the length of k before adding the operation so it can be used as a starting point                                     
                k1=zeros(1,length(1:1+samnumber));
                k=[k,k1];
                for i=len+1:1:(len+1+samnumber)                                     %here I loop from the len+1 the first new element to len+1+the number of saplings at the ende
                    k(i)=amp*sin(2*freq*pi*Tsample*(i-len-1)+phaseangle*pi/180);    %here I put the value of k
                end
                l2=1;                                                               %l2: is the number of the harmonice componnents
                while 1                                                             %this loop so the user can enter as much harmonics as he wants
                    ReplyHarmonics = input('add a another non-fundmental component wave to the equation? Y/N Ans: ','s'); % reply harmonics here I ask the user if he wants to add another harmoncic
                    if isempty(ReplyHarmonics)                                      %a fail safe if it is embty default to NO
                    ReplyHarmonics = 'N';                                       
                    end
                    if ReplyHarmonics=='Y'                                          % if the user wants harmonics
                        l2=l2+1;                                                    % here I add 1 to indicate the harmonic number
                    if l2==2                                                        %here if it is 2 then put 2nd instead of other number 
                        fprintf('this is the 2nd harmonic component F2=%d Hz\n',(2*freq));  %making sure the user knows which harmonic he is at to avoid confusion
                    elseif 12==3                                                    %if it is three I am the application will just type 3rd instead of 2nd for asthtatic purposes
                        fprintf('this is the 3rd harmonic component F3=%d Hz\n',(3*freq));
                    else
                        if l2==3                                                    %some times it doesn't work so this is a fail safe ,it is a code redunduncy but I couldn't bother with it in debugging,
                            fprintf('this is the 3rd harmonic component F3=%d Hz\n',(3*freq));
                        else
                            fprintf('this is the %dth harmonic component F%d=%d Hz\n',l2, l2 ,(l2*freq)); %here put th ex 4th 5th 6th etc instead of 2nd and 3rd,just for asthtatic purposes,
                        end
                    end
                    amp2   = input('amplitude of the harmonic wave= ');             %amp2: the amplitude of the harmonic wave
                    phase2 = input('phase shift of the wave in degrees phi= ');     %phase2: the angle of the harmonic wave
                    for i=len+1:1:(len+1+samnumber)                                 %here I loop over k to add the new component
                        k(i)=k(i)+amp2*sin(2*freq*l2*pi*Tsample*(i-len-1)+phase2*pi/180);
                    end
                    else                                                            %if the user said anytrhing but Y it will jump to the next portion
                        break; 
                    end
                end
                ReplyaddDC = input('\nadd a dc component? Y/N   ans: ','s');        %ReplyaddDC: here I ask the user whether there is a Dc component
                if isempty(ReplyaddDC)                                              %if the reply is empty default to NO
                    ReplyaddDC = 'N';
                end
                if ReplyaddDC=='Y'                                                  %if the answer is Yes
                    DCcomp= input("\nthe dc conmponent max amplitude= ");           %DCcomp: the max DC amplitude
                    ReplyDcType= input('\nis the DC componnent rising(R), decaying(D), or constant(C)? ans: ','s'); %ReplyDcType: here I ask the user if the DC is rising Decaying or Constant
                    if ReplyDcType=='R'                                             %if it is rising
                        risetime= input("\nthe rise time is Tr= ");                 %risetime: the time the wave takes to rise
                        for i=len+1:1:(len+1+samnumber)                             %then I add the DCcomp to the Wave(k)
                            DCcomp1=(DCcomp)-(DCcomp)*exp(-(Tsample/risetime*(i-len-1))*5);              %DCcomp: the component at a given moment of time
                            k(i)=k(i)+DCcomp1;                                      %add the DCcomp to the wave
                        end
                    elseif ReplyDcType=='D'                                         %if the user choose decaying 
                    risetime= input("\nthe fall time is Td= ");
                        for i=len+1:1:(len+1+samnumber)
                            DCcomp1=(DCcomp)*exp(-(Tsample/risetime*(i-len-1))*5);
                            k(i)=k(i)+DCcomp1;
                        end
                    else                                                            %any other choice will default as Constant
                        for i=len+1:1:(len+1+samnumber)
                            k(i)=k(i)+DCcomp;
                        end
                    end
                end
                ReplyTailFunc= input('\ndo you want to add another wave at the tail of the function Y/N?  ans: ','s');  %ReplyTailFun: input from the user for adding another wave at the end
                if isempty(ReplyTailFunc)                                                                               %fail safe if empty defaul to NO
                    ReplyTailFunc = 'N';
                end
                if ReplyTailFunc=='Y'                                                                                   %if Yes start the while but with l=0 so k won't rest
                    l=0;
                    continue
                else                                                                                                    %else break the loop 
                    break
                end
            end
        end
        time=(0:length(k)-1)*Tsample;                           %the time of the entire wave divided into a vector of the same length for plotting
        ReplySamMeth=input('\nwhich sampling method do you want 2 for 2 sample method ,3 for 3 sample method\n,P for peak-Based predictive calculations and 1 for all ;) : ans: ','s');
        figure('Name','the main wave','NumberTitle','off');     % plotting the main wave(here I name the figure and remove the number title requirment in its entirity)
        if ReplySamMeth=='1' || ReplySamMeth=='2' || ReplySamMeth=='3' || ReplySamMeth=='p'  %fail safe as if the answer is not elligible default to one
        else
            ReplySamMeth='1';
        end                                     %end of the fail safe
        plot(time,k,'-ro');                     %plotting the main wave
        title("the main wave");                 % plotting the main wave
        if ReplySamMeth=='2' || ReplySamMeth=='1'   %if TwoSample method is to be used
            %then apply the Two Sample method (go to ../App Functions/TwoSamples for Details)
            [Y,angle,Yc,Ys] = TwoSample(k,freq0,Tsample); %Y is the magnitude of the wave, while angle is the wave angle
            figure('Name','angle over time for two sample method','NumberTitle','off');  % plotting the magnitude wave(here I name the figure and remove the number title requirment in its entirity)
            plot(time,Y,'-bo');                                                         
            title('magnitude over time for two sample method')                            
            figure('Name','magnitude over time for two sample method','NumberTitle','off'); 
            plot(time,angle,'-ko');                                                      
            title('angle over time for two sample method');  
            index2= 0:length(k)-1;              %index2: the index of the matrix elemnt but starting from zero
            M2 = [index2;k;Yc;Ys;Y;angle];      %M2: the matri printed into the excel file
            M21 = [zeros(6,1), M2];              %here I put zeros in the first column so to replace them with string identfieng which rows is which
            delete Output\TwoSample.xlsx        %here I delete the exsitsting file to avoid interferance
            writematrix(M21,'Output\TwoSample.xlsx') %here I write into the excel files 
            S2 = ['index';'y    ';'Yc   ';'Ys   ';'Y    ';'Theta']; %here I crate a string array to use in the file
            writematrix(S2,'Output\TwoSample.xlsx')  %here I write the string array in the first coulumn
        end
        if ReplySamMeth=='P' || ReplySamMeth=='1'    %if peakbased method is to be used
            %then apply the Two Sample method (go to ../App Functions/PeakBased.m for Details)
            [Yp] = PeakBased(k,freq0,Tsample); %Yp magnitude using this method
            figure('Name','magnitude over time for Peak-Based predictive method','NumberTitle','off');
            plot(time,Yp,'-ko')
            title('magnitude over time for Peak-Based predictive method')
            indexp= 0:length(k)-1;
            Mp = [indexp;k;Yp];
            Mp1 = [zeros(3,1), Mp];
            delete Output\PeakBased.xlsx
            writematrix(Mp1,'Output\PeakBased.xlsx')
            Sp = ['index';'y    ';'Yp   '];
            writematrix(Sp,'Output\PeakBased.xlsx')
        end
        if ReplySamMeth=='3' || ReplySamMeth=='1'       %if ThreeSample method is to be used
            %then apply the Two Sample method (go to ../App Functions/ThreeSamples.m for Details)
            [Y3,angle3,Yc3,Ys3]=ThreeSample(k,freq0,Tsample);   %Y3 is the magnitude and angle3 is the angle using this method
            figure('Name','magnitude over time for three sample method','NumberTitle','off');
            plot(time,Y3,'-bo');
            title('magnitude over time for three sample method')
            figure('Name','angle over time for three sample method','NumberTitle','off');
            plot(time,angle3,'-ko');
            title('angle over time for three sample method');
            index3= 0:length(k)-1;
            M3 = [index3;k;Yc3;Ys3;Y3;angle3];
            M31 = [zeros(6,1), M3];
            delete Output\ThreeSample.xlsx
            writematrix(M31,'Output\ThreeSample.xlsx')
            S3 = ['index';'y    ';'Yc   ';'Ys   ';'Y    ';'Theta'];
            writematrix(S3,'Output\ThreeSample.xlsx')
        end 
            ReplyAgian=input('do you want to go again? Y/N ans: ','s');     %ReplyAgain: input to know if the user wants to go again
            if isempty(ReplyAgian)                                      %fail safe
                ReplyAgian = 'N';
            end                                                         
            if ReplyAgian == 'Y'                                        %if answer is yes continue
                continue 
            else                                                        %else stop the entire application
                break
            end
    elseif ReplyMode==2                                                 %if the charchtarstics mode was choson
        fsample=input("Sample frequency:(in Hz) \nf= ");                %fsample: input from the user pf the sampling frequency
        freq0 = input("frequency of the model:(in Hz) f0= ");           %freq0: the frequency of the model
        Tsample=1/fsample;                                              %Tsample: is the time between any two samples (dt)
        amp=input("\nmax amplitude:(in volt or any thing)\na= ");       %amp: the max amplitude used in the test
        phaseangle=input("\nphase shift of the wave in degrees\nphi= ");%phaseangle: the phaseangle of the tested wave
        basefreq= freq0/1000;                                           %basefreq:the base frequency is the frequency cahnge between each sample in order to draw the charchtarstic
        ReplySamMeth2=input('\nwhich sampling method do you want 2 for 2 sample method ,3 for 3 sample method,\nP for peak based predictive method and 1 for all;) ans: ','s'); %input from so he can choose which model to use
        simtime=input("\nsimulation time in seconds= ");                %simtime: the simulation time
        samnumber=round(simtime/Tsample);                               %samnumber: the number of samples
        if isempty(ReplySamMeth2)                                       %failsafe
            ReplySamMeth2 = '1';
        end
            k=zeros(1,samnumber);                                       %put zeros so the memory allocated size doesn't change each loop (improves performance)
            Ymean2=zeros(1,10000);                                      %put zeros so the memory allocated size doesn't change each loop (improves performance)
            Ymean3=zeros(1,10000);                                      %put zeros so the memory allocated size doesn't change each loop (improves performance)
            Ypmean=zeros(1,10000);                                      %put zeros so the memory allocated size doesn't change each loop (improves performance)
        for iI=1:10000                                                  %looping on each frequency
            for i=1:1:(samnumber)                                     %looping to set all values of k
                k(i)=amp*sin(2*iI*basefreq*pi*Tsample*(i)+phaseangle*pi/180);%setting all values of k
            end
            if ReplySamMeth2=='2' || ReplySamMeth2=='1'                 %if 2 Sample method is to be used
                [Y,angle] = TwoSample(k,freq0,Tsample);                 
                Ymean2(iI)=mean(Y);                                     %get the average value
            end
            if ReplySamMeth2=='P' || ReplySamMeth2=='1'
                [Yp] = PeakBased(k,freq0,Tsample);
                Ypmean(iI)=mean(Yp);                                    %get the average value
            end
            if ReplySamMeth2=='3' || ReplySamMeth2=='1'
                [Y3,angle3]=ThreeSample(k,freq0,Tsample);
                Ymean3(iI)=mean(Y3);                                    %get the average value
            end            
        end
        freqval=(1:10000)*basefreq;                                     %the values of frequency for plotting
        if ReplySamMeth2=='2' || ReplySamMeth2=='1'                     %start of plotting
            figure('Name','charactarstics using 2 sample method','NumberTitle','off');
            plot(freqval,Ymean2,'-k');
            title('charactarstics using 2 sample method');
        end
        if ReplySamMeth2=='3' || ReplySamMeth2=='1'
            figure('Name','charactarstics using 3 sample method','NumberTitle','off');
            plot(freqval,Ymean3,'-k');
            title('charactarstics using 3 sample method');
        end
        if ReplySamMeth2=='P' || ReplySamMeth2=='1'
            figure('Name','charactarstics using Peak-based protective alghorithm','NumberTitle','off');
            plot(freqval,Ypmean,'-k');
            title('charactarstics using Peak-based protective alghorithm');
        end                                                             %end of plotting
        ReplyAgian=input('do you want to go again? Y/N ans: ','s');     %input form the user if he wants to start again
        if isempty(ReplyAgian)                                          %fail safe
            ReplyAgian = 'N';                                           
        end
        if ReplyAgian == 'Y'
            continue 
        else
            break
        end
    else
        fprintf("not a proper input!!!!!!")                             %if the user inputed a non-valid input while choosing the mode
    end
end

%version 1.1 changelog
%A. new feautures
%1. added the ability to add harmonic in the sample analysis mode
%2. added the charctarstics mode to the system
%B. Bug Fixes
%1. fixed the starting value proplem in the 2 sample method
%2. made the system use only the next value in all my methods to avoid errors


%version 1.11 change log
%minor bug fixes

%version 1.2 change log
% added Peak-Based Predictive calculation 

%version 1.21
% very minor changes to the text propmpts

%version 1.3
%transformed the alghorithms into modules

%version 1.4

%added a GUI application for sample generation and analysis

%version 1.41
%minor bug fixes in the threesample function anf the GUI application

%version 1.42
%1.removed arbitrary figure naames in favor of actual indictive names
%2.removed arbitrary reply variable names in favor of actual indictive name
%to impreove readability

%version 1.5
%1. added comments for redabilities sake
%2. major bug fixes to the GUI application (generate at the end button callback function only worked in certain conditions due to a bug in the code it was fixed in this version)
%3. major optmization fixes for the command applications (the input was limitied if the ac fundmental amplitude was zero removed such limitations)
%4. fixed the DC componnet (it was linear I made exponitial)
%5. improved the performance by removing redunduncy and minmizing memory
%allocation process
%6. improved readability by removing all the warnings and fixing them excep
%one in the m-file application which must be there as memory must be
%allocated at least once per wave

%Version 1.51
%added version number to the bottom for conveinence

%version 1.6 (the file Mangment update)
%1. Matrix input 
%2. File input 
%3. output to file

%version 1.6 (the file Mangment update)
%minor bug fixes

%feautures yet to be added in future versions
%1. Mann-Morrison and Prodar 70 (maybe in some future but don't intend to do it now)

