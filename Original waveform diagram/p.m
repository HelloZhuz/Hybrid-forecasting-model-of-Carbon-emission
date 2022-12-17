clc
clear 
close all
%% Load data
    data = [];
    load('China_total.mat')
    data = [data,china_total'];
    load('US_total.mat')
    data = [data,US_total'];
for i = 1:2
        Mean(:,i) = mean(data(:,i));
        Max(:,i) = max(data(:,i));
        Min(:,i) = min(data(:,i));
        Std(:,i) = std(data(:,i));
end
%% Draft
C = parula(7);
figure(1) 
MTrain=651;
t = datetime(2020,1,1) + (0:length(data)-1);
% plot(t(1:651),data(1:651,i),'Color',[254,129,125]/256,t(651:790),data(651:end,i),'r','LineWidth',1.1);
plot(t(1:651),data(1:651,1),'LineWidth',3,'Color',[128,184,223]/256);
hold on;
plot(t(651:790),data(651:end,1),'LineWidth',3,'Color',[254,129,125]/256);
ax = gca;
ax.XLim = [t(1),t(length(data))];
ax.YLim = [18 40];
set(gca,'FontName','Time New Roman','FontSize',24)
xlabel('Time(d)')
ylabel('Carbon emission(mt)')
% ylabel('碳排放/万吨')
set(gca,'looseInset',[0 0 0.01 0])
line([t(650) t(650)],[18 40],'linestyle','- -', 'Color','k', 'LineWidth', 3);


figure(2) 
MTrain=651;
t = datetime(2020,1,1) + (0:length(data)-1);
% plot(t(1:651),data(1:651,i),'Color',[254,129,125]/256,t(651:790),data(651:end,i),'r','LineWidth',1.1);
plot(t(1:651),data(1:651,2),'LineWidth',3,'Color',[128,184,223]/256);
hold on;
plot(t(651:790),data(651:end,2),'LineWidth',3,'Color',[254,129,125]/256);
ax = gca;
ax.XLim = [t(1),t(length(data))];
ax.YLim = [8 20];
set(gca,'FontName','Time New Roman','FontSize',24)
xlabel('Time(d)')
ylabel('Carbon emission(mt)')
% ylabel('碳排放/万吨')
set(gca,'looseInset',[0 0 0.01 0])
line([t(650) t(650)],[8 20],'linestyle','- -', 'Color','k', 'LineWidth', 3);
