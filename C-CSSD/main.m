clear 
close all
clc
%% 原始信号
fs=3000;
t=(1:fs)/fs;
load y.mat
%图2.3 时域和频域图
figure
subplot(3,1,1)
plot(t,y(1,:))
ylabel('\itx\rm_1\rm(\itt\rm)','FontSize',12)
% xlabel('\itt','FontSize',14)
set(gca, 'FontName', 'Times New Roman');
subplot(3,1,2)
plot(t,y(2,:))
ylabel('\itx\rm_2\rm(\itt\rm)','FontSize',12)
% xlabel('\itt','FontSize',14)
set(gca, 'FontName', 'Times New Roman');
subplot(3,1,3)
plot(t,y(3,:))
ylabel('\ity\rm_1\rm(\itt\rm)','FontSize',12)
xlabel('\itt','FontSize',12)
set(gca, 'FontName', 'Times New Roman');

%% SSD分解
load SSC.mat
[m,~]=size(SSC);
% 画SSD分解结果图
figure
subplot(m,1,1)
plot(t,SSC(1,:),'b')
hold on
plot(t,y(1,:),':r')
legend('\itx\rm_1(\itt\rm) = (1+0.5\itsin\rm(25\it\pit\rm))\itcos\rm(170\it\pit\rm+50\it\pit\rm^2)','\itSSC\rm_2','TextColor','k','FontSize',12)
set(gca, 'FontName', 'Times New Roman');

subplot(m,1,2)
plot(t,SSC(2,:),'-.b')
hold on
plot(t,y(2,:),'r')

legend('\itx\rm_2(\itt\rm) = 2.5\itcos\rm(170\pi\itt\rm)','\itSSC\rm_1','TextColor','k','FontSize',12)
xlabel('Sample points','FontSize',12)
set(gca, 'FontName', 'Times New Roman');

load CC_SSC.mat
[cm,~]=size(CC_SSC);
%% CSSD分解结果图
figure
subplot(cm,1,1)
plot(1:fs,CC_SSC(1,:),'b')
hold on
plot(1:fs,y(1,:),':r')
legend('\itx\rm_1(\itt\rm) = (1+0.5\itsin\rm(25\it\pit\rm))\itcos\rm(170\it\pit\rm+50\it\pit\rm^2)','\itSSC\rm_2','TextColor','k','FontSize',12)
set(gca, 'FontName', 'Times New Roman');

subplot(cm,1,2)
plot(1:fs,CC_SSC(2,:),'-.b')
hold on
plot(1:fs,y(2,:),'r')

legend('\itx\rm_2(\itt\rm) = 2.5\itcos\rm(170\pi\itt\rm)','\itSSC\rm_1','TextColor','k','FontSize',12)
xlabel('Sample points','FontSize',12)
set(gca, 'FontName', 'Times New Roman');