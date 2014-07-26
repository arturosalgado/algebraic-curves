% Copyright (c) 1998 by Aaron Wallack, Natick, MA USA
% All rights reserved. This material contains unpublished,
% copyrighted work, which includes confidential and proprietary
% information of Aaron Wallack.

function x = resultantccode(maplevar)
% RESULTANTCCODE Resultant C Code
% RESULTANTCCODE(maplevar) generates C code for a resultant

resultantsize = double(map2sym(maple('resultantNumeratorSize',maplevar)));
maxdeg = double(map2sym(maple('resultantHiddenVarMaxDeg',maplevar)));
hiddenVar = maple('resultantHiddenVar',maplevar);
for i=1:resultantsize 
  for j=1:resultantsize
    element = map2sym(maple('resultantNumeratorIJ',maplevar,i,j));
    for k = 0:maxdeg
      maplecoeff = maple('coeff',element,hiddenVar,k);
      coeff = map2sym(maplecoeff);
      if (coeff != 0)
	maple('C',maplecoeff);
        textline = sprintf('\nresultant[%d][%d][%d]=t0;\n',k,i-1,j-1);
        disp(textline);
      end;
    end;
  end;
end;
