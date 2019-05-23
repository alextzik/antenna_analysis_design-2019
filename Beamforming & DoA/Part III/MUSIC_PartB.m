% Part B
for theta=pi/2-pi/1800:pi/180000:pi/2

   Ps=1;
   Pn=0.1; 
    
   thetas=zeros(2,1);
   thetas(1)=theta;
   thetas(2)=pi-theta;
   
   thetasInput=[thetas(1)*180/pi, thetas(2)*180/pi];
    
   A=zeros(8, 2);
   for k=1:2
        for l=1:8
            A(l,k)=exp(1i*pi*(l-1)*cos(thetas(k)));
        end
   end
   
   Rgg=eye(2);
   Rnn=Pn*eye(8);

   Rxx=A*Rgg*A'+Rnn;
   
    [V,D] = eig(Rxx);
    D=abs(D);

    %M-N=1
    D_sorted=sort(reshape(D',[],1));
    eigenVal=D_sorted(length(D_sorted)-8+1);
    index=find(D==eigenVal);
    eigenVect=V(:,(index+8)/9);

    thetaDiagram=0:pi/18000:pi;
    P_phi_theta_Array=zeros(length(thetaDiagram), 1);
    k=1;
    for theta2=thetaDiagram
        a_thetas=zeros(8, 1);
        for m=1:8
            a_thetas(m,1)=exp(1i*pi*(m-1)*cos(theta2));
        end
        P_phi_theta_Array(k)=abs(1/(a_thetas'*(eigenVect*eigenVect')*a_thetas));
        k=k+1;
    end

    Pmax=max(P_phi_theta_Array);
    P_phi_theta_Array_dB=10*log10(P_phi_theta_Array/Pmax);
    peaks=findpeaks(P_phi_theta_Array_dB);
    peaks=peaks(find(peaks>=-50));
    if (length(peaks)==1)
        thetaLimit=(theta-pi/180000)*180/pi;
        break;
    end
    
end


minDifferenceforSeperation=(180-thetaLimit)-thetaLimit;
disp(minDifferenceforSeperation);