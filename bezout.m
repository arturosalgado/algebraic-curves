function  bezout(f,g)

% degree of the polynomials
n = length(f)-1;
m = length(g)-1;

mm = zeros(m);

MM = sym(mm);

% Step1 initialization 

    for i=1:m
        
        for j=i:m

            MM(i,j)=f(i)*g(j+1)-g(i)*f(j+1);
            
        end
        
    end
    
% Step2. Define de rest of the elements in terms of step 1.    


    for i=2:m-1
        
        for j=i : m-1
            
            MM(i,j)=MM(i,j)+MM(i-1,j+1);
            
        end
        
    end
    
% Step 3 . Symetrically complete the entries         


    for i=2:m
        
        for j=1 :i
            
            MM(i,j)=MM(j,i);
            
        end
        
    end
  
  disp('Bezout Matrix')  
    
  MM  
  
  
  disp('Determinant')  
  
  pause
  
  
  pretty(det(MM));