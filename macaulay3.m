% Copyright (c) 1998 by Aaron Wallack, Natick, MA USA
% All rights reserved. This material contains unpublished,
% copyrighted work, which includes confidential and proprietary
% information of Aaron Wallack.

function y=macaulay3(fn1,fn2,fn3,hiddenvar,var1,var2,var3)
% MACAULAY3 Macaulay for 3 functions
% MACAULAY3(fn1,fn2,fn3,hiddenvar,var1,var2,var3) computes the common roots
% of the three homogeneous equations fn1, fn2 and fn3 which are functions of
% the four variables hidden var, var1, var2, and var3. The procedure first
% constructs a Macaulay resultant,  and then numerically solves the constructed
% resultant using eigenvalue decomposition. 
% Note that all of the arguments should be passed in quotes so that
% they are not evaluated by the MATLAB processor, but evaluated instead
% by the MAPLE kernel
% For example:
% macaulay3('(y+6)*x1+(y+2)*x2+(y-4)*x3','(y-13)*x1*x1+(y+5)*x1*x2+y*x2*x2+(y-5)*x2*x3+(y-7)*x3*x3','(y+1)*x1*x1+(y-1)*x1*x2+(y-2)*x2*x3','y','x1','x2','x3');
maple('read(`../maple/shorthand.map`);');
maple('Macaulay_shorthand_3',fn1,fn2,fn3,var1,var2,var3,hiddenvar);
y=solveresultant(mapleresultant('Macaulay_shorthand_3_'));