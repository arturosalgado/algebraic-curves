function p = functionpq(f)

% computes p(x,t)

syms x

m = length (f)
p = size(m);
p = sym(p);

    for i=1:m
    
      p(i)=t(i)*x
        
    end
    
