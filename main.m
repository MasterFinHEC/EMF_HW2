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
T=1000;
SimPrices=randomwalks(N,T);

% 3.
% AR(1) process

betas=zeros(N,1); % Setting matrices for AR(1) process
Test_betas=zeros(N,1);

% Computing AR(1) process
for n=1:N
    [parameters, LL, errors, sd] = armaxfilter(SimPrices(:,n),1,1);
    beta=parameters(2);
    test=beta/(sd/sqrt(T));
    betas(n)=beta;
    Test_betas(n)=test;
end

% 4.

Test_betas=sort(Test_betas); %Sort the betas test

% 5.
DFvalues_1=zeros(N,1); %setting matrices for critical values
DFvalues_5=zeros(N,1);
DFvalues_10=zeros(N,1);

% Computing Dickey-Fuller test
for n=1:N
    [ADFstat, ADFpval, criticalvalue] = augdf(SimPrices(:,n),1,0);
    DFvalues_1(n)=criticalvalue(1);
    DFvalues_5(n)=criticalvalue(2);
    DFvalues_10(n)=criticalvalue(3);
end

% Computing mean for each critical value
mean_1=mean(DFvalues_1);
mean_5=mean(DFvalues_5);
mean_10=mean(DFvalues_10);


Plots
