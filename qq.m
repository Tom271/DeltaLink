%%%%%%%%%QQ-Plot%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Standard QQ-plot of sample against analytic result%

function QQ=qq(sample,n,p,analyticMean)
    qqplot(sample,poissrnd(analyticMean,1000,1))
    title(['QQ Plot of n=',num2str(n),' p=',num2str(p),' Against Poisson(', num2str(analyticMean),')'])
    saveas(gcf,['QQPlot',num2str(n),num2str(p),'.pdf'])
end