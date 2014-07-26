function  func(f)

syms coeff1 coeff2 coeff3 coeff4
syms x a

Y=1; N=0; y =1 ; n=0;
m = length(f);

coeff1   = sym(f(1));
coeff2   = sym(f(2)); 
coeff3   = sym(f(3));






%%coeff1   = coeff1*x^2;
%%coeff2   = coeff2*x;

coeff1;

coeff2;


r = coeff1+coeff2+coeff3;


m = [coeff1, coeff2; coeff2,coeff1]   



det(m)

pretty(r);

        %%    p = input('Plot ?,Press Y/N  ');
        %%  if p == Y    
        %%    ezplot(r);
        %%else
        %%  %nothing
        %%  end
    
    
    