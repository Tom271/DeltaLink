function ks=test(fn)
    tim=fn(100,0.01,10^6);
    ksstat(tim,49.5)
    qqplot(tim,poissrnd(49.5,1000,1))
end
