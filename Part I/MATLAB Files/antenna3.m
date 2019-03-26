fileID = fopen('antenna306.nec','w'); %create the file
fprintf(fileID,'CM Antenna 306\n');
fprintf(fileID,'CE\n');

i=1;
lambda = 1;
step=lambda/10;
for z=5*lambda/4:-step:-5*lambda/4
    for x=-lambda/2:step:lambda/2
        if x<lambda/2 
			fprintf(fileID,'GW %d 1 %4.3f 0 %4.3f %4.3f 0 %4.3f %4.3f \n', i, x, z, x+step, z, lambda/200);
			i=i+1;
        end
        if z>-5*lambda/4
			fprintf(fileID,'GW %d 1 %4.3f 0 %4.3f %4.3f 0 %4.3f %4.3f \n', i, x, z, x, z-step, lambda/200);
			i=i+1;
        end
        
    end
end


height = zeros(1,4);
height(1) = -0.9*lambda;
height(2) = -0.3*lambda;
height(3) = 0.3*lambda;
height(4) = 0.9*lambda;

for j=1:1:4
    fprintf(fileID,'GW %d %d %f %f %f %f %f %f %f \n', i, 3, lambda/50, lambda/4, height(j),...
        lambda/50+lambda*cos(pi/8)/4, lambda/4, lambda*sin(pi/8)/4 + height(j), lambda/200);
    i=i+1;
    fprintf(fileID,'GW %d %d %f %f %f %f %f %f %f \n', i, 3, -lambda/50-lambda*cos(pi/8)/4, lambda/4, -lambda*sin(pi/8)/4 + height(j),...
        -lambda/50, lambda/4, height(j), lambda/200);
    i=i+1;
    fprintf(fileID,'GW %d %d %f %f %f %f %f %f %f \n', i, 3, -lambda/50-lambda*cos(pi/8)/4, lambda/4, +lambda*sin(pi/8)/4 + height(j),...
        -lambda/50, lambda/4, height(j), lambda/200);
    i=i+1;
    fprintf(fileID,'GW %d %d %f %f %f %f %f %f %f \n', i, 3, lambda/50, lambda/4, height(j),...
        lambda/50+lambda*cos(pi/8)/4, lambda/4, -lambda*sin(pi/8)/4 + height(j), lambda/200);
    i=i+1;
end
fprintf(fileID,'GW %d %d %f %f %f %f %f %f %f \n', i, 1, -0.02, lambda/4, 0,...
        0.02, lambda/4, 0, lambda/200);
i=i+1;
for j=1:1:4
    fprintf(fileID,'GW %d %d %f %f %f %f %f %f %f \n', i, 1, -0.02, lambda/4, height(j),...
        0.02, lambda/4, height(j), lambda/200);
    i = i+1;
end
fprintf(fileID,'EX	0	552	1	0	1	0	0 \nTL	552	1	553	1	100	0	0	0	0	0\nTL	552	1	555	1	100	0	0	0	0	0\nTL	553	1	554	1	-100	0	0	0	0	0\nTL	555	1	556	1	-100	0	0	0	0	0\nFR	0	0	0	0	300	0\n EN');




fclose(fileID); %close the file