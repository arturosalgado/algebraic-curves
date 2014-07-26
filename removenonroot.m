% Copyright (c) 1998 by Aaron Wallack, Natick, MA USA
% All rights reserved. This material contains unpublished,
% copyrighted work, which includes confidential and proprietary
% information of Aaron Wallack.

function ans = removenonroot(results,resultant)
% removenonroot removes the complex roots from an array of results

global debug_resultant

if (bitand(debug_resultant,1) > 0)
  disp('removenonroot called with ')
  disp('removenonroot')
  if (bitand(debug_resultant,32) > 0)
    latex(results);
    latex(resultant);
  else
    disp(results);
    disp(resultant);
  end % if (bitand(debug_resultant,32) > 0)
end % if (debug_resultant == 1)

numvalid = 0;

size1 = size(results,1);
size2 = size(results,2);

for i = 1:size1
  thisvalid = 1;
  maxval = 1;
  for j = 1:size2
    val = results(i,j);
    maxval=max(maxval,abs(val));
  end; % for j = 1:size2
  eval = evalresatx(resultant,results(i,1:size2));
  eval2 = double(sqrt(eval * transpose(eval)));
  maxvale6 = maxval*1e-6;
  if (eval2>maxvale6)
    thisvalid = 0;
  end % if (allzeros == 1)
  numvalid = numvalid + thisvalid;
end % for i = 1:size1

ans = zeros(numvalid,size2);

validindex = 1;

for i = 1:size1
  thisvalid = 1;
  maxval = 1;
  for j = 1:size2
    val = results(i,j);
    maxval=max(maxval,abs(val));
  end; % for j = 1:size2
  eval = evalresatx(resultant,results(i,1:size2));
  eval2 = double(sqrt(eval * transpose(eval)));
  maxvale6 = maxval*1e-6;
  if (eval2>maxvale6)
    thisvalid = 0;
  end % if (allzeros == 1)
  if (thisvalid == 1)
    ans(validindex,1:size2)=results(i,1:size2);
    validindex = validindex + 1;
  end % if (thisreal == 1)
end % for i = 1:size1

if (bitand(debug_resultant,1) > 0)
  disp('removenonroot returned')
  if (bitand(debug_resultant,32) > 0)
    latex(ans)
  else 
    disp(ans)
  end % if (bitand(debug_resultant,32) > 0)
end % if (debug_resultant == 1)


