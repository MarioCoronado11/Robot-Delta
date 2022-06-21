function [theta1,theta2]=calc2_IK_2DoF (x,y,l1,l2,brazo)

%brazo es el signo para la raiz, el -1 es para el lado derecho y el 1 para
%el izquierdo

D=(x^2+y^2-l1^2-l2^2)/(2*l1*l2);

if (1-D^2)<0
    x=0;
    y=-30;
   fprintf("Posición no posible, yendo a posición segura");
   D=(x^2+y^2-l1^2-l2^2)/(2*l1*l2);
  
   
   theta2=atan2(brazo*sqrt(1-D^2), D);
   
  
   theta1=atan2(y,x)-atan2(l2*sin(theta2),l1+l2*cos(theta2));
    
     
else    
    theta2=atan(brazo*sqrt(1-D^2)/ D)+func_const (D,brazo*sqrt(1-D^2));
   % yy=brazo*sqrt(1-D^2)
    %xx=D
    %theta2 = (theta2)-pi
    theta1=(atan(y/x)+func_const (x,y))-((atan((l2*sin(theta2)) / (l1+l2*cos(theta2))) )+func_const ((l1+l2*cos(theta2)),(l2*sin(theta2))));
    print(rad2deg(theta1));
    %yy2=y
    %xx2=x
    yy3=l2*sin(theta2)
    xx3=l1+l2*cos(theta2)
end
       
end