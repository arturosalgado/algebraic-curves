% script for sylvester 

% symbolic variables
syms a b c d e f 

f1 = [a b c]
f2 = [d e f]

pause

%call to sylvester
sylvester(f1,f2)
