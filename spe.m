
function sp=spe(x,coeff1,score1)

pm=mean(x);
pstd=std(x);
mc=x-pm;
mcuv=mc./pstd;
bvar=mcuv.*mcuv;
xhat=(coeff1*score1')';
sxhat=xhat.*xhat;
err=mcuv-xhat;
errs=err.*err;
sp=(sqrt(sum(errs,2)))';
end