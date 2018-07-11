%%Naive Parallelisation of delta.m%%%
function samp=parlongrun(nodeCount,linkDensity,mcmcSample)
sample=zeros(4,(iter)/4);
%Turn off large n warning%
%parfevalOnAll(gcp(), @warning, 0, 'off', 'MATLAB:nchoosek:LargeCoefficient')
    parfor i =1:4
        tic
        sample(i,:)=delta(nodeCount,linkDensity,(mcmcSample)/4,1);
        toc
    end
samp=[sample(1,:),sample(2,:),sample(3,:),sample(4,:)];
end
