% Copyright (c) 1998 by Aaron Wallack, Natick, MA USA
% All rights reserved. This material contains unpublished,
% copyrighted work, which includes confidential and proprietary
% information of Aaron Wallack.
function y=macaulay2(fn1,fn2,hiddenvar,var1,var2)
% MACAULAY2 Macaulay for 2 functions
% MACAULAY2(fn1,fn2,hiddenvar,var1,var2) computes the common roots
% of the two homogeneous equations fn1 and fn2 which are functions of the three
% variables hidden var, var1, and var2. The procedure first
% constructs a Macaulay resultant,  and then numerically solves the constructed
% resultant using eigenvalue decomposition. 
% Note that all of the arguments should be passed in quotes so that
% they are not evaluated by the MATLAB processor, but evaluated instead
% by the MAPLE kernel
% For example:
%macaulay2('(y+6)*x1+(y+2)*x2','(y-13)*x1*x1+(y+5)*x1*x2+y*x2*x2','y','x1','x2');
maple('read(`../maple/shorthand.map`);');
maple('Macaulay_shorthand_2',fn1,fn2,var1,var2,hiddenvar);
y=solveresultant(mapleresultant('Macaulay_shorthand_2_'));
