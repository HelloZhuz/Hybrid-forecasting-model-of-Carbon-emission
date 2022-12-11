clc;clear;close all
load SSD_China_NNetEn.txt
load SSD_US_NNetEn.txt
figure 
plot(2:1:10,SSD_China_NNetEn,'r-*');
xlabel('SSCs');
ylabel('The value of NNetEn');
axis([2 10 0.15 0.35])
set(gca,'xtick',[2:1:10]);
figure 
plot(2:1:13,SSD_US_NNetEn,'r-*');
xlabel('SSCs');
ylabel('The value of NNetEn');
axis([2 13 0.2 0.35])
set(gca,'xtick',[2:1:13]);
