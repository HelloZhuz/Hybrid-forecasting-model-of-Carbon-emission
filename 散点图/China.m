clc;
close all;
clear all;
% %% 加载数据
load('CSA-LSSVM_SSC_China_VMD_sum_realdata.mat')
load('China_compare.mat')

% load('CPA-KELM_SSC_US_VMD_sum_realdata.mat')
% load('US_compare.mat')

%% 相关分布图
figure(6)
n=3;
CData = 0:1/(length(sum_realdata)-1):1;% 保持数据长度一致
subplot(331)
scatter(sum_realdata(:),KELM_China_forecast(:),n,CData,'filled');colorbar;ylabel('True Data');xlabel('Predicted Data');title('M1  R^2=0.8895');set(gca,'fontname','times New Roman');
set(gca,'fontsize',12.0)
subplot(332)
scatter(sum_realdata(:),LSSVM_China_forecastdata(:),n,CData,'filled');colorbar;ylabel('True Data');xlabel('Predicted Data');title('M2 R^2=0.9191');set(gca,'fontname','times New Roman');
set(gca,'fontsize',12.0)
subplot(333)
scatter(sum_realdata(:),CSA_LSSVM_China_forecastdata(:),n,CData,'filled');colorbar;ylabel('True Data');xlabel('Predicted Data');title('M3 R^2=0.9640');set(gca,'fontname','times New Roman');
set(gca,'fontsize',12.0)
subplot(334)
scatter(sum_realdata(:),CPA_KELM_China_forecastdata(:),n,CData,'filled');colorbar;ylabel('True Data');xlabel('Predicted Data');title('M4 R^2=0.9675');set(gca,'fontname','times New Roman');
set(gca,'fontsize',12.0)
subplot(335)
scatter(sum_realdata(:),CSA_LSSVM_SSC_China_VMD_sum_forecastdata(:),n,CData,'filled');colorbar;ylabel('True Data');xlabel('Predicted Data');title('M5 R^2=0.9973');set(gca,'fontname','times New Roman');
set(gca,'fontsize',12.0)
subplot(336)
scatter(sum_realdata(:),CPA_KELM_SSC_China_VMD_sum_forecastdata(:),n,CData,'filled');colorbar;ylabel('True Data');xlabel('Predicted Data');title('M6 R^2=0.9997');set(gca,'fontname','times New Roman');
set(gca,'fontsize',12.0)
%set(gcf,'Position',[1,1,440,610]);
subplot(337)
scatter(sum_realdata(:),CSA_LSSVM_SSC_China_VMD_iowa_forecastdata(:),n,CData,'filled');colorbar;ylabel('True Data');xlabel('Predicted Data');title('M7 R^2=0.9999');set(gca,'fontname','times New Roman');
set(gca,'fontsize',12.0)
subplot(338)
scatter(sum_realdata(:),CPA_KELM_SSC_China_VMD_iowa_sum_forecastdata_err(:),n,CData,'filled');colorbar;ylabel('True Data');xlabel('Predicted Data');title('M8 R^2=0.9999');set(gca,'fontname','times New Roman');
set(gca,'fontsize',12.0)
set(gcf,'Position',[1,1,1200,800]);


% % %计算相关系数
% a=corrcoef(sum_realdata,KELM_US_forecast');zipreBp=a(1,2)
% a=corrcoef(sum_realdata,LSSVM_US_forecastdata');zipreELM=a(1,2)
% a=corrcoef(sum_realdata,CSA_LSSVM_US_forecastdata');zipreKELM=a(1,2)
% a=corrcoef(sum_realdata,CPA_KELM_US_forecastdata);zipreGKELM=a(1,2)
% a=corrcoef(sum_realdata,CSA_LSSVM_SSC_US_VMD_sum_forecastdata');zipre_EMD_GKELM=a(1,2)
% a=corrcoef(sum_realdata,CPA_KELM_SSC_US_VMD_sum_forecastdata');zipre_CEEMDAN_GKELM=a(1,2)
% a=corrcoef(sum_realdata,CSA_LSSVM_SSC_US_VMD_iowa_forecastdata);zipre_VMD_GKELM=a(1,2)
% a=corrcoef(sum_realdata,CSA_LSSVM_SSC_US_VMD_iowa_forecastdata_err);zipre_2VMD_GKELM=a(1,2)