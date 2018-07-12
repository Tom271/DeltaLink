%%%%%Testing Convergence of Chains%%%%%
% Using KS statistic, QQ plot, maybe G-R
function ks=convtest(sample,nodes,linkDensity)
    analyticMean=nchoosek(nodes,2)*linkDensity;
    qq(sample,nodes,linkDensity,analyticMean)
    ks=ksstat(sample,analyticMean);
    