% Copyright (c) 1998 by Aaron Wallack, Natick, MA USA
% All rights reserved. This material contains unpublished,
% copyrighted work, which includes confidential and proprietary
% information of Aaron Wallack.

function y=sparseglt2(fn1,fn2,hiddenvar,var)
% SPARSEGLT2 Sparseglt for 2 functions
% SPARSEGLT2(fn1,fn2,hiddenvar,var) computes the common roots of the two 
% equations fn1 and fn2 which are functions of the two variables
% hidden var and var. The procedure first constructs a Sparse resultant, 
% and then numerically solves the constructed resultant using eigenvalue 
% decomposition. 
% Note that all of the arguments should be passed in quotes so that
% they are not evaluated by the MATLAB processor, but evaluated instead
% by the MAPLE kernel
% For example:
% >> sparseglt2('x*x+6*x+3*y-4','y*y+2*x-7*y+5','x','y');
maple('read(`../maple/shorthand.map`);');
glt=orth(rand(2));
maple('Sparse_GLT_shorthand_2',fn1,fn2,var,hiddenvar,glt);
y=invglt(solveresultant(mapleresultant('Sparse_GLT_shorthand_2_')),glt);
