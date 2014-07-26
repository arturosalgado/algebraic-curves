function y=invglt(resultMatrix,glt)
% Copyright (c) 1998 by Aaron Wallack, Natick, MA USA
% All rights reserved. This material contains unpublished,
% copyrighted work, which includes confidential and proprietary
% information of Aaron Wallack.

% INVGLT Invert the configuration according to the generic linear transform
% INVGLT(resultMatrix,gt) inverts the results according to the generic linear
% transform
% This function in conjunction with ...glt functions: dixonglt2,
% uresultantglt2, ...
% These glt functions take an original system and genericitize it by
% performing a linear change of variables X' = [ M ] X (f'(X') = 0)
% Then, they call the numerical solver to solve the f' system for 
% the generic variables X'; then, they retransform the X' solutions
% by the generic linear transform
% Note: the generic linear transform is characterized by the variable glt
y=transpose(inv(glt)*transpose(resultMatrix));

