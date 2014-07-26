% Copyright (c) 1998 by Aaron Wallack, Natick, MA USA
% All rights reserved. This material contains unpublished,
% copyrighted work, which includes confidential and proprietary
% information of Aaron Wallack.

function x = evalresatx(resultant,row)
% EVALRESATX Evaluate Resultant At X
% resultant refers to a Matlab resultant data structure
% row is a row vector characterizing a configuration

global debug_resultant

if (~isa(resultant,'struct'))
  error('evalresatx requires that resultant is a resultant structure');
end

if (bitand(debug_resultant,1) > 0)
  disp('evalresatx called with')
  disp(resultant)
  disp(row)
end % if (debug_resultant == 1)

numvars = resultant.numvars+1;

temp = maple('vector',numvars,0);

symtemp = map2sym(temp);

if (resultant.resultantUDim > 0)
  symtemp(3:numvars)=row(2:numvars-1);
  symtemp(1)=row(1);
  symtemp(2)=1
else
  symtemp(1:numvars)=row(1:numvars);
end

mapsymtemp = sym2map(symtemp);

%x = map2sym(maple('resultantEvaluateFunctions',sym2map(resultant.fnarray),sym2map(resultant.hiddenvar),sym2map(resultant.vararray),mapsymtemp));
x = map2sym(maple('resultantEvaluateStruct',resultant.maplevar,mapsymtemp));
