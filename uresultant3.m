% Copyright (c) 1998 by Aaron Wallack, Natick, MA USA
% All rights reserved. This material contains unpublished,
% copyrighted work, which includes confidential and proprietary
% information of Aaron Wallack.

function y=uresultant3(fn1,fn2,fn3,var1,var2,hiddenvar,uvar)
% URESULTANT3 Uresultant for 3 functions
% URESULTANT3(fn1,fn2,fn3,hiddenvar,var1,var2) computes the common roots
% of the three equations fn1, fn2 and fn3 which are functions of the three
% variables hidden var, var1, and var2. The procedure first
% constructs a Uresultant resultant,  and then numerically solves the constructed
% resultant using eigenvalue decomposition. 
% Note that all of the arguments should be passed in quotes so that
% they are not evaluated by the MATLAB processor, but evaluated instead
% by the MAPLE kernel
% For example:
% uresultant3('x*x+6*x+3*y+6*z-4','y*y+2*x-7*y+5+2*z','x*x+y*y+z*z-1','x','y','z','u');
maple('read(`../maple/shorthand.map`);');
maple('UResultant_shorthand_3',fn1,fn2,fn3,var1,var2,hiddenvar,uvar);
y=converturesults(solveresultant(mapleresultant('UResultant_shorthand_3_')));