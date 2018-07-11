%%% KS-Statistic Convergence Test%%
function [ks,tim]=ksstat(power)
    iter=10^6;
    ks=zeros(1,power);
    nodes=floor(logspace(1,power,10));
    tim=zeros(10,iter);
    parfor i=1:10
        tic
        tim(i,:)=reportdelta(nodes(i),0.01,iter,1);
        toc
        [f,x]=ecdf(tim(i,:));
        poiss=poisscdf(x,0.01*nodes(i)*(nodes(i)-1)/2);
        ks(i)=max(f-poiss);
    end
end
