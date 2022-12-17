clc;
clear ;
close all;
load China_compare.mat
%% 所有模型结果
all_res = [KELM_China_realdata
    KELM_China_forecast
    LSSVM_China_forecastdata
    CSA_LSSVM_China_forecastdata
   CPA_KELM_China_forecastdata
   CSA_LSSVM_SSC_China_VMD_sum_forecastdata
    CPA_KELM_SSC_China_VMD_sum_forecastdata
    CSA_LSSVM_SSC_China_VMD_iowa_forecastdata
    CPA_KELM_SSC_China_VMD_iowa_sum_forecastdata_err];
 [A B] = size(all_res);
%% 全部模型对比
figure(2)
subplot(2,1,1)
box on;
hold on
plot(all_res(1,:),'-- ','LineWidth',2,'Color','#63B2EE');
plot(all_res(2,:),'-- ','LineWidth',2,'Color','#76da91 ');
plot(all_res(3,:),'-- ','LineWidth',2,'Color','#f8cb7f ');
plot(all_res(4,:),'-- ','LineWidth',2,'Color','#f89588 ');
plot(all_res(5,:),'-- ','LineWidth',2,'Color','#7cd6cf');
plot(all_res(6,:),'LineWidth',2,'Color','#7cd6cf ');
plot(all_res(7,:),'LineWidth',2,'Color','#41b7ac  ');
plot(all_res(8,:),'LineWidth',2,'Color','#ffa510  ');
plot(all_res(9,:),'LineWidth',2,'Color','#3b6291  ');
set(gca,'FontName','Times New Roman','FontSize',20)
set(gca,'xtick',[0:20:141])
xlim([1 B])
ylim([22 40])
xlabel('Sample points')
ylabel('Carbon emissions/(MT)')
hl =legend('Actual Data','KELM','LSSVM','CSA-LSSVM','CPA-KELM','C-CSSD-VMD-CSA-LSSVM','C-CSSD-VMD-CPA-KELM','C-CSSD-VMD-CPA-KELM-IOWA-CSA-LSSVM','C-CSSD-VMD-CPA-KELM-IOWA-CSA-LSSVM-EC','NumColumns',2,'FontName','Times New Roman','FontSize',24);
set(hl,'Box','off');
% 部分图
subplot(2,1,2)
box on;
hold on
plot(all_res(1,:),'-- ','LineWidth',2,'Color','#63B2EE');
plot(all_res(2,:),'-- ','LineWidth',2,'Color','#76da91 ');
plot(all_res(3,:),'-- ','LineWidth',2,'Color','#f8cb7f ');
plot(all_res(4,:),'-- ','LineWidth',2,'Color','#f89588 ');
plot(all_res(5,:),'-- ','LineWidth',2,'Color','#7cd6cf');
plot(all_res(6,:),'LineWidth',2,'Color','#7cd6cf ');
plot(all_res(7,:),'LineWidth',2,'Color','#eddd86   ');
plot(all_res(8,:),'LineWidth',2,'Color','#ffa510  ');
plot(all_res(9,:),'LineWidth',2,'Color','#3b6291  ');
set(gca,'FontName','Times New Roman','FontSize',20)
set(gca,'xtick',[0:10:140])
set(gca,'ytick',[]);
xlim([40 50])

%% 误差图
figure
box on;
hold on;
plot(all_res(2,:)-all_res(1,:),'-- ','LineWidth',3,'Color','#63B2EE');
plot(all_res(3,:)-all_res(1,:),'-- ','LineWidth',3,'Color','#76da91 ');
plot(all_res(4,:)-all_res(1,:),'-- ','LineWidth',3,'Color','#f8cb7f ');
plot(all_res(5,:)-all_res(1,:),'-- ','LineWidth',3,'Color','#f89588 ');
plot(all_res(6,:)-all_res(1,:),'- ','LineWidth',3,'Color','#7cd6cf');
plot(all_res(7,:)-all_res(1,:),'g-','LineWidth',3);
plot(all_res(8,:)-all_res(1,:),'b-','LineWidth',3);
plot(all_res(9,:)-all_res(1,:),'r-','LineWidth',3);
 err(:,1)=all_res(2,:)-all_res(1,:); 
 err(:,2)=all_res(3,:)-all_res(1,:); 
 err(:,3)=all_res(4,:)-all_res(1,:); 
 err(:,4)=all_res(5,:)-all_res(1,:); 
 err(:,5)=all_res(6,:)-all_res(1,:); 
 err(:,6)=all_res(7,:)-all_res(1,:); 
 err(:,7)=all_res(8,:)-all_res(1,:); 
 err(:,8)=all_res(9,:)-all_res(1,:); 
set(gca,'FontName','Times New Roman','FontSize',24)
set(gca,'xtick',[0:20:140])
xlim([1 B])
xlabel('Sample points','FontName','Times New Roman','FontSize',24)
ylabel('Amplitude','FontName','Times New Roman','FontSize',24);
hl =legend('KELM','LSSVM','CSA-LSSVM','CPA-KELM','C-CSSD-VMD-CSA-LSSVM','C-CSSD-VMD-CPA-KELM','C-CSSD-VMD-CPA-KELM-IOWA-CSA-LSSVM','C-CSSD-VMD-CPA-KELM-IOWA-CSA-LSSVM-EC','NumColumns',2,'FontName','Times New Roman','FontSize',24);
set(hl,'Box','off');
set(gca,'looseInset',[0 0 0 0])
