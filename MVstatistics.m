df1=zscore(table2array(TimeFrame1));
df2=zscore(table2array(TimeFrame2));
df3=zscore(table2array(TimeFrame3));
df4=zscore(table2array(TimeFrame4));
df5=zscore(table2array(TimeFrame1));
df6=zscore(table2array(TimeFrame2));
df7=zscore(table2array(TimeFrame3));
df8=zscore(table2array(TimeFrame4));
df9=zscore(table2array(TimeFrame1));
df10=zscore(table2array(TimeFrame2));
[pc] = pca(table2array(TimeFrame3),'NumComponents',4);
[coeff1,score1,latent1,tsquared1,explained1,mu1] = pca(df1,'NumComponents',4);
[coeff2,score2,latent2,tsquared2,explained2,mu2] = pca(df2,'NumComponents',4);
[coeff3,score3,latent3,tsquared3,explained3,mu3] = pca(df3,'NumComponents',4);
[coeff4,score4,latent4,tsquared4,explained4,mu4] = pca(df4,'NumComponents',4);
[coeff5,score5,latent5,tsquared5,explained5,mu5] = pca(df5,'NumComponents',4);
[coeff6,score6,latent6,tsquared6,explained6,mu6] = pca(df6,'NumComponents',4);
[coeff7,score7,latent7,tsquared7,explained7,mu7] = pca(df7,'NumComponents',4);
[coeff8,score8,latent8,tsquared8,explained8,mu8] = pca(df8,'NumComponents',4);
[coeff9,score9,latent9,tsquared9,explained9,mu9] = pca(df9,'NumComponents',4);
[coeff10,score10,latent10,tsquared10,explained10,mu10] = pca(df10,'NumComponents',4);
[res1,recon1] = pcares(table2array(TimeFrame1),4);
[res2,recon2] = pcares(table2array(TimeFrame2),4);
[res3,recon3] = pcares(table2array(TimeFrame3),4);
[res4,recon4] = pcares(table2array(TimeFrame4),4);
[res5,recon5] = pcares(table2array(TimeFrame5),4);
[res6,recon6] = pcares(table2array(TimeFrame6),4);
[res7,recon7] = pcares(table2array(TimeFrame7),4);
[res8,recon8] = pcares(table2array(TimeFrame8),4);
[res9,recon9] = pcares(table2array(TimeFrame9),4);
[res10,recon10] = pcares(table2array(TimeFrame10),4);

% theta1 = trace(res1*res1'/(size(TimeFrame1,1)-1));
% theta2 = trace((res1*res1'/(size(TimeFrame1,1)-1)).^2);
% theta3 = trace((res1*res1'/(size(TimeFrame1,1)-1)).^3);
% h0 = 1 - (2*theta1*theta3)/(3*theta2^2);
% ca=2.57; % standard deviate for alpha=0.01
% Qa = theta1*( ca*sqrt(2*theta2*h0^2)/theta1 + 1 + (theta2*h0*(h0-1))/(theta1^2))^(1/h0);
% L=length(res2)-1
%   for j=1:10
%       x=res2(:,j)
%       [h,p,q,c]=lbqtest(x,'Lags',1:L,'Alpha',0.05);
%       qstat2(:,j)=q;
%   end
%   
k=1;
qst=qstat(res3);
qstatistics{k}=qst;
k=k+1;
j=1; 
sp1=spe(df3,coeff3,score3);
sp{j}=sp1';
j=j+1;
q=sum(qst,2);
q1=lbqtest(sp1,'Lags',1:(length(sp1)-1),'Alpha',0.05);
t=1:length(sp1);
t1=1:length(qst);
figure;
subplot(3,1,1);
plot(t,tsquared3,'b');
xlabel('No of Observations');
ylabel('t2 Statistics');
subplot(3,1,2);
plot(t,sp1,'k');
xlabel('No of Observations');
ylabel('Squared Prediction Error');
subplot(3,1,3);
plot(t1,q,'r');
xlabel('No of Observations');
ylabel('Q Staistics');

title('PCA Hotelling T Squared and SPE(Q) Statistics');

figure;
mapcaplot(pc)

%x1=qstatistics{3}(:,1);
y1=t2s{3}(1:(length(t2s{3})-1),1);
%y2=sp{1}(1:(length(sp{3})-1),1);
y=tsquared3;
x=sp1;
ds=[y,x];
figure;
%[stats3,plotdata3]=EWMAMonitoring(sp1,tsquared3);
[stats1,plotdata1] = controlchart(sp1,'charttype', 'ewma','lambda', 0.20);
%x = stats.mean;
cl = stats1.mu;
se = stats1.sigma./sqrt(stats1.n);
hold on
plot(cl+2*se,'m')
xlabel('No of Observations')
ylabel('Exponentially-weighted moving average value (units)');
title('EWMA Chart On SPE');
figure;
[stats2,plotdata2] = controlchart(tsquared3,'charttype', 'ewma','lambda', 0.20);
%x = stats.mean;
cl2 = stats2.mu;
se2 = stats2.sigma./sqrt(stats2.n);
hold on
plot(cl2+2*se2,'k')
xlabel('No of Observations')
ylabel('Exponentially-weighted moving average value (units)')
title('EWMA Chart On T-Squared');


figure;
[stats3,plotdata3] = controlchart(q,'charttype', 'ewma','lambda', 0.20);
%x = stats.mean;
% cl3 = stats3.mu;
% se3 = stats3.sigma./sqrt(stats3.n);
% hold on
% plot(cl3+2*se3,'k')
xlabel('No of Observations')
ylabel('Exponentially-weighted moving average value (units)')
title('EWMA Chart On Q Staistics');

figure;
[s,pld]=controlchart(ds,'charttype',{'xbar','r'});