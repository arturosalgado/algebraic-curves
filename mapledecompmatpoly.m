% Copyright (c) 1998 by Aaron Wallack, Natick, MA USA
% All rights reserved. This material contains unpublished,
% copyrighted work, which includes confidential and proprietary
% information of Aaron Wallack.

function ans = mapledecomposematpoly(maplematrixpolynomial,variable,maxdeg,uDim)
% mapledecomposematpoly Decompose matrix polynomial into a 
% "companion row block vector". The term companion row vector refers to a
% concatenation of block matrices corresponding to  each exponent). 

% For example, mapledecompmatpoly({{2*x*x,3*x+7},{4*x+9,3*x*x-4*x-7}},x,2)
% returns the matrix

%    x^0       x^1      x^2
% [ 0    7 | 0    3 | 2    0 ]
% [ 9   -7 | 4   -4 | 0    3 ]

% The reason that we construct a block row vector is that MATLAB is
% much better at dealing with matrices of numbers than almost
% everything else

global debug_resultant

if (bitand(debug_resultant,1) > 0)
  disp('mapledecomposematpoly called with ')
  disp('maplematrixpolynomial')
  if (bitand(debug_resultant,32) > 0)
    latex(maple('eval',maplematrixpolynomial));
  else
    disp(maple('eval',maplematrixpolynomial));
  end % if (bitand(debug_resultant,32) > 0)
  disp('variable')
  disp(variable)
  disp('maxdeg')
  disp(maxdeg)
  disp('maplemapcoeff(maplematrixpolynomial,variable,0)')
  disp(maple('map','coeff',maplematrixpolynomial,sym2map(variable),0))
end % if (debug_resultant == 1)

zeromat = maplemapcoeff(maplematrixpolynomial,variable,0);

if (bitand(debug_resultant,1) > 0)
  disp('zeromat')
  disp(zeromat)
end % if (debug_resultant == 1)

size1 = size(zeromat,1);
size2 = size(zeromat,2);

ans = zeros((maxdeg+1)*size1,size2);

ans(1:size1,1:size2) = zeromat;

if (maxdeg == 1 & uDim > 0 & 1 == 1)
    ans((size1+1):(size1+size1),1:size2) = maplemapcoeff(maplematrixpolynomial,variable,1);
else % if (maxdeg == 1 && uDim > 0)
  for i = 1:maxdeg
    ans((i*size1+1):((i+1)*size1),1:size2) = maplemapcoeff(maplematrixpolynomial,variable,i);
  end
end % if (maxdeg == 1 && uDim > 0)

if (bitand(debug_resultant,1) > 0)
  disp('mapledecomposematpoly returned')
  if (bitand(debug_resultant,32) > 0)
    latex(ans)
  else 
    disp(ans)
  end % if (bitand(debug_resultant,32) > 0)
end % if (debug_resultant == 1)


