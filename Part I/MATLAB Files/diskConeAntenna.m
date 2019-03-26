function [  ] = diskConeAntenna(r, l, theta, d, lambda)
    
    %Disk Coordinates
    startCoords_Disk=zeros(3,8);
    endCoords_Disk=zeros(3,8);
    for i=1:1:8
       phi=i*pi/4;
       endCoords_Disk(1,i)=r*cos(phi);
       endCoords_Disk(2,i)=r*sin(phi);
    end
    
    %Cone Coordinates
    startCoords_Cone=zeros(3,8);
    startCoords_Cone(3, :)=-d;
    endCoords_Cone=zeros(3,8);
    for i=1:1:8
       phi=i*pi/4;
       endCoords_Cone(1,i)=l*sin(theta)*cos(phi);
       endCoords_Cone(2,i)=l*sin(theta)*sin(phi);
    end
    endCoords_Cone(3,:)=-d-l*cos(theta);
    
    %General Info
    numOfSegments=11; %for 10: l/10=ë/20<ë/10 r/10=ë/30<ë/10 (odd needed: 11)
    thicknessDiameter=lambda/100;
    generalData=zeros(7,17);
    for i=1:1:8
        generalData(1, i)=i;
        generalData(2:4, i)=startCoords_Disk(:,i);
        generalData(5:7, i)=endCoords_Disk(:,i);
    end
    for i=1:1:8
        generalData(1, i+8)=i+8;
        generalData(2:4, i+8)=startCoords_Cone(:,i);
        generalData(5:7, i+8)=endCoords_Cone(:,i);
    end
    generalData(1,17)=17;
    generalData(7,17)=-d;
    %Print
    formatSpec='GW %d 11 %4.3f %4.3f %4.3f %4.3f %4.3f %4.3f 0.025 \n';
    fprintf(formatSpec, generalData);
end

