function [y] = GAI_Laplace(x,lambda,gamma,Iter)
if nargin < 4
    Iter=10;
end
a0=max(-gamma.*log(gamma.^2./lambda),0);
delta=a0+Laplace_gradient(a0,gamma,lambda);
%===========================
tol=10.^(-3);%eps;%
  [m,n]=size(x);
 y=zeros(size(m,n));
 

 for i=1:m
     for j=1:n
         
         gradient_g= Laplace_gradient(x(i,j),gamma,lambda);
         if gradient_g==0
             BARx_b=x(i,j);
             
         else
             if delta<x(i,j)
                 a=x(i,j);
                 sto=0;kkk=0;
                 while sto==0
                     kkk=kkk+1;
                     a1=x(i,j)-Laplace_gradient(a,gamma,lambda);
                     a2=x(i,j)-Laplace_gradient(a1,gamma,lambda);
                     % new_a=a1-(a2-a1)*(a1-a)/(a2-2*a1+a);
                     if abs(a2-2*a1+a)<tol || kkk>=Iter
                         BARx_b=a1-(a2-a1)*(a1-a)/(a2-2*a1+a);
                         break;
                     end
                     a=a1-(a2-a1)*(a1-a)/(a2-2*a1+a);  
                 end
             else
                 BARx_b=a0;
             end
             if Laplace_fun(BARx_b,x(i,j),gamma,lambda)<=Laplace_fun(0,x(i,j),gamma,lambda)
                 y(i,j)=BARx_b;   
             else
                 y(i,j)=0;
             end
         end
         
         
     end
 end
          






%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
%Logarithm��gradient����ʽ
function gradient_g= Laplace_gradient(x,gamma,lambda)
gradient_g=lambda./gamma.*exp(-x/gamma);
return;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
function g= Laplace_fun(x,y,gamma,lambda)
g=1/2*(y-x).^2+lambda.*(1-exp(-x/gamma));
return;

