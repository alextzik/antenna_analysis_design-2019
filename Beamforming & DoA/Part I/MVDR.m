function [ outputMatrix ] = MVDR( deltaThetaMin, SNR )
    %%% MVDR %%%%%%%
    
    % Fill array with thetas
    thetas=zeros(1000,3);
    generalData=zeros(1000,7);
    
    i=1;
    while(i<=1000)
        while 1
            theta0=rand * 120 + 30;
            theta1=rand * 120 + 30;
            theta2=rand * 120 + 30;
            thetasCurrent=sort([theta0, theta1, theta2]);
            if ~(thetasCurrent(2)-thetasCurrent(1)<deltaThetaMin || thetasCurrent(3)-thetasCurrent(2)<deltaThetaMin)
                break;
            end
        end
        [div, SINR]=MVDRalgorithm(SNR, [theta0, theta1, theta2]);
        generalData(i, 1)=theta0;
        generalData(i, 2)=theta1;
        generalData(i, 3)=theta2;
        generalData(i, 4)=div(1);
        generalData(i, 5)=div(2);
        generalData(i, 6)=div(3);
        generalData(i, 7)=SINR;
        i=i+1;
    end 
   
    
    formatSpec='%4.3f %4.3f %4.3f %4.3f %4.3f %4.3f %4.3f \n';
    fileID=fopen('AoAdev_SINR.txt','w');
    fprintf(fileID, formatSpec, generalData');
    fclose(fileID);
    
    %Load file
    filename='AoAdev_SINR.txt';
    [dataFromFile, delimiter]=importdata(filename);
    minDeltaTheta0s=min(dataFromFile(:, 4));
    maxDeltaTheta0s=max(dataFromFile(:, 4));
    meanDeltaTheta0s=mean(dataFromFile(:, 4));
    varDeltaTheta0s=std(dataFromFile(:, 4));
    
    minDeltaTheta1_2s=min([dataFromFile(:, 5); dataFromFile(:, 6)] );
    maxDeltaTheta1_2s=max([dataFromFile(:, 5); dataFromFile(:, 6)] );
    meanDeltaTheta1_2s=mean([dataFromFile(:, 5); dataFromFile(:, 6)] );
    varDeltaTheta1_2s=std([dataFromFile(:, 5); dataFromFile(:, 6)] );
    
    minSINRs=min(dataFromFile(:, 7));
    maxSINRs=max(dataFromFile(:, 7));
    meanSINRs=mean(dataFromFile(:, 7));
    varSINRs=std(dataFromFile(:, 7));
    
    outputMatrix=[minDeltaTheta0s, maxDeltaTheta0s, meanDeltaTheta0s, varDeltaTheta0s, minDeltaTheta1_2s, maxDeltaTheta1_2s,... 
        meanDeltaTheta1_2s, varDeltaTheta1_2s, minSINRs, maxSINRs, meanSINRs, varSINRs];

end

