function b = bernstein(n,I)

factn  =1;
facti  =1;
factni =1;
    
    for i=1:n
    
    factn=factn*i;
    end
    

    for i=1:I
        facti=facti*i;
        
    end 
    
    ni = n-I;
    
    for i=1:ni
        factni=factni*i;
    end 
    
    b = (factn)/(facti)*(factni);