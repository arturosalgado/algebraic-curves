% Copyright (c) 1998 by Aaron Wallack, Natick, MA USA
% All rights reserved. This material contains unpublished,
% copyrighted work, which includes confidential and proprietary
% information of Aaron Wallack.

function y=arraycontains(anarray,arow)
% ARRAYCONTAINS check whether an array contains a row
% Used for testing resultant code

rowsize = size(arow,2);
matsize = size(anarray,1);
if (rowsize != size(anarray,2))
  disp('arraycontains should only be called with arrays and rows of the same length')
  y=0
  return
end % if (rowsize != size(matsize,1))

for i = 1:matsize
  matches=1;
  for j = 1:rowsize
    diff = real(anarray(i,j))-real(arow(j));
    nomatch = abs(diff)>1e-6;
    if (nomatch)
      matches=0;
    end % if (abs(real(anarray(i,j))-real(arow(j)))>1e-6)
  end % for j = 1:rowsize
  if (matches == 1)
    y=1;
    return;
  end % if (matches == 1)
end % for i = 1:matsize

y=0;

