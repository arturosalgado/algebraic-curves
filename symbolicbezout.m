% symbolicbezout


% define the coefficients for f1

syms a0 a1 a2 a3 
syms b0 b1 b2 b3

f1 = [a0 a1 a2 a3]
f2 = [b0 b1 b2 b3]
disp('bezout(f1,f2)')
pause
bezout(f1,f2);