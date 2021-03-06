%% Plots

%% 2.
%Plot histogram of t-stats
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

%Plot histogram of the intercepts
f = figure('visible','off');
histfit(mus);
hold on
xline(meanmus,'color','k','Label','mean','LineWidth',2,'LabelOrientation','horizontal','LabelHorizontalAlignment','right','LabelVerticalAlignment','top');
title('Histogram of intercepts')
xlabel('Intercepts')
ylabel('Frequency')
saveas(f,'Plots/mus.png')

% CDF plots
%Computing the density points
[a,y]=ecdf(tStat_betas);
[g,z]=ecdf(tStat_Sim360);
[w,q]=ecdf(tStat_Sim368);
[o,l]=ecdf(tStat_Sim100);
[s,u]=ecdf(tStat_Sim8);

%Sim360
f = figure('visible','off');
plot(y,a)
hold on
plot(z,g)
hold on
title('Cumulative distribution function Comparative')
xlabel('x')
ylabel('F(x)')
legend('null hypothesis','360 days & phi 0.96','location','southeast')
saveas(f,'Plots/CumDistribution360.png')

% Sim368
f = figure('visible','off');
plot(y,a)
hold on
plot(q,w)
title('Cumulative distribution function Comparative')
xlabel('x')
ylabel('F(x)')
legend('null hypothesis','360 days & phi 0.8','location','southeast')
saveas(f,'Plots/CumDistribution368.png')

%Sim368
f = figure('visible','off');
plot(y,a)
hold on
plot(l,o)
title('Cumulative distribution function Comparative')
xlabel('x')
ylabel('F(x)')
legend('null hypothesis','100 days & phi 0.96','location','southeast')
saveas(f,'Plots/CumDistribution100.png')

%Sim8
f = figure('visible','off');
plot(y,a)
hold on
plot(u,s)
title('Cumulative distribution function Comparative')
xlabel('x')
ylabel('F(x)')
legend('null hypothesis','100 days & phi 0.8','location','southeast')
saveas(f,'Plots/CumDistribution8.png')

% Histograms of the t-stats
f = figure('visible','off');
histogram(tStat_Sim360);
hold on
histogram(StStat_betas);
title('Histogram of t-stats comparative')
xlabel('t-Stats')
ylabel('Frequency')
legend('null hypothesis','360 days & phi 0.96','location','southeast')
saveas(f,'Plots/HistSim360.png')

f = figure('visible','off');
histogram(tStat_Sim368);
hold on
histogram(StStat_betas);
title('Histogram of t-stats comparative')
xlabel('t-Stats')
ylabel('Frequency')
legend('null hypothesis','368 days & phi 0.8','location','southeast')
saveas(f,'Plots/HistSim368.png')

f = figure('visible','off');
histogram(tStat_Sim100);
hold on
histogram(StStat_betas);
title('Histogram of t-stats comparative')
xlabel('t-Stats')
ylabel('Frequency')
legend('null hypothesis','100 days & phi 0.96','location','southeast')
saveas(f,'Plots/HistSim100.png')

f = figure('visible','off');
histogram(tStat_Sim8);
hold on
histogram(StStat_betas);
title('Histogram of t-stats comparative')
xlabel('t-Stats')
ylabel('Frequency')
legend('null hypothesis','100 days & phi 0.8','location','southeast')
saveas(f,'Plots/HistSim8.png')

%% 3
% Histogram of tStat of Residuals
f = figure('visible','off');
histfit(StStat_R);
hold on
xline(CriticalValueR_1,'color','r','Label','Critical Value 1%','LineWidth',2,'LabelHorizontalAlignment','left','LabelVerticalAlignment','top');
hold on
xline(meantStat_R,'color','k','Label','mean','LineWidth',2,'LabelOrientation','horizontal','LabelHorizontalAlignment','right','LabelVerticalAlignment','top');
hold on
xline(CriticalValueR_5,'color','r','Label','Critical Value 5%','LineWidth',2,'LabelHorizontalAlignment','left','LabelVerticalAlignment','top');
hold on
xline(CriticalValueR_10,'color','r','Label','Critical Value 10%','LineWidth',2,'LabelHorizontalAlignment','right','LabelVerticalAlignment','top');
title('Histogram tStats Residuals')
xlabel('tStats')
ylabel('Frequency')
saveas(f,'Plots/HistogramR.png')

%Histogram of intercepts
f = figure('visible','off');
histfit(musR);
hold on
xline(meanmusR,'color','k','Label','mean','LineWidth',2,'LabelOrientation','horizontal','LabelHorizontalAlignment','right','LabelVerticalAlignment','top');
title('Histogram of intercepts')
xlabel('Intercepts')
ylabel('Frequency')
saveas(f,'Plots/musR.png')

%DDM
f = figure('visible','off');
plot(date,logUS)
hold on
plot(date,DDMUS)
title('DDM US')
xlabel('Date')
ylabel('log Prices')
legend('US log Prices','DDM US','location','southeast')
saveas(f,'Plots/DDMUS.png')

f = figure('visible','off');
plot(date,logUK)
hold on
plot(date,DDMUK)
title('DDM UK')
xlabel('Date')
ylabel('log Prices')
legend('UK log Prices','DDM UK','location','southeast')
saveas(f,'Plots/DDMUK.png')