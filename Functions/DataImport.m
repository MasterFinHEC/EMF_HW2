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
HM2DATA = readtable("C:\Users\Benjamin\OneDrive\Documents\GitHub\EMF_HW2\DATA_HW2.xlsx", opts, "UseExcel", false);
clear opts

%% Creating the vectors we will use

txt = HM2DATA.Properties.VariableNames; %Extract the Variables Names
names = txt(2:end); %Vector of Names (Mainly used for plots)
price = table2array(HM2DATA(2:end,2:end)); %Take out the date from the matrix of price
date = datetime(table2array(HM2DATA(2:end,1))); %Vector of date
clear HM2DATA