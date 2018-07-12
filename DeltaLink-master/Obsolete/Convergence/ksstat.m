%%% KS-Statistic Convergence Test%%
function ks=ksstat(sample,analyticMean)
    [f,x]=ecdf(sample);
    poiss=poisscdf(x,analyticMean);
    ks=max(f-poiss);
end
