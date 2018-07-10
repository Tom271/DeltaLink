%%%HAMILTONIAN%%%%
%Calculates the Graph Hamiltonian when only specifying number of links

function H=hamiltonian(G,p)
    m=full(sum(sum(G)))/2; %number of edges on graph
    Beta=log(p/(1-p)); %log odds p
    H=(m*Beta);
end
