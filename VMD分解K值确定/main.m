clc;clear;close all;

load SSC_China_K.mat
figure
x=1:10;
plot(1:1:10,VMD_K,'r*-')
str1=num2str(VMD_K');
text(x,VMD_K,str1);
ylabel('Correlation coefficient')
xlabel('\itK')
set(gca,'xtick',[1:1:10]);

load SSC_US_K.mat
figure
x=1:10;
plot(1:1:10,VMD_K,'r*-')
str1=num2str(VMD_K');
text(x,VMD_K,str1);
ylabel('Correlation coefficient')
xlabel('\itK')
set(gca,'xtick',[1:1:10]);