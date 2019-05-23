% Part A
%%%%
SNR_dB=10;
Ps=1;
Pn=0.1;

thetas=zeros(7,1);
thetas(1)=40*pi/180;
thetas(2)=60*pi/180;
thetas(3)=80*pi/180;
thetas(4)=100*pi/180;
thetas(5)=120*pi/180;
thetas(6)=130*pi/180;
thetas(7)=150*pi/180;

thetasInput=[40, 60, 80, 100, 120, 130, 150];

A=zeros(8, 7);
for k=1:7
    for l=1:8
        A(l,k)=exp(1i*pi*(l-1)*cos(thetas(k)));
    end
end


Rgg=eye(7);
Rnn=Pn*eye(8);

Rxx=A*Rgg*A'+Rnn;


[V,D] = eig(Rxx);
D=abs(D);

%M-N=1
D_sorted=sort(reshape(D',[],1));
eigenVal=D_sorted(length(D_sorted)-8+1);
index=find(D==eigenVal);
eigenVect=V(:,(index+8)/9);

%{
i=1;
j=1;
for k=2:8
    if (minEigenVal<=D(k,k))
        eigenVect(:, i)=V(:,j);
        minEigenVal=D(k,k);
        j=k;
        i=i+1;
    else 
        eigenVect(:, i)=V(:, k)
        minEigenVal=D(j,j);
        i=i+1;
    end
end
%}

thetaDiagram=0:pi/18000:pi;
P_phi_theta_Array=zeros(length(thetaDiagram), 1);
k=1;
for theta=thetaDiagram
    a_thetas=zeros(8, 1);
    for m=1:8
        a_thetas(m,1)=exp(1i*pi*(m-1)*cos(theta));
    end
    P_phi_theta_Array(k)=abs(1/(a_thetas'*eigenVect*(eigenVect')*a_thetas));
    k=k+1;
end

Pmax=max(P_phi_theta_Array);

plot(thetaDiagram*180/pi, 10*log10(P_phi_theta_Array/Pmax));
xlabel('\fontname{Bookman Old Style} Elevation Angle [deg]');
ylabel('\fontname{Bookman Old Style} Power [dB]');
title('\fontname{Bookman Old Style} Spatial Power Spectrum of MUSIC');


