function cn = cn(mu, gamma_i, pointNumber, n)
% cn coefficients 
% In particular, the convention for case 3 is equivalent to the one of
% Richardson (1980), which may differ from later article (Jorba & Masdemont
% 1999, etc). Cases 1 and 2 are always good.
switch(pointNumber)
    case 1
        cn =  gamma_i^(-3) * ( mu + (-1)^n*(1-mu)*gamma_i^(n+1)/(1-gamma_i)^(n+1) );
    case 2
        cn =  gamma_i^(-3) * ( (-1)^n*mu + (-1)^n*(1-mu)*gamma_i^(n+1)/(1+gamma_i)^(n+1) );
    case 3
        cn =  gamma_i^(-3) * ( 1 - mu + mu*gamma_i^(n+1)/(1+gamma_i)^(n+1) );
    otherwise
        error('Unknown libration point number');
end

end

