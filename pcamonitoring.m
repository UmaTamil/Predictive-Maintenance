% Calculate the thresholds of Mahalanobis distance to detect 5%, 1% and
% 0.1% outliers
idx=ReadingTime;
x=table2array(TimeFrame1);
th = [0.001, 0.01, 0.05];
C = cell(3,1);

% Calculate the Mahalanobis distance for each data
d = 0.1;
[x1Grid, x2Grid] = meshgrid(-8:d:8, -8:d:8);
aGrid = mahal([x1Grid(:) x2Grid(:)], score(idx,1:2));
aGrid = reshape(aGrid, size(x1Grid,1), size(x2Grid,2));

% Calculate the thresholds to detect 5%, 1% and 0.1% outliers on the the
% first two components
for kk=1:3
    lev = chi2inv((1-th(kk)),2);
    C{kk} = contourc((-8:d:8), (-8:d:8), aGrid, [lev lev]);
end

% Set the color for 5%, 1% and 0.1% outlier regions
col5per = [0.75 0.95 1];
col1per = [0.75 1 0.75];
col01per = [1 1 0.75];
colAnomaly = [1 0.85 0.85];

% Plot the result
figure
plotContourmatrix(C{1}, col01per);
plotContourmatrix(C{2}, col1per);
plotContourmatrix(C{3}, col5per);
hold on;
s1 = gscatter(score(:,1),...
    score(:,2),...
    x);
idx = ReadingTime == 0;
s2 = plot(score(idx,1),...
    score(idx,2),'rp','MarkerSize',10,'MarkerFaceColor','w');
legend([s1; s2],{'urgent','short','medium','long','failure occurrence'},...
    'Color',    [1 1 1],...
    'Location', 'northwest',...
    'FontSize', 12);
ax = gca;
ax.Color = colAnomaly;
ax.Box = 'on';
ax.Layer = 'top';
xlabel('1st Principal Component','FontSize',12);
ylabel('2nd Principal Component','FontSize',12);
title({'Training Data and Calculated Outlier Detection Threshold';...
    'Blue: Normal, Green: 5% outlier, Yellow: 1% outlier, Red: 0.1% outlier'},'FontSize',12)