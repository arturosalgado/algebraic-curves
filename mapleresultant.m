% Copyright (c) 1998 by Aaron Wallack, Natick, MA USA
% All rights reserved. This material contains unpublished,
% copyrighted work, which includes confidential and proprietary
% information of Aaron Wallack.

function x = mapleresultant(maplevar)
% MAPLERESULTANT construct a resultant structure 
% MAPLERESULTANT(maplevar) instantiates a MATLAB resultant structure
% from a Maple variable (which corresponds to a Maple constructed resultant)

% MAPLERESULTANT requires that maplevar is of type char

% MAPLERESULTANT serves the interface between Matlab and Maple

% First, the user constructs a resultant using one of the following Maple
% functions, and sets a Maple variable equal to the returned value
% 1. Bezout
% 2. Macaulay
% 3. Sparse

% These Maple routines return an data structure encapsulating the
% resultant matrix. 

% MAPLERESULTANT massages the information into a data structure which
% is more efficient for MATLAB to deal with.

% Massaging the data entails decomposing the symbolic univariate matrix
% polynomial into a more accessible format for MATLAB. In particular,
% MAPLERESULTANT calls the function MAPLEDECOMPMATPOLY to convert the
% symbolic univariate matrix polynomial into a "block row vector",
% which means that the matrix polynomial is decomposed into multiple
% coefficient matrices (corresponding to each monomial), and these
% coefficient matrices are concatenated into a block row vector.

% The reason we do this is that we only want to extract the
% coefficients once (extracting monomial coefficients is a symbolic
% operation, and therefore relatively expensive compared to numerical
% computations). 

% The other important information contained in the MATLAB data
% structure is the "extract" vector because this vector characterizes
% which eigenvector elements we should divide to extract the
% non-hidden variable values

% The MATLAB data structure also copies symbolic information from the
% MAPLE data structure such as the function array, the variable array,
% and the hidden variable used to construct the resultant. The reason
% we copy these values is so that we do not want to rely on the fact
% that the Maple variable forever keeps the value of the resultant.
% We use these symbolic values (function array, variable array,
% identity of the hidden variable) if we use the MATLAB data structure
% to instantiate the function array at a particular vector (to see if
% the vector corresponds to a solution)

global debug_resultant

if (~isa(maplevar,'char'))
  error('mapleresultant requires maplevar be of type char');
end

if (bitand(debug_resultant,1) > 0)
  disp('mapleresultant called with ')
  disp(maple('eval',maplevar));
end % if (debug_resultant == 1)

f1 = map2sym(maple('resultantFnArray',maplevar));
f2 = map2sym(maple('resultantVarArray',maplevar));
f3 = map2sym(maple('resultantHiddenVar',maplevar));
f4 = double(map2sym(maple('resultantHiddenVarMaxDeg',maplevar)));
f5 = sym2double(map2sym(maple('resultantExtract',maplevar)));
f10 = double(map2sym(maple('resultantUResultantUDim',maplevar)));
%f6 = map2sym(maple('resultantNumerator',maplevar));
%f6matpoly = decompmatpoly(f6,f3,f4);
%f6matpoly = maplemapcoeff(strcat(maplevar,'[5]'), f3, f4);
f6matpoly = mapledecompmatpoly(strcat(maplevar,'[5]'), f3, f4, f10);
%f7 = map2sym(maple('resultantNumeratorRow',maplevar));
%f8 = map2sym(maple('resultantDenominator',maplevar));
%f9 = map2sym(maple('resultantDenominatorRow',maplevar));
f6 = 'not cached';
f7 = 'not cached';
f8 = 'not cached';
f9 = 'not cached';
x = struct('numvars',length(f2),'fnarray',f1,'vararray',f2,'hiddenvar',f3,'hiddenvarmaxdeg',f4,'extract',f5,'numer',f6,'numerdecomposematpoly',f6matpoly,'numerrow',f7,'denom',f8,'denomrow',f9,'resultantUDim',f10,'maplevar',maplevar);

if (bitand(debug_resultant,1) > 0)
  disp('mapleresultant returned')
  if (bitand(debug_resultant,32) > 0)
    disp('function array')
    latex(f1)
    disp('variable array')
    latex(f2)
    disp('hidden variable')
    latex(f3)
    disp('hidden variable max deg')
    latex(f4)
    disp('resultant extraction scheme')
    latex(f5)
    disp('resultant numerator')
    disp(maple('resultantLatexNumerator',maplevar))
    disp('resultant numerator companion matrix')
    latex(f6matpoly)
  else 
    disp(x);
  end % if (bitand(debug_resultant,32) > 0)
end % if (debug_resultant == 1)
	