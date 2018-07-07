clear
clc

%User Defined Properties 
SerialPort='com6'; %serial port
s = serial(SerialPort);
set(s,'BaudRate',115200); % to be known from arduino
fopen(s);
recived=fscanf(s,'%s'); %%need to make sure that (%s) works correctly

%%
%postion defined variables(get more specific info from 3agmy) 
yangle=str2double(recieved(1:3));%pre allocation
zangle=str2double(recieved(4:6));
encoder=str2double(reciveed(7:9));
minestate=str2double(recieved(10));

coilpos=zeros(1,2);%the absolute postion of the coil relative to the centre of the robot

robpos=zeros(1,2);% robot postion

Umines=zeros(1000000,2);%pre allocation
U=0;% upper mine index
Dmines=zeros(1000000,2);%pre allocation
D=0;%down mine index

%% plot variables and functions 
% RESPONSIBLE FOR THE DOMAIN OF PLOT

yMax  = 2000   ;                 %y Maximum Value (cm)
yMin  = 0       ;                %y minimum Value (cm)
plotGrid = 'on';                 % 'off' to turn off grid
min = 0;                         % set y-min (cm)
max = 2000;                      % set y-max (cm)

plotTitle = 'Mine sweeper map';  % plot title
xLabel = 'X axis';     % x-axis label
yLabel = 'Y axis';      % y-axis label
legend1 = 'Robot';
legend2 = 'Under Mine';
legend3 = 'Upper mine';

title(plotTitle,'FontSize',15);
xlabel(xLabel,'FontSize',15);
ylabel(yLabel,'FontSize',15);
legend(legend1,legend2,legend3)
axis([yMin yMax min max]);
grid(plotGrid);

robot = plot(robpos(1,1),robpos(1,2),'dr' );  % every AnalogRead needs to be on its own Plotgraph
hold on                            %hold on makes sure all of the channels are plotted
uppermines = plot(Umines(U,1),Umines(U,2),'og');
lowermines = plot(Dmines(D,1),Dmines(D,2),'+b' );
%%

while ishandle(robot)%need to check if it works and faster than traditional(what if the robot got out by mistake !!!!!)

     yangle=str2double(recieved(1:3));%changing the values every loop
     zangle=str2double(recieved(4:6));
     encoder=str2double(reciveed(7:9));
     minestate=str2double(recieved(10));

         %This is the magic code 
         %Using plot will slow down the sampling time.. At times to over 20
         %seconds per sample!
%-----------------------------------------------------------------------------------------
%to-do  the logic that will make sence of the data
% some values (like encoder) may need pre processing
%plese declare the robot posetion as a vector (ex:robpos[2 1])/done

 robpos(1,1)=robpos(1,1)+ cos(zangle)*encoder * cos(yangle);
 robpos(1,2)=robpos(1,2)+ cos(zangle)*encoder * sin(yangle);

%--------all the next code needs modification because you didn't consider the orientation of the robot /(took into consedration) 
switch minestate
    
        case 1 % the mine is up and on the right
            
            Umines(U,1) = robpos(1,1) + coilpos(1,1);
            Umines(U,2) = robpos(1,2) - coilpos(1,2);
            U=U+1;
            
      % break;
        
        case 2 %  the mine is up and on the left
            
            Umines(U,1) = robpos(1,1) - coilpos(1,1);
            Umines(U,2) = robpos(1,1) - coilpos(1,2);
            U=U+1;
      %  break;
        
        case 3 % the mine is down and on the right
            
             Dmines(U,1) = robpos(1,1) + coilpos(1,1);
             Dmines(U,2) = robpos(1,1) - coilpos(1,2);
             U=U+1;
      % break;
        
        case 4 % the mine is down and on the left
            
             Dmines(U,1) = robpos(1,1) - coilpos(1,1);
             Dmines(U,2) = robpos(1,1) - coilpos(1,2);
             U=U+1;   
      % break;
end
%--------------------------------------------------------------


         set(robot,'XData',robpos(1,1),'YData',robpos(1,2));
         set(uppermines,'XData',Umines(U,1),'YData',Umines(U,2));
         set(lowermines,'XData',Dmines(U,1),'YData',Dmines(U,2));
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
          pause(delay);
end
delete(a);
disp('Plot Closed and arduino object has been deleted');

