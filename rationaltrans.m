% Copyright (c) 1998 by Aaron Wallack, Natick, MA USA
% All rights reserved. This material contains unpublished,
% copyrighted work, which includes confidential and proprietary
% information of Aaron Wallack.

function x = rationaltrans(alpha,beta,gamma,delta,maxtpower,tpower,spower)
% RATIONALTRANS Rational Transformation Coefficients
% returns The s^spower coefficient of t^tpower assuming t = (as+b)/(cs+d)
%  expression := ((alpha*s+beta)^tpower)*((gamma*s+delta)^(maxtpower-tpower));
%  RETURN(coeff(expand(expression),s,spower));

x=double(map2sym(maple('rationalTransform',alpha,beta,gamma,delta,maxtpower,tpower,spower)));
