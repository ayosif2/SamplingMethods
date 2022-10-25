%Sampling methods V1.11 (still thinking of a proper name)
%this application was devolped by Yossef Ahmed Samir Salama for the subject
%of fault analysis
%here figure 1 is the main wave, 2,3 the 2 sampling method figure ,4,5 the 3
%sampling method figure, 6 the one for the charchterstics of the 2 sample
%while 7 is the one for the 3 sample charcterstics they are done in order
%of implementation 'intend to replace the arbitrary numbers with variable
%for increased readability in a future version
while(1)
    clc;clear;
    l=1;
    reply8 = input("do you want to analyse a wave[1] or draw the charchtarstics of a sampling function[2]? Ans:");
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
                fprintf("\nthe resulting input wave is y=%fsin(%f*pi*t+%f)",amp,(2*freq),phaseangle);
                reply = input('\nDo you want to restart? Y/N [Y]:','s');
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
                    reply7 = input('add a another non-fundmental component wave to the equation? Y/N','s');
                    if isempty(reply7);
                        reply7 = 'N';
                    end
                    if reply7=='Y'
                        l2=l2+1;
                        if l2==2
                            fprintf('this is the 2nd harmonic component F2=%f',(2*freq)); 
                        elseif 12==3
                            fprintf('this is the 3rd harmonic component F3=%f',(3*freq));
                        else
                            fprintf('this is the %dth harmonic component F%d=%f',l2,(l2*freq),l2);
                        end
                        amp2   = input('amplitude of the harmonic wave= ');
                        phase2 = input('phase shift of the wave in degrees phi=');
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
                reply3= input('\nis the DC componnent rising(R), decaying(D), or constant(C)? ans:','s');
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
        reply5=input('\nwhich sampling method do you want 2 for 2 sample method 3 for 3 sample method and 1 for both: ans: ','s');
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
            Yc=k;
            Ys(1)=(Yc(1)*cos(2*freq0*pi*Tsample)-0)/sin(2*freq0*pi*Tsample);
            for j=2:length(k)
                Ys(j)=(Yc(j)*cos(2*freq0*pi*Tsample)-Yc(j-1))/sin(2*freq0*pi*Tsample);
            end
            for z=1:length(k)
                Y(z)=sqrt(Ys(z)^2+Yc(z)^2);
                angle(z)=atand(Ys(z)/Yc(z));
            end
            figure(2);
            plot(time,Y,'-bo');
            title('magnitude over time for two sample method')
            figure(3);
            plot(time,angle,'-ko');
            title('angle over time for two sample method');       
        end
        if reply5=='3' || reply5=='1'
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
            mean(Y)
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
        reply9=input('\nwhich sampling method do you want 2 for 2 sample method 3 for 3 sample method and 1 for both: ans: ','s');
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
                Yc=k;
                Ys(1)=(Yc(1)*cos(2*freq0*pi*Tsample)-0)/sin(2*freq0*pi*Tsample);
                for j=2:length(k)
                    Ys(j)=(Yc(j)*cos(2*freq0*pi*Tsample)-Yc(j-1))/sin(2*freq0*pi*Tsample);
                end
                for z=1:length(k)
                    Y(z)=sqrt(Ys(z)^2+Yc(z)^2);
                    angle(z)=atand(Ys(z)/Yc(z));
                end
                Ymean2(iI)=mean(Y);
            end
            if reply9=='3' || reply9=='1'
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


%feautures yet to be added in future versions
%1. Peak-Based Predictive calculation
%2. Mann-Morrison and Prodar 70 (maybe in some future but don't intend to do it now)
%3. Matrix input (high propability to be implemented)
%4. File input (high propability to implement)
%4. a modular programming based version (feels kinda unnecessary to say the least)
%5. a GUI version (for efficient work flow the system must be made modular first fell like its gonna be a drag don't if its ever gonna happen)