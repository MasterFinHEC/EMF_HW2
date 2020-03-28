%% AR(1) Simulation + Regression

function [tStat_Sim]=ARSimulation(T,N,phi)

SimAR=zeros(T,N);
constant = 0; ARorder = 1;
for n=1:N
    p_s = armaxfilter_simulate(T, constant, ARorder, phi);
    SimAR(:,n)=p_s;
end

% Computing the regression
tStat_Sim=zeros(N,1);
for n=1:N
    Sim_OLS=fitlm(SimAR(1:end-1,n),diff(SimAR(:,n)));
    tStat_Sim(n)=table2array(Sim_OLS.Coefficients(2,3));
end
end
