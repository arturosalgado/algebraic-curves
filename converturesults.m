% Copyright (c) 1998 by Aaron Wallack, Natick, MA USA
% All rights reserved. This material contains unpublished,
% copyrighted work, which includes confidential and proprietary
% information of Aaron Wallack.

function ans=converturesults(resultmatrix)
% CONVERTURESULTS Convert results from u resultant to ordinary results
% CONVERTURESULTS computes the (x1,x2,...,xn) roots from the results
% generated by a U resultant (whose variable sets are x2,x0,x1,x2,..,xn).
% CONVERTURESULTS takes each row of the resultmatrix, strips off the first
% column element, calls the second element in the row the divisor, 
% and then divides the remaining elements in the row by the second element

numsolns = size(resultmatrix,1);
numvars = size(resultmatrix,2);

ans = resultmatrix(1:numsolns,2:numvars);