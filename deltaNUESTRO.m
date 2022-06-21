clear all
close all
clc

%signo de brazos
brazo_derecho=-1;
brazo_izquierdo=1;

%%[q1,q2]=calcIK(x,y); se debe hacer esta función de tarea
%objetivo
Ox=15;
Oy=-40;


%Dimensiones del Robot
l1=25;
l2=34.5;
l5=16;
l6=13;
offEE=4.5;%cm
desface_brazo=8;%DEFINIR

%objetivo en el centro
Xc=Ox;
Yc=Oy+offEE;
%Objetivo en el brazo derecho
Xr=Xc+(l6/2)-desface_brazo;%restarle la mitad para el desface y sumar l6
Yr=Yc;%DUDAAAAA
%brazo izquierdo
Xl=Xc-(l6/2)+desface_brazo;%sumarle la mitad para el desface y retar el l6
Yl=Yc;%DUDAAAAA

[q1r,q2r]=calc_IK_2DoF (Xr,Yr,l1,l2,brazo_derecho);%LADO DERECHO
[q1l,q2l]=calc_IK_2DoF (Xl,Yl,l1,l2,brazo_izquierdo);%LADO IZQUIERDO
angulo_derecho=rad2deg(q1r)*-1
angulo_izquierdo=(rad2deg(q1l)+180)*-1

%ladod derecho
a1r=l1; alpha1r=0; d1r=0; th1r=0+q1r;
a2r=l2; alpha2r=0; d2r=0; th2r=0+q2r;
%lado izquierdo
a1l=l1; alpha1l=0; d1l=0; th1l=0+q1l;
a2l=l2; alpha2l=0; d2l=0; th2l=0+q2l;

%lado derecho
T1r=calc_A(a1r,alpha1r,d1r,th1r); %sistema 1 con respecto a 0
T2r=calc_A(a2r,alpha2r,d2r,th2r); %sistema 2 con respecto a 1
%lado izquierdo
T1l=calc_A(a1l,alpha1l,d1l,th1l); %sistema 1 con respecto a 0
T2l=calc_A(a2l,alpha2l,d2l,th2l); %sistema 2 con respecto a 1

%lado derecho
Tnr=T1r*T2r;
%lado izquierdo
Tnl=T1l*T2l;

%lado derecho
Xrobot=Tnr(1,4);
Yrobot=Tnr(2,4);
%lado izquierdo
Xlrobot=Tnl(1,4);
Ylrobot=Tnl(2,4);

figure;
%lado derecho
plot(Ox,Oy,'sg',Xrobot+l5/2,Yrobot,'*r', T1r(1,4)+l5/2,T1r(2,4),'sg');

line([0;l5/2],[0;0],'Color','r');%función que dibuja una linea entre dos puntos
line([0;-l5/2],[0;0],'Color','g');%función que dibuja una linea entre dos puntos

line([l5/2;T1r(1,4)+l5/2],[0;T1r(2,4)],'Color','blue');%función que dibuja una linea entre dos puntos
line([T1r(1,4)+l5/2;Tnr(1,4)+l5/2],[T1r(2,4);Tnr(2,4)],'Color','blue');
line([Xc;Tnr(1,4)+l5/2],[Yc;Tnr(2,4)],'Color','blue');
line([Xc;Ox],[Yc;Oy],'Color','red');
%lado izquierdo
hold on;
plot(Ox,Oy,'sg',Xlrobot-l5/2,Ylrobot,'*r', T1l(1,4)-l5/2,T1l(2,4),'sg');
line([-l5/2;T1l(1,4)-l5/2],[0;T1l(2,4)],'Color','blue');%función que dibuja una linea entre dos puntos
line([T1l(1,4)-l5/2;Tnl(1,4)-l5/2],[T1l(2,4);Tnl(2,4)],'Color','blue');
line([Xc;Tnl(1,4)-l5/2],[Yc;Tnl(2,4)],'Color','blue');
%line([Xc;Ox],[Yc;Oy],'Color','red');



xlim([-50,50]);
ylim([-80,20]);
grid on;
title("Cinemática inversa - Robot Delta");
hold off;