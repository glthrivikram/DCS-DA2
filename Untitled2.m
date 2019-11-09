clc
clear all
close all

[y1,Fs1] = audioread('C:\Users\91979\Downloads\17bec1109.m4a');
y1(:,1) = [];
figure(1);
t = 0:1/Fs1:(length(y1)-1)/Fs1;
plot(t,y1); 
xlabel('Time')
ylabel('Amplitude')
title('Original Audio Signal');
hold on;

Fs2 = input('Enter the sampling frequency: ');
figure(2);
y2 = resample(y1,Fs2,Fs1);
t = 0:1/Fs2:(length(y2)-1)/Fs2;
plot(t,y2); 
xlabel('Time')
ylabel('Amplitude')
title('Resampled Audio Signal');
hold on;

N2 = input('Enter the no. of quantization levels : ');
figure(3);
maxa = max(y2); 
mina = min(y2);
index = (maxa-mina)/(N2-1); 
u = maxa + index;
level = [mina:index:maxa];  
co = [mina:index:u]; 
[index,y3] = quantiz(y2,level,co); 
t = 0:1/Fs2:(length(y2)-1)/Fs2;
plot(t,y3);
xlabel('Time')
ylabel('Discretized Amplitude')
title('Quantized Audio Signal');

N3 = input('Enter the Modulation order to perform QAM : ');
y4 = uint8((y3 - level(1))/((maxa-mina)/(N2-1)));
y5 = qammod(y4,N3);
scatterplot(y5);
xlabel('In-Phase')
ylabel('Quadrature')
title('Scatter Plot');

y6 = qammod(y4,N3,'PlotConstellation',true);
xlabel('In Phase')
ylabel('Quadrature')
title('256-QAM, Gray Mapping, Unit Average Power = false');