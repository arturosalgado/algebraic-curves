% Copyright (c) 1998 by Aaron Wallack, Natick, MA USA
% All rights reserved. This material contains unpublished,
% copyrighted work, which includes confidential and proprietary
% information of Aaron Wallack.

function x = solveresultant(resultant)
% SOLVERESULTANT Solve Resultant
% SOLVERESULTANT(resultant) solves the resultant problem by constructing and solving the
% companion eigenproblem. SOLVERESULTANT returns a matrix of size 
% (num_hypothesized_solutions,num_vars+1) where each row corresponds to a different
% hypothesized solution. The first coordinate in each row is the value of the hidden
% variable, followed by the values of the other variables in the vararray.
% SOLVERESULTANT requires that the argument is a "resultant" structure which was
% constructed by calling then mapleresultant function

global debug_resultant
global only_real
global only_root

if (~isa(resultant,'struct'))
  error('solveresultant requires that resultant is a resultant structure');
end

% construct the companion matrix

if (bitand(debug_resultant,1) > 0)
  disp('solveresultant called with')
  disp(resultant)
end % if (debug_resultant == 1)

[companionmat,process,procvals] = companionmatrix(resultant.numerdecomposematpoly);

if (bitand(debug_resultant,4) > 0)
  if (bitand(debug_resultant,32) > 0)
    disp('companionmat')
    latex(companionmat)
    disp('process')
    disp(process)
    disp('procvals')
    disp(procvals)
  else
    disp('companionmat')
    disp(companionmat)
    disp('process')
    disp(process)
    disp('procvals')
    disp(procvals)
  end % if (bitand(debug_resultant,32) > 0)
end % if (debug_resultant == 1)

% compute the eigenvalues/eigenvectors of the companion matrix

[eigenvecs,eigenvals] = eig(companionmat);

if (bitand(debug_resultant,4) > 0)
  if (bitand(debug_resultant,32) > 0)
    disp('eigenvecs')
    latex(eigenvecs)
    disp('eigenvals')
    latex(eigenvals)
  else
    disp('eigenvecs')
    disp(eigenvecs)
    disp('eigenvals')
    disp(eigenvals)
  end % if (bitand(debug_resultant,32) > 0)
end % if (debug_resultant == 1)

num_hypothesized_solutions = size(resultant.numerdecomposematpoly,1)-size(resultant.numerdecomposematpoly,2);

num_variables = resultant.numvars+1;

if (resultant.resultantUDim > 0)
  num_hypothesized_solutions = resultant.resultantUDim;
  num_variables = resultant.numvars;
end % if (resultant.resultantUDim > 0)

% initialize the result matrix

x=zeros(num_hypothesized_solutions,num_variables);

% convert the "extraction" info from type: sym to type: double (so that the
% elements can be used to index entries in the eigenvector array

extract = resultant.extract;

% Compute each row of the result matrix by running through all of the eigenvalues 
% and associated eigenvectors

for i=1:num_hypothesized_solutions

% Set the value of the hidden variable using the eigenvalue
% Compute the hidden variable according to the eigendecomposition "process"

  if (bitand(debug_resultant,4) > 0)
    disp('eigenval')
    disp(eigenvals(i,i))
  end % if (debug_resultant == 1)

  if (strcmp(process,'identity'))
    x(i,1)=eigenvals(i,i);
    if (bitand(debug_resultant,4) > 0)
      disp('identity map')
    end % if (debug_resultant == 1)
  end
  if (strcmp(process,'inverse'))
    x(i,1)=1/eigenvals(i,i);
    if (bitand(debug_resultant,4) > 0)
      disp('inverse map')
    end % if (debug_resultant == 1)
  end
  if (strcmp(process,'rational_quotient'))
    x(i,1)=(procvals(1)*eigenvals(i,i)+procvals(2))/(procvals(3)*eigenvals(i,i)+procvals(4));
    if (bitand(debug_resultant,4) > 0)
      disp('rational_quotient map')
    end % if (debug_resultant == 1)
  end

  if (bitand(debug_resultant,4) > 0)
    disp('becomes root')
    disp(x(i,1))
  end % if (debug_resultant == 1)


  for j=1:(num_variables-1)

% Set the value of the other variables using the eigenvectors. Note that we've already
% determined (in the offline precomputation step) how to extract each coordinate from
% the associated eigenvector.

% Note that the other variables extracted from the eigenvector are computed in exactly
% the same manner irrespective of the eigendecomposition "process"

%   In the first situation, the variables' value corresponds to an eigenvector coordinate
%   raised to some specified power

    if (resultant.resultantUDim > 0) 
      if (eigenvecs(1,i) != 0)
        x(i,j+1)=mypower(eigenvecs(extract(j+1,1),i),1/extract(j+1,2))/mypower(eigenvecs(extract(j+1,3),i),1/extract(j+1,4));
      else
        x(i,j+1)=0;
      end % if (eigenvecs(1,i) != 0)
    else % if (resultant.resultantUDim > 0) 
      if (extract(j,3) == 0)
        if (eigenvecs(extract(j,1),i) != 0)
          x(i,j+1)=mypower(eigenvecs(extract(j,1),i),1/extract(j,2));
        else
          x(i,j+1)=0;
        end % if (eigenvecs(extract(j,1),i) != 0)
      end % if (extract(j,3) == 0)

%   In the second situation, the variables' value corresponds to the ratio of two
%   eigenvector coordinates raised to specific powers

      if (extract(j,3) != 0)
        if (eigenvecs(extract(j,1),i) != 0 & eigenvecs(extract(j,3),i) != 0)
          x(i,j+1)=mypower(eigenvecs(extract(j,1),i),1/extract(j,2))/mypower(eigenvecs(extract(j,3),i),1/extract(j,4));
        else
          x(i,j+1)=0;
        end % if (eigenvecs(extract(j,1),i) != 0 & eigenvecs(extract(j,3),i) != 0)
      end % if (extract(j,3) != 0)
    end % if (resultant.resultantUDim > 0) 
  end % for j=1:(num_variables-1)

  if (bitand(debug_resultant,4) > 0)
    disp('eigenvecs')
    disp(eigenvecs(1:size(eigenvecs,1),i))
    disp('corresponding to root')
    disp(x(i,1:(num_variables-1)))
  end % if (debug_resultant == 1)

end % for i=1:num_hypothesized_solutions

if (only_real == 1)
  if (bitand(debug_resultant,1) > 0)
    disp('solveresultant called with only_real flag')
    if (bitand(debug_resultant,32) > 0)
      latex(x)
    else
      disp(x)
    end % if (bitand(debug_resultant,32) > 0)
  end % if (debug_resultant == 1)
  x = removecomplex(x);
end % if (only_real == 1)

if (only_root == 1)
  if (bitand(debug_resultant,1) > 0)
    disp('solveresultant called with only_root flag')
    if (bitand(debug_resultant,32) > 0)
      latex(x)
    else
      disp(x)
      disp(resultant)
    end % if (bitand(debug_resultant,32) > 0)
  end % if (debug_resultant == 1)
  x = removenonroot(x,resultant);
end % if (only_real == 1)

if (bitand(debug_resultant,1) > 0)
  disp('solveresultant returned')
  if (bitand(debug_resultant,32) > 0)
    latex(x)
  else
    disp(x)
  end % if (bitand(debug_resultant,32) > 0)
end % if (debug_resultant == 1)
