%ejmplo7

ezplot('y-x*x');
hold
ezplot('x*x+y*y-1');

% intersection y at  0.6178
% intersection x at -0.7859

f1 ='y - x*x'
f2 =' x*x + y*y - 1'
var= 'x'
hiddenvar='y'
maple('read(`../maple/shorthand.map`);');
[r,s]=maple('Bezout_shorthand_2',f1,f2,var,hiddenvar);

maple('fnarray:=array(1..2,)')
