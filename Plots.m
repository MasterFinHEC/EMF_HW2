%% Plots
f = figure('visible','off');
histfit(StStat_betas);
hold on
xline(CriticalValue_1,'color','r','Label','Critical Value 1%','LineWidth',2,'LabelHorizontalAlignment','left','LabelVerticalAlignment','top');
hold on
xline(meantStat,'color','k','Label','mean','LineWidth',2,'LabelOrientation','horizontal','LabelHorizontalAlignment','right','LabelVerticalAlignment','top');
hold on
xline(CriticalValue_5,'color','r','Label','Critical Value 5%','LineWidth',2,'LabelHorizontalAlignment','left','LabelVerticalAlignment','top');
hold on
xline(CriticalValue_10,'color','r','Label','Critical Value 10%','LineWidth',2,'LabelHorizontalAlignment','right','LabelVerticalAlignment','top');
title('Histogram of tStats')
xlabel('tStats')
ylabel('Frequency')
saveas(f,'Plots/HistogramBetas.png')

%% CDF plots
%Sim360
[a,y]=ecdf(tStat_betas);
[g,z]=ecdf(tStat_Sim360);

f = figure('visible','off');
plot(y,a)
hold on
plot(z,g)
title('Cumulative distribution function Comparative')
xlabel('x')
ylabel('F(x)')
legend('null hypothesis','360 days & phi 0.96','location','southeast')
saveas(f,'Plots/CumDistribution360.png')

%Sim368
[a,y]=ecdf(tStat_betas);
[g,z]=ecdf(tStat_Sim368);

f = figure('visible','off');
plot(y,a)
hold on
plot(z,g)
title('Cumulative distribution function Comparative')
xlabel('x')
ylabel('F(x)')
legend('null hypothesis','360 days & phi 0.8','location','southeast')
saveas(f,'Plots/CumDistribution368.png')

%Sim368
[a,y]=ecdf(tStat_betas);
[g,z]=ecdf(tStat_Sim100);

f = figure('visible','off');
plot(y,a)
hold on
plot(z,g)
title('Cumulative distribution function Comparative')
xlabel('x')
ylabel('F(x)')
legend('null hypothesis','100 days & phi 0.96','location','southeast')
saveas(f,'Plots/CumDistribution100.png')

%Sim8

[a,y]=ecdf(tStat_betas);
[g,z]=ecdf(tStat_Sim8);

f = figure('visible','off');
plot(y,a)
hold on
plot(z,g)
title('Cumulative distribution function Comparative')
xlabel('x')
ylabel('F(x)')
legend('null hypothesis','100 days & phi 0.8','location','southeast')
saveas(f,'Plots/CumDistribution8.png')

%Plot all together

[a,y]=ecdf(tStat_betas);
[g,z]=ecdf(tStat_Sim360);
[w,u]=ecdf(tStat_Sim368);
[o,q]=ecdf(tStat_Sim100);
[v,m]=ecdf(tStat_Sim8);

f = figure('visible','off');
plot(y,a)
hold on
plot(z,g)
hold on
plot(u,w)
hold on
plot(q,o)
hold on
plot(m,v)
title('Cumulative distribution function Comparative all together')
xlabel('x')
ylabel('F(x)')
legend('null hypothesis','360 days & phi 0.96','360 days & phi 0.8','100 days & phi 0.96','100 days & phi 0.8','Location','southeast','FontSize',6)
saveas(f,'Plots/CumDistributionall.png')

%% 3

% Histogram of tStat of Residuals

f = figure('visible','off');
histfit(StStat_R);
hold on
xline(CriticalValueR_1,'color','r','Label','Critical Value 1%','LineWidth',2,'LabelHorizontalAlignment','left','LabelVerticalAlignment','top');
hold on
xline(meantStatR,'color','k','Label','mean','LineWidth',2,'LabelOrientation','horizontal','LabelHorizontalAlignment','right','LabelVerticalAlignment','top');
hold on
xline(CriticalValueR_5,'color','r','Label','Critical Value 5%','LineWidth',2,'LabelHorizontalAlignment','left','LabelVerticalAlignment','top');
hold on
xline(CriticalValueR_10,'color','r','Label','Critical Value 10%','LineWidth',2,'LabelHorizontalAlignment','right','LabelVerticalAlignment','top');
title('Histogram tStats Residuals')
xlabel('tStats')
ylabel('Frequency')
saveas(f,'Plots/HistogramR.png')
