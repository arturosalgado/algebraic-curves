% Copyright (c) 1998 by Aaron Wallack, Natick, MA USA
% All rights reserved. This material contains unpublished,
% copyrighted work, which includes confidential and proprietary
% information of Aaron Wallack.

function [compmat,process,procvals] = companionmatrix(decomposematpoly)
% COMPANIONMATRIX Companion matrix
% COMPANIONMATRIX(decomposematpoly) constructs and returns the companion
% matrix corresponding to the given decomposed symbolic matrix polynomial 
% (decomposed matrixpoly). 
% COMPANIONMATRIX tries (in succession) the "vanilla" companion construction, 
% an "inverse" companion construction, and a "generic rational quotient" companion
% construction. The reason that we may need to perform either the "inverse" construction
% or the "general rational quotient" construction is that if one of the solutions to
% the matrix polynomial is t==Infinity, then the leading matrix will be numerically
% ill-conditioned (and therefore, we should not construct a companion matrix by
% multiplying (M^d)^{-1} by the other matrix monomials. That is why the COMPANIONMATRIX
% function tries two other constructions: "inverse" and "general rational quotient".
% In the "inverse" construction, we make a symbolic substitution t=1/s, and construct
% a companion matrix system in terms of s (rather than t). This construction will succeed as
% long as t=0 is not a solution to the matrix polynomial. Lastly, we try a "general
% rational quotient" transformation which uses the symbolic substitution t=(as+b)/(cs+d),
% and then constructs a companion matrix in terms of s.
% For these reasons, COMPANIONMATRIX returns three results: 
%	compmat: the companion matrix
%	process: oneof ('identity','inverse','rational_quotient') characterizing
%		 which transformation was used to generate this companion matrix
%	procvals: the (a,b,c,d) values used to generate this companion matrix if
%		  process=='rational_quotient'
% COMPANIONMATRIX requires that decomposematpoly is a decomposed matrix polynomial
%				ndims(decomposematpoly) == 2

global debug_resultant

if (ndims(decomposematpoly) != 2)
  error('companionmatrix requires ndims(decomposematpoly) == 2');
end

if (bitand(debug_resultant,1) > 0)
  disp('companionmatrix called with')
  if (bitand(debug_resultant,32) > 0)
    latex(decomposematpoly)
  else
    disp(decomposematpoly)
  end % if (bitand(debug_resultant,32) > 0)
end % if (debug_resultant == 1)

matsize = size(decomposematpoly,2);

maxdeg = (size(decomposematpoly,1)/matsize)-1;

if (maxdeg == 1 & 1==1)
  for i = 1:matsize
    if (decomposematpoly(matsize+i,i) == 0)
      break;
    end % if (decomposematpoly(matsize+i,i) == 0)
  end % for i = 1:matsize
  
  uDim = i-1;

  uArray = decomposematpoly(matsize+1:matsize+uDim,1:uDim);

  uArrayIsIdentityMatrix = 1;

  for i = 1:uDim
    for j = 1:uDim
      if (uArray(i,j) != 0 & i != j)
        uArrayIsIdentityMatrix = 0;
      end % if (uArray(i,j) != 0 & i != j)
    end % for j = 1:uDim
  end % for i = 1:uDim

  if (uArrayIsIdentityMatrix == 1)
    tArray = decomposematpoly(1:uDim,1:uDim);
    pArray = decomposematpoly((uDim+1):matsize,(uDim+1):matsize);
    qArray = decomposematpoly((uDim+1):matsize,1:uDim);
    rArray = decomposematpoly(1:uDim,(uDim+1):matsize);
    mArray = tArray - rArray * inv(pArray) * qArray;
    compmat = mArray;
    process = 'identity';
    procvals = [ 0 0 0 0 ];
    return
  end % if (uArrayIsIdentityMatrix == 1)
end % if (maxdeg == 1)

leadingmatrix = decomposematpoly((maxdeg*matsize+1):(maxdeg+1)*matsize,1:matsize);

% Compute the size of compmat (the big matrix)

bigsize = matsize * maxdeg;

if (bitand(debug_resultant,4) > 0)
  disp('matsize')
  disp(matsize)
  disp('maxdeg')
  disp(maxdeg)
  disp('leading matrix')
  if (bitand(debug_resultant,32) > 0)
    latex(leadingmatrix)
  else
    disp(leadingmatrix)
  end % if (bitand(debug_resultant,32) > 0)
  disp('bigsize = matsize * maxdeg')
  disp(bigsize)
end % if (debug_resultant == 1)

% Initialize compmat, the big result matrix 
compmat = zeros(bigsize,bigsize);

% Fill in 1's into compmat along the blocks above the diagonal

compmat = diag(ones(1,bigsize-matsize),matsize);

process = 'unknown';
procvals = [ 0 0 0 0 ];

if (bitand(debug_resultant,4) > 0)
  disp('cond(leading matrix)')
  disp(cond(leadingmatrix))
end % if (debug_resultant == 1)

if (cond(leadingmatrix) < 1e6 & strcmp(process,'unknown') & 1 == 1)

  if (bitand(debug_resultant,12) > 0)
    disp('cond(leading matrix) < 1e6 & strcmp(process,unknown) & 1 == 1')
    disp('-> identity process')
  end % if (debug_resultant == 1)

% The first (simplest) case is when the leading matrix is invertible (i.e., not
% rank deficient). In this case, we can perform a vanilla companion matrix expansion.

  process = 'identity';

  % Compute the leading matrix and its inverse

  inverseleadingmatrix = inv(leadingmatrix);

  if (bitand(debug_resultant,12) > 0)
    if (bitand(debug_resultant,32) > 0)
      disp('inverse leading matrix')
      latex(inverseleadingmatrix)
    else
      disp('inverse leading matrix')
      disp(inverseleadingmatrix)
    end % if (bitand(debug_resultant,32) > 0)
  end % if (debug_resultant == 1)

  for i = 0:maxdeg-1

  % Compute the coefficient matrix for variable^i

    followingmatrix = decomposematpoly((i*matsize+1):((i+1)*matsize),1:matsize);

  % Multiply -inverseleadingmatrix by the following matrix

    matrixmult = -inverseleadingmatrix * followingmatrix;

    if (bitand(debug_resultant,12) > 0)
      if (bitand(debug_resultant,32) > 0)
        disp('i')
        disp(i)
        disp('following matrix')
        latex(followingmatrix)
        disp('matrix mult')
        latex(matrixmult)
      else
        disp('i')
        disp(i)
        disp('following matrix')
        disp(followingmatrix)
        disp('matrix mult')
        disp(matrixmult)
      end % if (bitand(debug_resultant,32) > 0)
    end % if (debug_resultant == 1)

  % Copy the submatrix (matrixmult) into the proper cells in compmat

    compmat((bigsize-matsize+1):bigsize,(i*matsize+1):((i+1)*matsize))=matrixmult;

  end % for i = 0:maxdeg-1

  if (cond(compmat) > 1e12)
    if (bitand(debug_resultant,12) > 0)
       disp('identity transformation didnt succeed')
       disp('companion matrix condition number too high')
       disp(cond(compmat))
    end % if (bitand(debug_resultant,12) > 0)
    process = 'unknown';
  end % if (cond(compmat) > 1e12)

end % if (strcmp(process,'identity'))

% if the 'identity' transformation didn't succeed, try the inverse transformation

if (strcmp(process,'unknown') & 1 == 1)

  if (bitand(debug_resultant,12) > 0)
    disp('identity transformation didnt succeed')
  end % if (debug_resultant == 1)
 
  trailingmatrix = decomposematpoly(1:matsize,1:matsize);

  if (bitand(debug_resultant,12) > 0)
    if (bitand(debug_resultant,32) > 0)
      disp('trailing matrix')
      latex(trailingmatrix)
      disp('cond(trailingmatrix)')
      disp(cond(trailingmatrix))
    else
      disp('trailing matrix')
      disp(trailingmatrix)
      disp('cond(trailingmatrix)')
      disp(cond(trailingmatrix))
    end % if (bitand(debug_resultant,32) > 0)
  end % if (debug_resultant == 1)

% compare the condition number for the trailing number to some threshold to determine
% whether the inverse transformation is acceptable

  if (cond(trailingmatrix) < 1e6)
  
    if (bitand(debug_resultant,12) > 0)
      disp('cond(trailingmatrix) < 1e6')
      disp('-> inverse process')
    end % if (debug_resultant == 1)

    process = 'inverse';

    % Compute the inverse of the trailing matrix (s^maxdeg or variable^0)

    inversetrailingmatrix = inv(trailingmatrix);

    if (bitand(debug_resultant,12) > 0)
      if (bitand(debug_resultant,32) > 0)
        disp('inversetrailing matrix')
        latex(inversetrailingmatrix)
      else
        disp('inversetrailing matrix')
        disp(inversetrailingmatrix)
      end % if (bitand(debug_resultant,32) > 0)
    end % if (debug_resultant == 1)

    for i = 0:maxdeg-1

    % Compute the coefficient matrix for s^i (or, correspondingly, variable^(deg-i))
      j = maxdeg-i;

      followingmatrix = decomposematpoly((j*matsize+1):((j+1)*matsize),1:matsize);

    % Multiply -inverseleadingmatrix by the following matrix

      matrixmult = -inversetrailingmatrix * followingmatrix;

    % Copy the submatrix (matrixmult) into the proper cells in compmat

      compmat((bigsize-matsize+1):bigsize,(i*matsize+1):((i+1)*matsize))=matrixmult;

      if (bitand(debug_resultant,12) > 0)
        if (bitand(debug_resultant,32) > 0)
          disp('i')
          disp(i)
          disp('following matrix')
          latex(followingmatrix)
          disp('matrix mult')
          latex(matrixmult)
        else
          disp('i')
          disp(i)
          disp('following matrix')
          disp(followingmatrix)
          disp('matrix mult')
          disp(matrixmult)
        end % if (bitand(debug_resultant,32) > 0)
      end % if (debug_resultant == 1)

    end % for i = 1:maxdeg

  end % if cond(trailingmatrix)  < 1e6)

  if (cond(compmat) > 1e12)
    if (bitand(debug_resultant,12) > 0)
       disp('inverse transformation didnt succeed')
       disp('companion matrix condition number too high')
       disp(cond(compmat))
    end % if (bitand(debug_resultant,12) > 0)
    process = 'unknown';
  end % if (cond(compmat) > 1e12)

