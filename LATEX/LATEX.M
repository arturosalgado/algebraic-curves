function y=latex(s)
% Copyright (c) 1998 by Aaron Wallack, Natick, MA USA
% All rights reserved. This material contains unpublished,
% copyrighted work, which includes confidential and proprietary
% information of Aaron Wallack.

% LATEX overload
maple('latexdouble := proc(x) latex(evalf(x)) end;');
maple('Digits:=8;');
% Convert number to its Maple representation.
if ~isstr(s), 
   s = sym2map(sym(s));
end

% Use maplemex directly to print multiple line output.
maplemex(['latexdouble(' s ');'],1)
