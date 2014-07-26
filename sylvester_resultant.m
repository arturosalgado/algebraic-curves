function result = sylvester_resultant(f,g)
% constructs and evaluates if two functions
% f and g have a common root by building 
% the sylvester matrix and then evaluating the 
% determinant of it.

    % degree of the f function 
n = length (f)-1;

    % degree of the g function 

m = length (g)-1;

a =1;


matrix_dimension = m+n;
sylveste_matrix = sym('zeros(m+n,m+n)')





%
    % do with respect to f    
 
     %%for i=1:m 
       %%sylvester_matrix(i,i:i+m)=f;
       %%   end
   
    % do with respect to g
    %%%j = 1;
   %%% for k = i+1: n+m
      %%  sylvester_matrix(k,j:j+m)  = g;
       %% j= j+1;
       %%    end
        
%%%display(n);
%%display(m);

%%display(sylvester_matrix);

    % returns the matrix determinant 
    % if it equals to zero the functions share a common root;

%%common = det (sylvester_matrix);

%%if (common ==0 ) 
  %%  disp('common roots')
  %%else    disp('no common roots')
  %%%end
%%%result = common;
