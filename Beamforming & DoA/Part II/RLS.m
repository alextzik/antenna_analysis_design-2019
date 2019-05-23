thetas=zeros(6,1);
thetas(1)=50*pi/180;
thetas(2)=70*pi/180;
thetas(3)=100*pi/180;
thetas(4)=110*pi/180;
thetas(5)=130*pi/180;
thetas(6)=160*pi/180;

thetasInput=[50, 70, 100, 110, 130, 160];
Q=100;

A=zeros(8, 6);
for k=1:6
        for l=1:8
            A(l,k)=exp(1i*pi*(l-1)*cos(thetas(k)));
        end
end

g_array=normrnd(0, 1, 6, Q);
n_array=normrnd(0, sqrt(0.01), 8, Q);

x=A*g_array+n_array;

% Set a 
a=0.98;
a_inv=1/a;

% Set w_RLS
w_RLS=zeros(8,1);

% Set Rxx^(-1)
delta=10^6;
Rxx_inv=delta*eye(8); %Since m=6 (6 different incoming signals)

%Iterations for Qs

for q=2:Q
    x_q=(x(:, q));
    h_bar=(a_inv*Rxx_inv*x_q)/(1+a_inv*x_q'*Rxx_inv*x_q);
    Rxx_inv=(q/(q-1))*(a_inv*Rxx_inv-a_inv*h_bar*x_q'*Rxx_inv);
    w_RLS=w_RLS+h_bar*(conj(g_array(1, q))-x_q'*w_RLS);
end

thetasDiagram=0:pi/1800:pi;
a_thetas=zeros(8, length(thetasDiagram));
for m=1:8
     a_thetas(m,:)=exp(1i*pi*(m-1)*cos(thetasDiagram));
end
AF=abs(w_RLS'*a_thetas);
plot(thetasDiagram*180/pi, AF);
xlabel('\fontname{Bookman Old Style} Elevation Angle [deg]');
ylabel('\fontname{Bookman Old Style} Magnitude of Array Factor');
title('\fontname{Bookman Old Style} Radiation Pattern');
disp(w_RLS);

div=zeros(1,6);
[~, div(1)]=max(AF);
div(1)=abs(div(1)*pi/1800*180/pi-thetasInput(1));
[~, indicesZeroesOfDiagram]=findpeaks(max(AF(:)) - AF);
thetasZeroesofDiagram=indicesZeroesOfDiagram*pi/1800*180/pi;
div(2)=min(abs(thetasZeroesofDiagram-thetasInput(2)));
div(3)=min(abs(thetasZeroesofDiagram-thetasInput(3)));
div(4)=min(abs(thetasZeroesofDiagram-thetasInput(4)));
div(5)=min(abs(thetasZeroesofDiagram-thetasInput(5)));
div(6)=min(abs(thetasZeroesofDiagram-thetasInput(6)));
%disp(div)


