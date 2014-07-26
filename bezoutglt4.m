% Copyright (c) 1998 by Aaron Wallack, Natick, MA USA
% All rights reserved. This material contains unpublished,
% copyrighted work, which includes confidential and proprietary
% information of Aaron Wallack.

function y=bezoutglt4(fn1,fn2,fn3,fn4,hiddenvar,var1,var2,var3)
% BEZOUTGLT4 Bezoutglt for 4 functions
% BEZOUTGLT4(fn1,fn2,fn3,fn4,hiddenvar,var1,var2,var3) computes the common 
% roots of the four equations fn1, fn2, fn3 and fn4 which are functions of 
% the four variables hidden var, var1, var2 and var3. The procedure first
% constructs a Bezout resultant,  and then numerically solves the constructed
% resultant using eigenvalue decomposition. 
% Note that all of the arguments should be passed in quotes so that
% they are not evaluated by the MATLAB processor, but evaluated instead
% by the MAPLE kernel
% For example:
% bezoutglt4('5*x*x+6*x+3*y+6*z+3+2*w','4*y*y+4*x+3*z+w*2+4','x+3*z-9+w*7-11*z*z','x+3*y+2*z-3*w*w+13','x','y','z','w');
maple('read(`../maple/shorthand.map`);');
glt=orth(rand(4));
maple('Bezout_GLT_shorthand_4',fn1,fn2,fn3,fn4,var1,var2,var3,hiddenvar,glt);
y=invglt(solveresultant(mapleresultant('Bezout_GLT_shorthand_4_')),glt);
