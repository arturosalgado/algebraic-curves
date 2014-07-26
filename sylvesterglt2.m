% Copyright (c) 1998 by Aaron Wallack, Natick, MA USA
% All rights reserved. This material contains unpublished,
% copyrighted work, which includes confidential and proprietary
% information of Aaron Wallack.

function y=sylvesterglt2(fn1,fn2,var,hiddenvar)
% SYLVESTERGLT2 Sylvester for 2 functions
% SYLVESTERGLT2(fn1,fn2,hiddenvar,var) computes the common roots of the two 
% equations fn1 and fn2 which are functions of the two variables
% hidden var and var. The procedure first constructs a Sylvester resultant, 
% and then numerically solves the constructed resultant using eigenvalue 
% decomposition. 
% Note that all of the arguments should be passed in quotes so that
% they are not evaluated by the MATLAB processor, but evaluated instead
% by the MAPLE kernel
% For example:
% >> sylvesterglt2('x*x+6*x+3*y-4','y*y+2*x-7*y+5','x','y');
maple('read(`../maple/shorthand.map`);');
glt=orth(rand(2));
maple('Sylvester_GLT_shorthand_2',fn1,fn2,hiddenvar,var,glt);
y=invglt(solveresultant(mapleresultant('Sylvester_GLT_shorthand_2_')),glt);
