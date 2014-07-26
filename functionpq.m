function functionpq(f)

% computes p(x,t)

syms x t d result 

m = length (f);
p = size(m);
p = sym(p);

    for i=1:m
    
      p(i)=(d*x-f(i))*t^(i-1);
      % t to the ith power
        
    end

    result=p(1);
    
    for i=2:m
        
        result = result+p(i);
        
    end
    
    pretty(result)