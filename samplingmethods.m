%Sampling methods V1.41 (still thinking of a proper name)
%this application was devolped by Yossef Ahmed Samir Salama for the subject
%of fault analysis
%here figure 1 is the main wave, 2,3 the 2 sampling method figure ,4,5 the 3
%sampling method figure, 6 the one for the charchterstics of the 2 sample
%while 7 is the one for the 3 sample charcterstics they are done in order
%of implementation 'intend to replace the arbitrary numbers with variable
%for increased readability in a future version
while(1)
    clc;clear;
    l=1;         % a flag that if is set means to propably start the system
    reply8 = input("do you want to analyse a wave[1] or draw the charchtarstics of a sampling function[2]? Ans: ");
    if reply8 == 1
        while 1
            if l==1
                k=[];
                time=0;
                fsample=input("Sample frequency:(in Hz) \nf= ");
                Tsample=1/fsample;
                freq0 = input("frequency of the model:(in Hz) f0= ");
            end
            amp=input("\nmax amplitude:(in volt or any thing)\na= ");
            phaseangle=input("\nphase shift of the wave in degrees\nphi= ");
            freq=input("\nthe frequency of the wave is (in Hz) ");
            simtime=input("\nsimulation time in seconds= ");
            time=simtime+time;
            samnumber=simtime/Tsample;
            if amp==0
                reply2='Y'; 
                len=length(k);
                for i=len+1:1:(len+1+samnumber)
                    k(i)=0;
                end
            end
            if amp ~ 0;
                fprintf("\nthe resulting input wave is y=%fsin(%f*pi*t+%f) ",amp,(2*freq),phaseangle);
                reply = input('\nDo you want to restart? Y/N [Y]: ','s');
                if isempty(reply);
                    reply = 'N';
                end
                if reply=='Y';
                    l=1;
                    continue
                end
                len=length(k);
                for i=len+1:1:(len+1+samnumber)
                    k(i)=amp*sin(2*freq*pi*Tsample*(i-len-1)+phaseangle*pi/180);
                end
                    l2=1;
                while 1
                    reply7 = input('add a another non-fundmental component wave to the equation? Y/N Ans: ','s');
                    if isempty(reply7);
                        reply7 = 'N';
                    end
                    if reply7=='Y'
                        l2=l2+1;
                        if l2==2
                            fprintf('this is the 2nd harmonic component F2=%d Hz\n',(2*freq)); 
                        elseif 12==3
                            fprintf('this is the 3rd harmonic component F3=%d Hz\n',(3*freq));
                        else
                            if l2==3
                            fprintf('this is the 3rd harmonic component F3=%d Hz\n',(3*freq));
                            else
                            fprintf('this is the %dth harmonic component F%d=%d Hz\n',l2, l2 ,(l2*freq));
                            end
                        end
                        amp2   = input('amplitude of the harmonic wave= ');
                        phase2 = input('phase shift of the wave in degrees phi= ');
                        for i=len+1:1:(len+1+samnumber)
                            k(i)=k(i)+amp2*sin(2*freq*l2*pi*Tsample*(i-len-1)+phase2*pi/180);
                        end
                    else
                        break; 
                    end
                end
                reply2 = input('\nadd a dc component? Y/N   ans: ','s');
                if isempty(reply2);
                    reply2 = 'N';
                end
            end
                if isempty(reply2);
                    reply2 = 'Y';
                end
            if reply2=='Y';
                DCcomp= input("\nthe dc conmponent max amplitude= ");
                reply3= input('\nis the DC componnent rising(R), decaying(D), or constant(C)? ans: ','s');
                if reply3=='R';
                    risetime= input("\nthe rise time is Tr= ");
                    for i=len+1:1:(len+1+samnumber)
                        DCcomp1=DCcomp*Tsample/risetime*(i-len-1);
                        if DCcomp1>=DCcomp;
                            DCcomp1=DCcomp;
                        end
                        k(i)=k(i)+DCcomp1;
                    end
                elseif reply3=='D';
                risetime= input("\nthe fall time is Td= ");
                    for i=len+1:1:(len+1+samnumber)
                        DCcomp1=DCcomp-DCcomp*Tsample/risetime*(i-len-1);
                        if DCcomp1<=0;
                            DCcomp1=0;
                        end
                        k(i)=k(i)+DCcomp1;
                    end
                else
                    for i=len+1:1:(len+1+samnumber)
                        k(i)=k(i)+DCcomp;
                    end
                end
            end
            reply4= input('\ndo you want to add another wave at the tail of the function Y/N?  ans: ','s');
            if isempty(reply4);
                reply4 = 'N';
            end
            if reply4=='Y';
                l=0;
                continue
            else
                break
            end
        end
        time=(0:length(k)-1)*Tsample;
        reply5=input('\nwhich sampling method do you want 2 for 2 sample method ,3 for 3 sample method\n,P for peak-Based predictive calculations and 1 for both: ans: ','s');
        figure(1);
        if reply5~'1';
            if reply5~'2';
                if reply5~'3';
                    reply5='1'; 
                end
            end
        end
        plot(time,k,'-ro');
        title("the main wave");
        if reply5=='2' || reply5=='1'
            [Y,angle] = TwoSample(k,freq0,Tsample);
            figure(2);
            plot(time,Y,'-bo');
            title('magnitude over time for two sample method')
            figure(3);
            plot(time,angle,'-ko');
            title('angle over time for two sample method');       
        end
        if reply5=='P' || reply5=='1'
            [Yp] = PeakBased(k,freq0,Tsample);
            figure(8)
            plot(time,Yp,'-ko')
            title('magnitude over time for Peak-Based predictive method')
        end
        if reply5=='3' || reply5=='1'
            [Y3,angle3]=ThreeSample(k,freq0,Tsample);
            figure(4);
            plot(time,Y3,'-bo');
            title('magnitude over time for three sample method')
            figure(5);
            plot(time,angle3,'-ko');
            title('angle over time for three sample method');     
        end
        reply6=input('do you want to go again? Y/N ans: ','s');
            if isempty(reply6);
                reply6 = 'N';
            end
            if reply6 == 'Y';
                continue 
            else
                break
            end
    elseif reply8==2
        fsample=input("Sample frequency:(in Hz) \nf= ");
        freq0 = input("frequency of the model:(in Hz) f0= ");
        Tsample=1/fsample;
        amp=input("\nmax amplitude:(in volt or any thing)\na= ");
        phaseangle=input("\nphase shift of the wave in degrees\nphi= ");
        len=0;
        basefreq= freq0/1000;
        reply9=input('\nwhich sampling method do you want 2 for 2 sample method ,3 for 3 sample method,\nP for peak based predictive method and 1 for all;) ans: ','s');
        simtime=input("\nsimulation time in seconds= ");
        time=simtime+0;
        samnumber=simtime/Tsample;
        if isempty(reply9);
            reply9 = '1';
        end
        for iI=1:10001
            for i=len+1:1:(len+1+samnumber)
                k(i)=amp*sin(2*iI*basefreq*pi*Tsample*(i-len-1)+phaseangle*pi/180);
            end
            if reply9=='2' || reply9=='1'
                [Y,angle] = TwoSample(k,freq0,Tsample);
                Ymean2(iI)=mean(Y);
            end
            if reply5=='P' || reply5=='1'
                [Yp] = PeakBased(k,freq0,Tsample);
                Ypmean=mean(Yp);
            end
            if reply9=='3' || reply9=='1'
                [Y3,angle3]=ThreeSample(k,freq0,Tsample);
                Ymean3(iI)=mean(Y3);
            end            
        end
        freqval=(1:10001)*basefreq;
        if reply9=='3' || reply9=='1'
            figure(6)
            plot(freqval,Ymean2,'-k');
            title('charactarstics using 2 sample method');
        end
        if reply9=='3' || reply9=='1'
            figure(7)
            plot(freqval,Ymean3,'-k');
            title('charactarstics using 3 sample method');
        end
        if reply9=='P' || reply9=='1'
            figure(9)
            plot(freqval,Ypmean,'-k');
            title('charactarstics using Peak-based protective alghorithm');
        end
        reply6=input('do you want to go again? Y/N ans: ','s');
        if isempty(reply6);
            reply6 = 'N';
        end
        if reply6 == 'Y';
            continue 
        else
            break
        end
    else
        fprintf("not a proper input!!!!!!") 
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

%feautures yet to be added in future versions
%1. Mann-Morrison and Prodar 70 (maybe in some future but don't intend to do it now)
%2. Matrix input (high propability to be implemented)
%3. File input (high propability to implement)
%4. adding proper comments(that's a must but will take a while)
