
% Question1
V=230
f=50
R=500
L=650
w=2*pi*f
Z=R+j*w*L
phi=atan(w*L/R)
% equation
t=linspace(2,0.5,1000);
I=V/abs(Z).*(cos(w*t-phi)-exp(-t*R/L)*cos(phi))

plot(I)



% Question2

Phi=linspace(-pi/4,pi/4,100)

x=cos(Phi).*sqrt(2*cos(2*Phi))

y=sin(Phi).*sqrt(2*cos(2*Phi))

plot(x,y)


