function [ div, SINR_dB ] = MVDRalgorithm( SNR_dB, thetasInput )
%MVDRALGORITHM Summary of this function goes here
%   Detailed explanation goes here
    SNR = 10^(SNR_dB/10);
    thetas=thetasInput*pi/180;
    a_d=zeros(8,1);
    for k=1:8
        a_d(k)=exp(1i*pi*(k-1)*cos(thetas(1)));
    end

    Rnn=(1/SNR)* eye(8);
    Rgg=eye(3);
    
    A=zeros(8,3);
    for k=1:3
        for l=1:8
            A(l,k)=exp(1i*pi*(l-1)*cos(thetas(k)));
        end
    end
    
    Rxx=A*Rgg*A'+Rnn;
    w_MV = inv(Rxx) * a_d;
   
    thetasDiagram=0:pi/1800:pi;
    a_thetas=zeros(8, length(thetasDiagram));
    for m=1:8
        a_thetas(m,:)=exp(1i*pi*(m-1)*cos(thetasDiagram));
    end
    AF=abs(w_MV'*a_thetas);
    plot(thetasDiagram*180/pi, AF);
    xlabel('\fontname{Bookman Old Style} Elevation Angle [deg]');
    ylabel('\fontname{Bookman Old Style} Magnitude of Array Factor');
    title('\fontname{Bookman Old Style} Radiation Pattern');
   
    
    div=zeros(1,3);
    [~, lcs]=findpeaks(AF);
    lcs=abs(lcs*pi/1800*180/pi-thetasInput(1));
    div(1)=min(lcs);
    [~, indicesZeroesOfDiagram]=findpeaks(max(AF(:)) - AF);
    thetasZeroesofDiagram=indicesZeroesOfDiagram*pi/1800*180/pi;
    div(2)=min(abs(thetasZeroesofDiagram-thetasInput(2)));
    div(3)=min(abs(thetasZeroesofDiagram-thetasInput(3)));
   
    SINR_dB=10*log10((w_MV'*a_d*a_d'*w_MV)/(w_MV'*A(:, 2:3)*A(:, 2:3)'*w_MV+w_MV'*Rnn*w_MV));
end

