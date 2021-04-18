clc; clear; close all;

N = 4;
x = [1,2,3,4];

k = (0:N-1); 
n=(0:N-1);

A = x.*exp(-j*(2*pi/N)*k'*n);

X_SUM = [sum(A(1,:)); sum(A(2,:)); sum(A(3,:)); sum(A(4,:))]

Q = [1,1,1,1; 1,-j,-1,j; 1,-1,1,-1; 1,j,-1,-j];

compare_1 = Q*x.' 

Qe = [Q(:,1), Q(:,3)];
Qo = [Q(:,2), Q(:,4)]; 

xe = [x(1);x(3)];
xo = [x(2);x(4)];

compare_2 = Qe*xe + Qo*xo

Qo_imag = [1;-j;-1;j];
Qo_real = [1,1; 1,-1; 1,1; 1,-1];
          
compare_3 = Qe*xe + Qo_imag.*Qo_real * xo

Qe_cut = [1,1;
              1,-1];

Qo_real_cut = [1,1;
                  1,-1];

Even = [Qe_cut*xe;
        Qe_cut*xe];
         
Odd = [Qo_real_cut*xo;
       Qo_real_cut*xo];

compare_4 = Even + Qo_imag .* Odd

