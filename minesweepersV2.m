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
robpos=[0 0];% robot inetial postion

 face=[0 50];
 facedist = 50;

L = (coilpos(1,1)^2 + coilpos(1,2)^2 )^.5;
phi=-atand(coilpos(1,1)/coilpos(1,2)) ;

Umines=zeros(60000,2);%pre allocation
U=1;% upper mine index
Dmines=zeros(60000,2);%pre allocation
D=1;%down mine index

rob=zeros(100000,2);%pre allocation
robi=1;%down mine index

encoderratio=1; %value vor tuning the reading sent by encoder

%% plot variables and functions
% RESPONSIBLE FOR THE DOMAIN OF PLOT
% the dimension of the map 20m by 20m
yMax  = 2100;                 %y Maximum Value (cm)
yMin  = -300;                %y minimum Value (cm)
min = -300;                         % set x-min (cm)
max = 2100;                      % set x-max (cm)


plotTitle = 'Mine sweeper map';  % plot title
xLabel = 'X axis';     % x-axis label
yLabel = 'Y axis';      % y-axis label
legend1 = 'Robot';
legend2 = 'Upper Mine';
legend3 = 'Under mine';
legend4 = 'orientation';
robot=plot(rob(:,1),rob(:,2),'-' );
hold on;
facepoint = scatter(face(1,1),face(1,2),'^b');% to know where exactly the robot is facing
uppermines = scatter(Umines(:,1),Umines(:,2),'og');
lowermines = scatter(Dmines(:,1),Dmines(:,2),'+r' );
% robot=scatter(rob(:,1),rob(:,2),'ob' );



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
    
    
    yangle=str2double(recieved(1:3));%the angle is between the y axis and the robot front direction
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
    
    robpos(robi+1,1)=robpos(robi,1)+ encoder * sind(yangle)*encoderratio * cosd(zangle);
    robpos(robi+1,2)=robpos(robi,2)+ encoder * cosd(yangle)*encoderratio * cosd(zangle);
    robi=robi+1;
    
    face(1,1)= 2*robpos(robi,1) - robpos(robi-1,1);
    face(1,2)= 2*robpos(robi,2) - robpos(robi-1,2);
    
    switch minestate
        case 0 % no mines at all
            
        case 1 % the mine is down and on the left
            
            Dmines(D,1) = robpos(robi,1) - L * cosd( 90 - phi - yangle );
            Dmines(D,2) = robpos(robi,2) - L * sind( 90 - phi - yangle );
            D=D+1;
            
            % break;
            
        case 2 %  the mine is up and on the left
            
            Umines(U,1) = robpos(robi,1) - L * cosd( 90 - phi - yangle );
            Umines(U,2) = robpos(robi,2) - L * sind( 90 - phi - yangle );
            U=U+1;
            %  break;
            
        case 3 % the mine is down and on the right
            
            Dmines(D,1) = robpos(robi,1) + L * cosd( 90 - phi + yangle );
            Dmines(D,2) = robpos(robi,2) - L * sind( 90 - phi + yangle );
            D=D+1;
            
            % break;
            
        case 4 %  two mines down
            
            Dmines(D,1) = robpos(robi,1) - L * cosd( 90 - phi - yangle );
            Dmines(D,2) = robpos(robi,2) - L * sind( 90 - phi - yangle );
            D=D+1;
            
            Dmines(D,1) = robpos(robi,1) + L * cosd( 90 - phi + yangle );
            Dmines(D,2) = robpos(robi,2) - L * sind( 90 - phi + yangle );
            D=D+1;
            
            
            %  break;
            
             case 5 %  upper mine left and under mine right
            
            Dmines(D,1) = robpos(robi,1) + L * cosd( 90 - phi + yangle );
            Dmines(D,2) = robpos(robi,2) - L * sind( 90 - phi + yangle );
            D=D+1;
            
            Umines(U,1) = robpos(robi,1) - L * cosd( 90 - phi - yangle );
            Umines(U,2) = robpos(robi,2) - L * sind( 90 - phi - yangle );
            U=U+1;
            
            %  break;
            
        case 6 % the mine is up and on the right
            
            Umines(U,1) = robpos(robi,1) + L * cosd( 90 - phi + yangle );
            Umines(U,2) = robpos(robi,2) - L * sind( 90 - phi + yangle );
            U=U+1;
            
            % break;
            
        case 7 %  upper mine right and under mine left
            
            Umines(U,1) = robpos(robi,1) + L * cosd( 90 - phi + yangle );
            Umines(U,2) = robpos(robi,2) - L * sind( 90 - phi + yangle );
            U=U+1;
            
            Dmines(D,1) = robpos(robi,1) - L * cosd( 90 - phi - yangle );
            Dmines(D,2) = robpos(robi,2) - L * sind( 90 - phi - yangle );
            D=D+1;
            
            %  break;
            
        case 8 % two mines up
            
            Umines(U,1) = robpos(robi,1) - L * cosd( 90 - phi - yangle );
            Umines(U,2) = robpos(robi,2) - L * sind( 90 - phi - yangle );
            U=U+1;
            
            Umines(U,1) = robpos(robi,1) + L * cosd( 90 - phi + yangle );
            Umines(U,2) = robpos(robi,2) - L * sind( 90 - phi + yangle );
            U=U+1;
            %  break;
    end
    %--------------------------------------------------------------
    
    set(uppermines,'XData',Umines(:,1),'YData',Umines(:,2));
    set(lowermines,'XData',Dmines(:,1),'YData',Dmines(:,2));
    set(robot,'XData',robpos(:,1),'YData',robpos(:,2));
     set(facepoint,'XData',face(1,1),'YData',face(1,2));
    drawnow limitrate
   
    %refreshdata(uppermines);
    %refreshdata(lowermines);
    
end
delete(s);
disp('Plot Closed and arduino object has been deleted');

%% final map
%this code floors all the dots position and put it in the down left node of
%each square 


Uminesquare=zeros(20,20);
Dminesquare=zeros(20,20);

for i=0:6000
Umines(i,1)=floor(Umines(i,1));
Umines(i,2)=floor(Umines(i,2));
Dmines(i,1)=floor(Dmines(i,1));
Dmines(i,2)=floor(Dmines(i,2));


    Uminesquare(Umines(i,1),Umines(i,2))=Uminesquare(Umines(i,1),Umines(i,2))+1;
    Dminesquare(Dmines(i,1),Dmines(i,2))=Dminesquare(Dmines(i,1),Dmines(i,2))+1;
end
