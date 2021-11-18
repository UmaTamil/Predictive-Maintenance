function qst=qstat(res)
[m n]=size(res)
for j=1:4
      x=res(:,j);
      L=m-1;
      [h,p,q,c]=lbqtest(x,'Lags',1:L,'Alpha',0.05);
      qst(:,j)=q;
end