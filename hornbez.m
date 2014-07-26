function aux = hornbez(degree,coeff,t)

% uses  Horner's scheme to compute one coordinate
% value of a  Bezier curve. Has to be called 
% for each coordinate  (x,y, and/or z) of a control polygon.
%
% Input:   degree: degree of curve.
%          coeff:  array with coefficients of curve.
%          t:      vector of parameter values.
% Output: coordinate value.
%
% For a demo see demo_hornbez.m

t1=1.0 - t;  
fact=1;
n_choose_i=1;

aux=coeff(1)*t1;         
for i=1:degree-1
  fact=fact.*t;
  n_choose_i=n_choose_i*(degree-i+1)/i;  
  aux=(aux + fact*n_choose_i*coeff(i+1)).*t1;
end
aux = aux + fact*coeff(degree+1).*t;
