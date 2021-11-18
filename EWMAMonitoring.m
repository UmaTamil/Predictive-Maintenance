function [stats,plotdata]=EWMAMonitoring(sp1,tsquared3)
ds=[sp1',tsquared3];
[stats,plotdata] = controlchart(sp1,'charttype', 'ewma','lambda', 0.20);
%x = stats.mean;
cl = stats.mu;
se = stats.sigma./sqrt(stats.n);
hold on
plot(cl+2*se,'m')
title('EWMA chart for quality characteristics')
xlabel('No of Observations')
ylabel('Exponentially-weighted moving average value (units)')
%R = controlrules('we3',x,cl,se);
%I = find(R);
end
