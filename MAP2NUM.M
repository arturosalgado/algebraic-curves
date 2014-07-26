function symout = map2num(mapin)
% Copyright (c) 1998 by Aaron Wallack, Natick, MA USA
% All rights reserved. This material contains unpublished,
% copyrighted work, which includes confidential and proprietary
% information of Aaron Wallack.

%MAP2NUM Convert Maple string to numbers using the function str2num instead of sym. 
%   If S has the form MATRIX([[...],[...]]) or 
%   VECTOR([...]), R is a double matrix. Otherwise, MAP2NUM assumes 
%   S is a scalar Maple result and attempts to directly convert it to a number.
%
%   See also SYM2MAP.
%   See also MAP2SYM

%   Copyright (c) 1993-96 by The MathWorks, Inc.
%   $Revision: 1.5 $  $Date: 1996/06/27 15:55:56 $

% Deblank input
mapin(find(mapin==' ')) = '';
% Create indices that delimit rows
s = find(mapin == '[') + 1;
e = find(mapin == ']') - 1;

% Check for case of scalar MAPIN 
if (length(mapin)<5) | isempty(s)
   symout = str2num(mapin);
   return;
end;

if strcmp(mapin(1:5),'array') | strcmp(mapin(1:6),'MATRIX')
   s(1) = [];
   e(end) = [];
end
nrow = length(s);

for row=1:nrow
   % string with current row
   crow = mapin(s(row):e(row));

   % eliminate commas within ()'s
   lp = find(crow == '(');
   rp = find(crow == ')');
   for i=1:length(lp)
      crow(lp(i):rp(i)) = ' ';
   end

   % count commas to determine number of elements
   commas = find(crow == ',');
   if row == 1
      ncol = length(commas) + 1;
   elseif length(commas)+1 ~= ncol
      error('Maple output matrix conversion problem');
   end

   % start and end of column elements
   sr = [1 commas+1];
   er = [commas-1 length(crow)];

   crow = mapin(s(row):e(row));
   for col=1:ncol
      symout(row,col) = str2num(crow(sr(col):er(col)));
   end
end