end % if (strcmp(process,'unknown'))

% if the 'identity' transformation didn't succeed and the 'inverse' transformation
% didn't succeed, then try the 'rational_quotient' transformation

if (strcmp(process,'unknown'))

  if (bitand(debug_resultant,12) > 0)
    disp('inverse transformation didnt succeed')
    disp('-> try random (as+b)/(cs+d) transformations')
  end % if (debug_resultant == 1)

  smallestcond = 1e40;
  bestalpha=0;
  bestbeta=0;
  bestgamma=0;
  bestdelta=0;

  % try alot (4) of different random (alpha,beta,gamma,delta) combinations
  % for the purpose of using the combination which had the lowest condition number

  for trial=1:40

    % generate random (alpha,beta,gamma,delta) combination

    alpha=rand(1);
    beta=rand(1);
    gamma=rand(1);
    delta=rand(1);

    if (bitand(debug_resultant,12) > 0)
      disp('alpha')
      disp(alpha)
      disp('beta')
      disp(beta)
      disp('gamma')
      disp(gamma)
      disp('delta')
      disp(delta)
    end % if (debug_resultant == 1)

    % compute the leading matrix s^maxdeg where t=(as+b)/(cs+d)
    % the leading matrix is computed by adding together the matrix monomials
    % variable^0, variable^1, variable^2, ..., variable^maxdeg, 
    % all weighted according to the s^maxdeg coefficient of the rational transformation
    % (as + b)^degree * (cs + d)^(maxdeg-degree) for degree={0,1,2,...,maxdeg}

    leadingmatrix = zeros(matsize,matsize);

    for j=0:maxdeg
      rational_factor = rationaltrans(alpha,beta,gamma,delta,maxdeg,j,maxdeg);
      thismat = decomposematpoly((j*matsize+1):((j+1)*matsize),1:matsize);
      leadingmatrix = leadingmatrix + rational_factor*thismat;
    end % for j=0:maxdeg

    if (bitand(debug_resultant,12) > 0)
      if (bitand(debug_resultant,32) > 0)
        disp('leading matrix')
        latex(leadingmatrix)
        disp('cond(leadingmatrix)')
        disp(cond(leadingmatrix))
      else
        disp('leading matrix')
        disp(leadingmatrix)
        disp('cond(leadingmatrix)')
        disp(cond(leadingmatrix))
      end % if (bitand(debug_resultant,32) > 0)
    end % if (debug_resultant == 1)

    % compute the condition number corresponding to this combination of (alpha,beta,...)

    condnum = cond(leadingmatrix);

    % check if this is the best combination so far (i.e., it has the lowest condition
    % number), and if so, save this combination

    if (condnum < smallestcond)
      smallestcond = condnum;
      bestalpha=alpha;
      bestbeta=beta;
      bestgamma=gamma;
      bestdelta=delta;
    end % if (condnum < smallestcond)

  end % for trial=1:4

    if (bitand(debug_resultant,12) > 0)
      disp('bestalpha')
      disp(bestalpha)
      disp('bestbeta')
      disp(bestbeta)
      disp('bestgamma')
      disp(bestgamma)
      disp('bestdelta')
      disp(bestdelta)
      disp('smallestcond')
      disp(smallestcond)
    end % if (debug_resultant == 1)

  % check if the smallest condition number is "small enough" (i.e., less than some
  % threhsold)

  if (smallestcond < 1e8)

    if (bitand(debug_resultant,12) > 0)
      disp('smallestcond < 1e8')
      disp('-> rational_quotient process')
    end % if (debug_resultant == 1)

    process = 'rational_quotient';

    procvals(1) = bestalpha;
    procvals(2) = bestbeta;
    procvals(3) = bestgamma;
    procvals(4) = bestdelta;

    alpha=bestalpha;
    beta=bestbeta;
    gamma=bestgamma;
    delta=bestdelta;
  
    % recompute the leading matrix s^maxdeg where t=(as+b)/(cs+d) using the best
    % combination of random coefficients
    % the leading matrix is computed by adding together the matrix monomials
    % variable^0, variable^1, variable^2, ..., variable^maxdeg, 
    % all weighted according to the s^maxdeg coefficient of the rational transformation
    % (as + b)^degree * (cs + d)^(maxdeg-degree) for degree={0,1,2,...,maxdeg}

    leadingmatrix = zeros(matsize,matsize);

    for j=0:maxdeg
      rational_factor = rationaltrans(alpha,beta,gamma,delta,maxdeg,j,maxdeg);
      thismat = decomposematpoly((j*matsize+1):((j+1)*matsize),1:matsize);
      leadingmatrix = leadingmatrix + rational_factor*thismat;
    end % for j=0:maxdeg

    if (bitand(debug_resultant,12) > 0)
      if (bitand(debug_resultant,32) > 0)
        disp('leading matrix')
        latex(leadingmatrix)
        disp('cond(leadingmatrix)')
        disp(cond(leadingmatrix))
      else
        disp('leading matrix')
        disp(leadingmatrix)
        disp('cond(leadingmatrix)')
        disp(cond(leadingmatrix))
      end % if (bitand(debug_resultant,32) > 0)
    end % if (debug_resultant == 1)

    % Compute the inverse of the leading matrix

    inverseleadingmatrix = inv(leadingmatrix);

    if (bitand(debug_resultant,12) > 0)
      if (bitand(debug_resultant,32) > 0) 
        disp('inverse leading matrix')
        latex(inverseleadingmatrix)
      else
        disp('inverse leading matrix')
        disp(inverseleadingmatrix)
      end % if (bitand(debug_resultant,32) > 0) 
    end % if (debug_resultant == 1)

    for i = 0:maxdeg-1

      % Compute the coefficient matrix for s^i
      % this matrix is computed by adding together the matrix monomials
      % variable^0, variable^1, variable^2, ..., variable^maxdeg, 
      % all weighted according to the s^i coefficient of the rational transformation
      % (as + b)^degree * (cs + d)^(maxdeg-degree) for degree={0,1,2,...,maxdeg}

      followingmatrix = zeros(matsize,matsize);

      for j=0:maxdeg
        rational_factor = rationaltrans(alpha,beta,gamma,delta,maxdeg,j,i);
        thismat = decomposematpoly((j*matsize+1):((j+1)*matsize),1:matsize);
        followingmatrix = followingmatrix + rational_factor*thismat;
      end % for j=0:maxdeg

    % Multiply -inverseleadingmatrix by the following matrix

      matrixmult = -inverseleadingmatrix * followingmatrix;

    % Copy the submatrix (matrixmult) into the proper cells in compmat

      compmat((bigsize-matsize+1):bigsize,(i*matsize+1):((i+1)*matsize))=matrixmult;

      if (bitand(debug_resultant,12) > 0)
        if (bitand(debug_resultant,32) > 0)
          disp('i')
          disp(i)
          disp('following matrix')
          latex(followingmatrix)
          disp('matrix mult')
          latex(matrixmult)
        else
          disp('i')
          disp(i)
          disp('following matrix')
          disp(followingmatrix)
          disp('matrix mult')
          disp(matrixmult)
        end % if (bitand(debug_resultant,32) > 0)
      end % if (debug_resultant == 1)

    end % for i = 0:maxdeg-1

  end % if (smallestcond < 1e8)

end % if (strcmp(process,'unknown'))

if (bitand(debug_resultant,1) > 0)
  disp('companionmatrix returned')
  if (bitand(debug_resultant,32) > 0)
    latex(compmat)
  else
    disp(compmat)
  end % if (bitand(debug_resultant,32) > 0)
end % if (debug_resultant == 1)

