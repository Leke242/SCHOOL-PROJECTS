x=0:pi/24:2*pi;
y1=sin(x );
y2=cos(x);
y3=cos(2*x);


plot(x,y1,'*')
hold on
plot(x,y2,'o')
hold on
plot(x,y3,'--')
hold off
legend('sin x','cos x', 'cos 2x')
xlabel('x')
ylabel('y')
title('Multiple graphs')
