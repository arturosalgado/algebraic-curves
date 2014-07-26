% Copyright (c) 1998 by Aaron Wallack, Natick, MA USA
% All rights reserved. This material contains unpublished,
% copyrighted work, which includes confidential and proprietary
% information of Aaron Wallack.

function ans = removecomplex(results)
% removecomplex removes the complex roots from an array of results

global debug_resultant

if (bitand(debug_resultant,1) > 0)
  disp('removecomplex called with ')
  disp('removecomplex')
  if (bitand(debug_resultant,32) > 0)
    latex(results);
  else
    disp(results);
  end % if (bitand(debug_resultant,32) > 0)
end % if (debug_resultant == 1)

numreal = 0;

size1 = size(results,1);
size2 = size(results,2);

for i = 1:size1
  thisreal = 1;
  allzeros = 1;
  for j = 1:size2
    val = results(i,j);
    realcomponent=max(1,abs(real(val)));
    if (abs(imag(val))>realcomponent/1e6)
      thisreal = 0;
    end;
    if (abs(val) > 1e-12)
      allzeros = 0;
    end;
  end; % for j = 1:size2
  if (allzeros == 1)
    thisreal = 0;
  end % if (allzeros == 1)
  numreal = numreal + thisreal;
end % for i = 1:size1

ans = zeros(numreal,size2);

realindex = 1;

for i = 1:size1
  thisreal = 1;
  allzeros = 1;
  for j = 1:size2
    val = results(i,j);
    realcomponent=max(1,abs(real(val)));
    if (abs(imag(val))>realcomponent/1e6)
      thisreal = 0;
    end;
    if (abs(val) > 1e-12)
      allzeros = 0;
    end;
  end; % for j = 1:size2
  if (thisreal == 1 & allzeros == 0)
    ans(realindex,1:size2)=results(i,1:size2);
    realindex = realindex + 1;
  end % if (thisreal == 1)
end % for i = 1:size1

if (bitand(debug_resultant,1) > 0)
  disp('removecomplex returned')
  if (bitand(debug_resultant,32) > 0)
    latex(ans)
  else 
    disp(ans)
  end % if (bitand(debug_resultant,32) > 0)
end % if (debug_resultant == 1)


