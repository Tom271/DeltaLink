%%Naive Parallelisation of delta.m%%%

iter=10^7;
nodes=1000;
linkDensity=0.01;

sample=zeros(4,(iter)/4);
%Turn off large n warning%
%parfevalOnAll(gcp(), @warning, 0, 'off', 'MATLAB:nchoosek:LargeCoefficient')

parfor i =1:4
    tic
    sample(i,:)=delta(nodes,linkDensity,(iter)/4,1);
    toc
end
samp=[sample(1,:),sample(2,:),sample(3,:),sample(4,:)];

%%Plotting Histogram w/ overlaid Poisson
h=histogram(samp);
h.Normalization='probability';
hold on; 
plot(h.BinLimits(1):h.BinLimits(2),poisspdf(...
    h.BinLimits(1):h.BinLimits(2),nodes*(nodes-1)*linkDensity/2));
