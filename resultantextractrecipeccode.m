% Copyright (c) 1998 by Aaron Wallack, Natick, MA USA
% All rights reserved. This material contains unpublished,
% copyrighted work, which includes confidential and proprietary
% information of Aaron Wallack.

function x = resultantextractrecipeccode(maplevar)
% RESULTANTEXTRACTRECIPECCODE Resultant C Code
% RESULTANTEXTRACTRECIPECCODE(maplevar) generates C code for a resultant

varArray = map2sym(maple('resultantVarArray',maplevar));
numVars = length(varArray);
extractArray = sym2double(map2sym(maple('resultantExtract',maplevar)));
for i = 1:numVars
  disp(varArray(i));
  if (extractArray(i,2) == 1)
    textpart1 = sprintf('eigenvector[%d]',extractArray(i,1)-1);
  else
    textpart1 = sprintf('pow(eigenvector[%d],%f)',extractArray(i,1),1./extractArray(i,2));
  end
  if (extractArray(i,3) != 0)
    if (extractArray(i,4) == 1)
      textpart2 = sprintf('eigenvector[%d]',extractArray(i,3)-1);
    else
      textpart2 = sprintf('pow(eigenvector[%d],%f)',extractArray(i,3),1./extractArray(i,4));
    end
    textline=sprintf('=%s/%s;',textpart1,textpart2);
  else
    textline=sprintf('=%s;',textpart1);
  end
  disp(textline);
end
