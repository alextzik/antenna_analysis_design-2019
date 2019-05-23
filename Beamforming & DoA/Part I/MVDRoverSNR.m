%Alexandros Tzikas - AEM: 8978
%Code implemented in MATLAB R2014b


allData=zeros(20, 12);

i=1;
for SNR=[0, 5, 10, 20]
   for dThetaMin=[2, 4, 6, 8, 10]
       output=MVDR( dThetaMin, SNR );
       allData(i, :)=output;
       i=i+1;
   end 
end

allData