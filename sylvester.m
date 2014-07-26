function sylvester_matrix = sylvester(f,g) 

n = length(f)-1;
m = length(g)-1;

mm = zeros(m+n);

mm = sym(mm);



% transform the coefficients into 
% symbolic 

fs = size(n+1);
fs = sym(fs);

    for i=1 : n+1
        fs(i)=sym(f(i));
    end
    
gs = size(m+1);    
gs = sym(gs);

    for j=1:m+1
        gs(j)=sym(g(j));
    end
% once the coefficients are symbolic create the matrix

  for i=1:m 
    
       mm(i,i:i+m)=fs(1,:);
       
  end
  j=1;
  
 
 
  for k=i+1:m+n
     
      mm(k,j:j+m)=gs(1,:);
      j=j+1;
  end
    
  disp('Sylvester Matrix') 
  mm
  
  
    answer=det(mm);
    
  disp('Determinant') 
    
    pretty(answer)