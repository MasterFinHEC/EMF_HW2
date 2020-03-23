function [intercept,tStat,betas,sds,residuals]=regression(x,y)

reg=fitlm(x,y);
tStat=reg.Coefficients.tStat(2);
betas=reg.Coefficients.Estimate(2);
sds=reg.Coefficients.SE(2);
residuals=table2array(reg.Residuals(:,1));
intercept=reg.Coefficients.Estimate(1);
end
