clear all
clc

%User Defined Properties 
SerialPort='com8'; %serial port
s = serial(SerialPort);
set(s,'BaudRate',9600); % to be known from arduino
fopen(s);
%%
%postion defined variables(get more specific info from 3agmy) 
coilpos=[50 50];%the absolute postion of the coil relative to the centre of the robot
robpos=[50 50];% robot inetial postion

Umines=zeros(1000,2);%pre allocation
U=1;% upper mine index
Dmines=zeros(1000,2);%pre allocation
D=1;%down mine index
encoderratio=1; %value vor tuning the reading sent by encoder

%% plot variables and functions 
% RESPONSIBLE FOR THE DOMAIN OF PLOT
% the dimension of the map 20m by 20m
yMax  = 2100;                 %y Maximum Value (cm)
yMin  = -100;                %y minimum Value (cm)
min = -100;                         % set x-min (cm)
max = 2100;                      % set x-max (cm)

plotTitle = 'Mine sweeper map';  % plot title
xLabel = 'X axis';     % x-axis label
yLabel = 'Y axis';      % y-axis label
legend1 = 'Robot';
legend2 = 'Under Mine';
legend3 = 'Upper mine';


robot = plot(robpos(1,1),robpos(1,2),'o');  % every AnalogRead needs to be on its own Plotgraph
hold on;
uppermines = scatter(Umines(:,1),Umines(:,2),'og');
lowermines = scatter(Dmines(:,1),Dmines(:,2),'+b' );

title(plotTitle,'FontSize',15);
xlabel(xLabel,'FontSize',15);
ylabel(yLabel,'FontSize',15);
legend(legend1,legend2,legend3)
axis([yMin yMax min max]);
grid('on');

drawnow
%%
while ishandle(robot)%need to check if it works and faster than traditional(what if the robot got out by mistake !!!!!)
     recieved=fscanf(s,'%s'); %%need to make sure that (%s) works correctly
     
   
     yangle=str2double(recieved(1:3));%changing the values every loop
     zangle=str2double(recieved(4:6));
     encoder=str2double(recieved(7:9));
     minestate=str2double(recieved(10));

         %This is the magic code 
         %Using plot will slow down the sampling time.. At times to over 20
         %seconds per sample!
%-----------------------------------------------------------------------------------------
%to-do  the logic that will make sence of the data
% some values (like encoder) may need pre processing
%plese declare the robot posetion as a vector (ex:robpos[2 1])/done

 robpos(1,1)=robpos(1,1)+ cosd(zangle)*encoder* sind(yangle)*encoderratio;
 robpos(1,2)=robpos(1,2)+ cosd(zangle)*encoder *cosd(yangle)*encoderratio;

%--------all the next code needs modification because you didn't consider the orientation of the robot /(took into consedration) 
switch minestate
    
        case 1 % the mine is up and on the right
            
            Umines(U,1) = robpos(1,1) + coilpos(1,1)*cos(yangle);
            Umines(U,2) = robpos(1,2) + coilpos(1,2)*sin(yangle);
            U=U+1;
            
      % break;
        
        case 2 %  the mine is up and on the left
            
            Umines(U,1) = robpos(1,1) - coilpos(1,1)*cos(yangle);
            Umines(U,2) = robpos(1,2) - coilpos(1,2)*sin(yangle);
            U=U+1;
      %  break;
        
        case 3 % the mine is down and on the right
            
             Dmines(U,1) = robpos(1,1) + coilpos(1,1)*cos(yangle);
             Dmines(U,2) = robpos(1,2) + coilpos(1,2)*sin(yangle);
             D=D+1;
      % break;
        
        case 4 % the mine is down and on the left
            
             Dmines(U,1) = robpos(1,1) - coilpos(1,1)*cos(yangle);
             Dmines(U,2) = robpos(1,2) - coilpos(1,2)*sin(yangle);
             D=D+1;   
      % break;
end
%--------------------------------------------------------------
         set(robot,'XData',robpos(1,1),'YData',robpos(1,2));
         %refreshdata(uppermines);
         %refreshdata(lowermines);
         set(uppermines,'XData',Umines(:,1),'YData',Umines(:,2));
         set(lowermines,'XData',Dmines(:,1),'YData',Dmines(:,2));
         drawnow limitrate
         %% considered
         %then after you loop once all the data is bye bye overwritten by
         %the new data. you didn't save mines posetions you only plot them
         %and overwite the data on the same variable (Dmines(U,1))
         %this can works with the robotposetion because we don't need to save it
         %but the mine case is different. we need to save them all in a materix
         %as we discussed earlier this matrix is to be declared and
         %inatialized with zeros at the beginning.
         % try to declare all your variables at the beginning of the code
         %%
          %Update the graph
          %pause(delay); %no need for this in our code we have enough
          %waiting inside the code
end
delete(s);
disp('Plot Closed and arduino object has been deleted');

