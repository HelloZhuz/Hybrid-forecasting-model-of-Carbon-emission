clc
clear
close all

load All_data;
x=data(:,2);

N=length(x);
mm=50;
y=meanph(x,mm);
X=y;
fs = 1;               % signal sampling frequency
tmax = 50;             % maximum discrete stepping time
p = 12;                 % sequence average period

%-----------------------------------------------------------------
% Calculation function
Y = Lyapunov_rosenstein_2(X,fs,tmax,p);
I = [0:length(Y)-1]';
linear = [1:5]';  % Linear region
F1 = polyfit(I(linear),Y(linear),1);
Y1 = polyval(F1,I(linear),1);
%-----------------------------------------------------------------
% result
Lyapunov1_e = F1(1)*log(2);
fprintf('Maximum Lyapunov exponent = %.4f\n',Lyapunov1_e);
