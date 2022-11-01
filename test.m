%just a debugging script
load('66V.MAT');
k=v66va;
%k = transpose(readmatrix('k.xlsx'));
fs=1600;f0=50;
[YDFT,ThetaDFT,YcDFT,YsDFT] = dft(k,f0,fs);
[YDFTr,ThetaDFTr,YcDFTr,YsDFTr] = dftr(transpose(k),f0,fs);
dt=1/fs;
figure(1)
plot(dt*(1:length(k)),YDFT(2,1:length(k)))
figure(2)
plot(dt*(1:length(k)),YDFTr(2,1:length(k)))
figure(3)
plot(dt*(1:length(k)),ThetaDFT(2,1:length(k)))
figure(4)
plot(dt*(1:length(k)),ThetaDFTr(2,1:length(k)))