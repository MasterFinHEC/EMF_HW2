%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EMPIRICAL METHODS FOR FINANCE
% Homework II
%
% Benjamin Souane, Antoine-Michel Alexeev and Julien Bisch
% Due Date: 2 April 2020
%==========================================================================

close all
clc
%import KevinShepperd Toolbox
cd('C:\Users\41797\Desktop\UNIL-Master\EMF\Homework2');
addpath(genpath('C:\Users\41797\Desktop\UNIL-Master\EMF\Homework2\mfe-toolbox-master'));

%% Setup the Import Options and import the data
opts = spreadsheetImportOptions("NumVariables", 5);

% Specify sheet and range
opts.Sheet = "Sheet1";
opts.DataRange = "A2:E362";

% Specify column names and types
opts.VariableNames = ["date", "TOTMKUS(PI)", "TOTMKUS(DY)", "TOTMKUK(PI)", "TOTMKUK(DY)"];
opts.VariableTypes = ["datetime", "double", "double", "double", "double"];

% Specify variable properties
opts = setvaropts(opts, "date", "InputFormat", "");

% Import the data
HM2DATA = readtable("C:\Users\41797\Desktop\UNIL-Master\EMF\Homework2\DATA_HW2.xlsx", opts, "UseExcel", false);
clear opts

%% Creating the vectors we will use

txt = HM2DATA.Properties.VariableNames; %Extract the Variables Names
names = txt(2:end); %Vector of Names (Mainly used for plots)
price = table2array(HM2DATA(2:end,2:end)); %Take out the date from the matrix of price
date = datetime(table2array(HM2DATA(2:end,1))); %Vector of date

%% 2. Stationarity test

%% 2.a Computing critical values

% 1.
N=10000;
T=size(date,1);
SimPrices=zeros(T,N);
eps_t=normrnd(0,1,[T,N]);

%% 2.
SimPrices(2:end,:)=cumsum(eps_t(2:end,:),1);

%% 3.
% Estimate AR(1) model under alternative hyp.

Delta_SimP=diff(SimPrices);
tStat_betas=zeros(N,1);
betas=zeros(N,1);
sds=zeros(N,1);

disp('Run regression')
for n=1:N
    Sim_OLS=fitlm(SimPrices(1:end-1,n),Delta_SimP(:,n));
    tStat_betas(n)=Sim_OLS.Coefficients.tStat(2);
    betas(n)=Sim_OLS.Coefficients.Estimate(2);
    sds(n)=Sim_OLS.Coefficients.SE(2);
end

%% 4.

StStat_betas=sort(tStat_betas); %Sort the betas test

%% 5.
% Computing quantiles

CriticalValue_1=quantile(tStat_betas,0.01);
CriticalValue_5=quantile(tStat_betas,0.05);
CriticalValue_10=quantile(tStat_betas,0.1);
CriticalValues=[CriticalValue_1,CriticalValue_5,CriticalValue_10];
CriticalValues=array2table(CriticalValues,'VariableNames',{'One','Five','Ten'},'RowNames',{'CriticalValues'});
filename = 'Results/CriticalValues.xlsx';
writetable(CriticalValues,filename,'Sheet',1,'Range','D1','WriteRowNames',true)

%% Normal distribution with tStat_betas parameters

meantStat=mean(tStat_betas);

%% 2.b Testing non-stationarity

% Computing log-prices
logUS=log(price(1:end-1,1));
logUK=log(price(1:end-1,3));

deltaUS.p=diff(log(price(:,1)));
deltaUK.p=diff(log(price(:,3)));

disp('Run p regression')
% Doing regression for prices
OLS_US_p=fitlm(logUS,deltaUS.p);
OLS_UK_p=fitlm(logUK,deltaUK.p);

US_Est_p=table2array(OLS_US_p.Coefficients(2,1));
UK_Est_p=table2array(OLS_UK_p.Coefficients(2,1));
US_tStat_p=table2array(OLS_US_p.Coefficients(2,3));
UK_tStat_p=table2array(OLS_UK_p.Coefficients(2,3));

% Wee compute the same for the dividends
%Computing dividends first

DivUS=price(:,1).*((price(:,2)/100)/12);
DivUK=price(:,3).*((price(:,4)/100)/12);

% Computing log-prices
DivlogUS=log(DivUS(1:end-1));
DivlogUK=log(DivUK(1:end-1));

deltaUS.d=diff(log(DivUS));
deltaUK.d=diff(log(DivUK));

disp('Run d regression')

% Doing a regression
OLS_US_d=fitlm(DivlogUS,deltaUS.d);
OLS_UK_d=fitlm(DivlogUK,deltaUK.d);

US_Est_d=table2array(OLS_US_d.Coefficients(2,1));
UK_Est_d=table2array(OLS_UK_d.Coefficients(2,1));
US_tStat_d=table2array(OLS_US_d.Coefficients(2,3));
UK_tStat_d=table2array(OLS_UK_d.Coefficients(2,3));

% Create a table with the results
tStat_data=[US_tStat_p,US_tStat_d,UK_tStat_p,UK_tStat_d];
tStat_data=array2table(tStat_data,'VariableNames',{'US Price','US Dividend','UK Price','UK Dividend'},'RowNames',{'tStat'});
filename = 'Results/tStat_data.xlsx';
writetable(tStat_data,filename,'Sheet',1,'Range','D1','WriteRowNames',true)


%% 2.c Power of the test

disp('AR(1) 360')
% Simulates 360 days from an AR(1) with phi = 0.96
[tStat_Sim360]=ARSimulation(T,N,0.96);
x = (tStat_Sim360 <= CriticalValue_5 | tStat_Sim360 >= abs(CriticalValue_5)); % define a vector of binary variables for test decision
Power_of_test_360 = nnz(x)/N;

disp('AR(1) 368')
% Simulates 360 days from an AR(1) with phi = 0.8
[tStat_Sim368]=ARSimulation(T,N,0.8);
x = (tStat_Sim368 <= CriticalValue_5 | tStat_Sim368 >= abs(CriticalValue_5)); % define a vector of binary variables for test decision
Power_of_test_368 = nnz(x)/N;

disp('AR(1) 100')
% Simulates 100 days from an AR(1) with phi = 0.96
[tStat_Sim100]=ARSimulation(100,N,0.96);
x2 = (tStat_Sim100 <= CriticalValue_5 | tStat_Sim100 >= abs(CriticalValue_5)); % define a vector of binary variables for test decision
Power_of_test_100 = nnz(x2)/N;

disp('AR(1) 0.8')
% Simulates 100 days from an AR(1) with phi = 0.80
[tStat_Sim8]=ARSimulation(100,N,0.8);
x3 = (tStat_Sim8 <= CriticalValue_5 | tStat_Sim8 >= abs(CriticalValue_5)); % define a vector of binary variables for test decision
Power_of_test_8 = nnz(x3)/N;

Power_of_test=[Power_of_test_360,Power_of_test_368,Power_of_test_100,Power_of_test_8];
Power_of_test=array2table(Power_of_test,'VariableNames',{'360','368','100','0.8'},'RowNames',{'PowerOfTest'});
filename = 'Results/PowerOfTest.xlsx';
writetable(Power_of_test,filename,'Sheet',1,'Range','D1','WriteRowNames',true)

%% Cointegration test


%% Plots
disp('plotting')
Plots
%% Latex
tabletolatex2