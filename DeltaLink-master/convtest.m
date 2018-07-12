%%TEST%%
%Produce QQ Plots, KS stat, 
function [ks,tElapsed]=convtest(fn)
    nodes=[50,100,250,500,750,1000];
    linkDensity=[0.1,0.05,0.01,0.005];
    ks=zeros(length(linkDensity),length(nodes));
    mcmcSample=10^6;
    z=1;
    for n=1:length(nodes)
        for m=1:length(linkDensity)
            tStart=tic;
            sample=zeros(4,(mcmcSample)/4);
            %Turn off large n warning%
            parfevalOnAll(gcp(), @warning, 0, 'off', 'MATLAB:nchoosek:LargeCoefficient');
            parfor i =1:4
                sample(i,:)=fn(nodes(n),linkDensity(m),(mcmcSample)/4,1);
            end
            sample=[sample(1,:),sample(2,:),sample(3,:),sample(4,:)];

            analyticMean=nchoosek(nodes(n),2)*linkDensity(m);
            %%QQ Plot %%
            qqplot(sample,poissrnd(analyticMean,1000,1))
            title(['QQ Plot of n=',num2str(nodes(n)),' p=',num2str(linkDensity(m)),' Against Poisson(', num2str(analyticMean),')'])
            saveas(gcf,[pwd '\Figures\',func2str(fn),'QQPlot',num2str(nodes(n)),num2str(linkDensity(m)),'.jpg'])
            clf
            %%Histogram%%
            h=histogram(sample);
            h.Normalization='pdf';
            hold on; 
            plot(h.BinLimits(1):h.BinLimits(2),poisspdf(h.BinLimits(1):h.BinLimits(2),analyticMean));
            title(['Histogram of n=',num2str(nodes(n)),' p=',num2str(linkDensity(m)),' Against Poisson(', num2str(analyticMean),')'])
            saveas(gcf,[pwd '\Figures\',func2str(fn),'Hist',num2str(nodes(n)),num2str(linkDensity(m)),'.jpg'])
            clf
            %%Calculate K-S Statistic%%
            [f,x]=ecdf(sample);
            poiss=poisscdf(x,analyticMean);
            ks(m,n)=max(f-poiss);
            tElapsed(z) = toc(tStart);
            disp(tElapsed(z))
            z=z+1;
        end
    end
end