% Copyright (c) 1998 by Aaron Wallack, Natick, MA USA
% All rights reserved. This material contains unpublished,
% copyrighted work, which includes confidential and proprietary
% information of Aaron Wallack.

function x = maplemapcoeff(varargin)
% MAPLEMAPCOEFF Map Coefficients
% MAPLEMAPCOEFF(Maplevar,var,degree) returns a new matrix where each
% element B where each element B(i,j) characterizes the coefficient
% associated with the monomial var^degree from the Maple variable's
% matrix element A(i,j). 
% MAPLEMAPCOEFF requires that the var is a symbol

% For example, maplemapcoeff({{2*x*x,3*x+7},{4*x+9,3*x*x-4*x-7}},x,2)
% returns the matrix {{2,0},{0,3}} (the coefficients corresponding to x^2)

% MAPLEMAPCOEFF takes a variable number of arguments (varargin) so
% that it can be used 
% in two different ways:
% x = maplemapcoeff(maplematrixvar,var) uses Maple's map function to
%     apply the function coeff(elt,var) to every element of the matrix named
%     by maplematrixvar
% x = maplemapcoeff(maplematrixvar,var,deg) uses Maple's map function to
%     apply the function coeff(elt,var,deg) to every element of the
%     matrix named by maplematrixvar

if nargin == 2
  x = map2num(maple('map','coeff',varargin{1},sym2map(varargin{2})));
end
if nargin == 3
  x = map2num(maple('map','coeff',varargin{1},sym2map(varargin{2}),varargin{3}));
end
