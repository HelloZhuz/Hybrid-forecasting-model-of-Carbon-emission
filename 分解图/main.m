clc;clear;close all
%% 中国的C-CSSD分解
load SSC_China.mat
ssc_len = length(SSC);
h3 = figure('NumberTitle','on','Name','SSD分解结果');
set(h3,'position',[378,270,603,197]);
k=size(SSC,1);       %返回矩阵行数
n=round(k/2);
for i = 1:n
    subplot(n,2,2*i-1);
    ssc = SSC(i,:);
    clor = [rand rand rand];
    plot(ssc, 'Color', clor);
    title (['SSC' num2str(i)], 'Color', clor, 'BackgroundColor','none', ...,'Position',[1287.50245571136,0.410722021094829,0]
        'HorizontalAlignment','left', 'VerticalAlignment','middle');
    xlim([0 ssc_len])
    if i < n                % 前m-1个分量绘图
        set(gca,'xtick',[]) % set函数 将当前图形（gca）的x轴坐标刻度（xtick）标志为空
    end
    set(gca, 'box', 'off') % 去掉上边和右边的边框
    set(gca,'FontName','Times New Roman','fontsize', 10);% 坐标轴刻度字体大小
    set(get(gca,'XLabel'),'FontSize', 10);
    set(get(gca,'YLabel'),'FontName','Times New Roman','FontSize', 10);
    set(get(gca,'Title'),'FontSize', 10);
    set(gca,'looseInset',[0 0 0 0]) % [左,下,右,上]
end
xlabel('Sample points');
for i = n+1:k
    subplot(k-n,2,2*(i-n));
    ssc = SSC(i,:);
    clor = [rand rand rand];
    plot(ssc, 'Color', clor);
    title (['SSC' num2str(i)], 'Color', clor, 'BackgroundColor','none', ...,'Position',[1287.50245571136,0.410722021094829,0]
        'HorizontalAlignment','left', 'VerticalAlignment','middle');
    xlim([0 ssc_len])
    if i < k                % 前m-1个分量绘图
        set(gca,'xtick',[]) % set函数 将当前图形（gca）的x轴坐标刻度（xtick）标志为空
    end
    set(gca, 'box', 'off') % 去掉上边和右边的边框
    set(gca, 'YTick', [min(ssc) max(ssc)]);
     set(gca,'YTickLabel',{num2str(min(ssc),'%.1f\n'),num2str(max(ssc),'%.1f\n')}); % 设置Y轴刻度值
     set(gca,'FontName','Times New Roman','fontsize', 10);% 坐标轴刻度字体大小
    set(get(gca,'XLabel'),'FontSize', 10);
    set(get(gca,'YLabel'),'FontName','Times New Roman','FontSize', 10 );
    set(get(gca,'Title'),'FontSize', 10);
    set(gca,'looseInset',[0 0 0 0]) % [左,下,右,上]
end
xlabel('Sample points');
%% 美国的C-CSSD分解
load SSC_US.mat
ssc_len = length(SSC);
h3 = figure('NumberTitle','on','Name','SSD分解结果');
set(h3,'position',[378,270,603,197]);
k=size(SSC,1);       %返回矩阵行数
n=round(k/2);
for i = 1:n
    subplot(n,2,2*i-1);
    ssc = SSC(i,:);
    clor = [rand rand rand];
    plot(ssc, 'Color', clor);
    title (['SSC' num2str(i)], 'Color', clor, 'BackgroundColor','none', ...,'Position',[1287.50245571136,0.410722021094829,0]
        'HorizontalAlignment','left', 'VerticalAlignment','middle');
    xlim([0 ssc_len])
    if i < n                % 前m-1个分量绘图
        set(gca,'xtick',[]) % set函数 将当前图形（gca）的x轴坐标刻度（xtick）标志为空
    end
    set(gca, 'box', 'off') % 去掉上边和右边的边框
    set(gca,'FontName','Times New Roman','fontsize', 10);% 坐标轴刻度字体大小
    set(get(gca,'XLabel'),'FontSize', 10);
    set(get(gca,'YLabel'),'FontName','Times New Roman','FontSize', 10);
    set(get(gca,'Title'),'FontSize', 10);
    set(gca,'looseInset',[0 0 0 0]) % [左,下,右,上]
end
xlabel('Sample points');
for i = n+1:k
    subplot(k-n,2,2*(i-n));
    ssc = SSC(i,:);
    clor = [rand rand rand];
    plot(ssc, 'Color', clor);
    title (['SSC' num2str(i)], 'Color', clor, 'BackgroundColor','none', ...,'Position',[1287.50245571136,0.410722021094829,0]
        'HorizontalAlignment','left', 'VerticalAlignment','middle');
    xlim([0 ssc_len])
    if i < k                % 前m-1个分量绘图
        set(gca,'xtick',[]) % set函数 将当前图形（gca）的x轴坐标刻度（xtick）标志为空
    end
    set(gca, 'box', 'off') % 去掉上边和右边的边框
    set(gca, 'YTick', [min(ssc) max(ssc)]);
     set(gca,'YTickLabel',{num2str(min(ssc),'%.1f\n'),num2str(max(ssc),'%.1f\n')}); % 设置Y轴刻度值
     set(gca,'FontName','Times New Roman','fontsize', 10);% 坐标轴刻度字体大小
    set(get(gca,'XLabel'),'FontSize', 10);
    set(get(gca,'YLabel'),'FontName','Times New Roman','FontSize', 10 );
    set(get(gca,'Title'),'FontSize', 10);
    set(gca,'looseInset',[0 0 0 0]) % [左,下,右,上]
end
xlabel('Sample points');