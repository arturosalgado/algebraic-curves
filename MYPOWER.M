% Copyright (c) 1998 by Aaron Wallack, Natick, MA USA
% All rights reserved. This material contains unpublished,
% copyrighted work, which includes confidential and proprietary
% information of Aaron Wallack.

function x = mypower(val,expt)
% MYPOWER Improved exponentiation function
% MYPOWER(val,expt) performs the same role as power(val,expt), i.e., it returns an answer
% such that answer^(1/expt)==val. The only difference between MYPOWER and POWER is that
% MYPOWER always returns real numbers a negative number raised to an odd root, whereas
% power does not.
% For example, power(-8,1/3) will return (1+sqrt(3)i), which is a perfectly valid cube
% root of 8. MYPOWER(-8,1/3), on the other hand, will return -2.
% MYPOWER uses a simple heuristic: if val is negative, and expt is an odd root, then
% compute the power corresponding to -val, and return its additive inverse, i.e., 
% -(-val^expt).

% Oddness characterizes whether expt is an odd root (such as 1/3 (cube root) 
% or 1/5 (quintic root)

oddness = mod(1/expt,2);
if (val < 0 & oddness > 0.9 & oddness < 1.1)
  x = - power(-val,expt);
else
  x = power(val,expt);
end;