clear all
clc
%User Defined Properties
try
    fclose(instrfind);
    delete(instrfind);
    SerialPort='com8'; %serial port
    s = serial(SerialPort);
    set(s,'BaudRate',115200); % to be known from arduino
    fopen(s);
catch
    SerialPort='com8'; %serial port
    s = serial(SerialPort);
    set(s,'BaudRate',115200); % to be known from arduino
    fopen(s);
end
%%
%postion defined variables(get more specific info from 3agmy)
coilpos=[50 0];%the absolute postion of the coil relative to the centre of the robot
robpos=[1 1];% robot inetial postion

%  face=[0 50];
%  facedist = 50;
 coildist=50;

L = (coilpos(1,1)^2 + coilpos(1,2)^2 )^.5;
phi=-atand(coilpos(1,1)/coilpos(1,2)) ;
% testvector=zeros(1000000,10);

Umines=zeros(100000,2);%pre allocation
U=1;% upper mine index
Dmines=zeros(100000,2);%pre allocation
D=1;%down mine index

rob=zeros(100000,2);%pre allocation
rob(1,1)=robpos(1,1);
rob(1,2)=robpos(1,2);
robi=2;%down mine index


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
% facepoint = scatter(face(1,1),face(1,2),'^b');% to know where exactly the robot is facing
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
% tvi=1;

while ishandle(robot)%need to check if it works and faster than traditional(what if the robot got out by mistake !!!!!)

value = double(get(gcf,'CurrentCharacter'));
if (value==96) % the code wll run smoothly if the reset button wasn't pushed
    try
    % the reset code (this should be needed if we want to make adjust the feld of the robot in the fled by force)
    robi=input('enter the overriding index for robot: ');
    D=input('enter the overriding index for Umines: ');
    U=input('enter the overriding index for Dmines: ');
    robpos(robi,1)= input('enter robot xpos : ');
    robpos(robi,2)= input('enter robot ypos : ');
    set(gcf,'currentch','3');
    catch 
    end
else
    try
    recieved=fscanf(s);
    disp (recieved);
    yangle=str2double(recieved(5:7));%the angle is between the y axis and the robot front direction
    sign=str2double(recieved(1));
    encoder=str2double(recieved(2:4))*((-1)^sign)*(2*pi*8)/800 ;
    minestate=str2double(recieved(8));
    
    %zangle=str2double(recieved(4:6));
    catch
        
    recieved='00000000';
    disp (recieved);
    yangle=str2double(recieved(5:7));%the angle is between the y axis and the robot front direction
    sign=str2double(recieved(1));
    encoder=str2double(recieved(2:4))*((-1)^sign)*(2*pi*8)/800 ;
    minestate=str2double(recieved(8));
    end
%     testvector(tvi,:)=recieved;
%     tvi=tvi+1;
    
    %-----------------------------------------------------------------------------------------
   
    
    robpos(robi+1,1)=robpos(robi,1)+ encoder * sind(yangle) ;%* cosd(zangle);
    robpos(robi+1,2)=robpos(robi,2)+ encoder * cosd(yangle) ;%* cosd(zangle);
    robi=robi+1;
    
%     face(1,1)= robpos(robi,1) - facedist*sind(yangle);
%     face(1,2)= robpos(robi,2) + facedist*cosd(yangle);
    
    switch minestate
        case 0 % no mines at all
            
        case 1 % the mine is down and on the left
            
            Dmines(D,1) = robpos(robi,1) + L * cosd( 90 - phi + yangle );
            Dmines(D,2) = robpos(robi,2) - L * sind( 90 - phi + yangle );
            D=D+1;
            
            % break;
            
        case 2 %  the mine is up and on the left
            Umines(U,1) = robpos(robi,1) + L * cosd( 90 - phi + yangle );
            Umines(U,2) = robpos(robi,2) - L * sind( 90 - phi + yangle );
            U=U+1;
            %  break;
            
        case 3 % the mine is down and on the right
            
            Dmines(D,1) = robpos(robi,1) - L * cosd( 90 - phi + yangle );
            Dmines(D,2) = robpos(robi,2) + L * sind( 90 - phi + yangle );
            D=D+1;
            
            % break;
            
        case 4 %  two mines down
            
            Dmines(D,1) = robpos(robi,1) - L * cosd( 90 - phi + yangle );
            Dmines(D,2) = robpos(robi,2) + L * sind( 90 - phi + yangle );
            D=D+1;
            
            Dmines(D,1) = robpos(robi,1) + L * cosd( 90 - phi + yangle );
            Dmines(D,2) = robpos(robi,2) - L * sind( 90 - phi + yangle );
            D=D+1;
            
            
            %  break;
            
             case 5 %  upper mine left and under mine right
            
            Dmines(D,1) = robpos(robi,1) - L * cosd( 90 - phi + yangle );
            Dmines(D,2) = robpos(robi,2) + L * sind( 90 - phi + yangle );
            D=D+1;
            
            Umines(U,1) = robpos(robi,1) + L * cosd( 90 - phi + yangle );
            Umines(U,2) = robpos(robi,2) - L * sind( 90 - phi + yangle );
            U=U+1;
            
            %  break;
            
        case 6 % the mine is up and on the right
            
            Umines(U,1) = robpos(robi,1) - L * cosd( 90 - phi + yangle );
            Umines(U,2) = robpos(robi,2) + L * sind( 90 - phi + yangle );
            U=U+1;
            
            % break;
            
        case 7 %  upper mine right and under mine left
            
            Umines(U,1) = robpos(robi,1) - L * cosd( 90 - phi + yangle );
            Umines(U,2) = robpos(robi,2) + L * sind( 90 - phi + yangle );
            U=U+1;
            
            Dmines(D,1) = robpos(robi,1) + L * cosd( 90 - phi + yangle );
            Dmines(D,2) = robpos(robi,2) - L * sind( 90 - phi + yangle );
            D=D+1;
            
            %  break;
            
        case 8 % two mines up
            
            Umines(U,1) = robpos(robi,1) - L * cosd( 90 - phi + yangle );
            Umines(U,2) = robpos(robi,2) + L * sind( 90 - phi + yangle );
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
%     set(facepoint,'XData',face(1,1),'YData',face(1,2));
    drawnow limitrate
   
    %refreshdata(uppermines);
    %refreshdata(lowermines);

end
end
delete(s);
try
    fclose(instrfind);
    delete(instrfind);
catch 
end
disp('Plot Closed and arduino object has been deleted');
save testvectorreadings;
% %% final map
% this code floors all the dots position and put it in the down left node of
% %each square 
% 
% Uminesquare=zeros(20,20);
% Dminesquare=zeros(20,20);
% 
% for i=0:6000
% Umines(i,1)=floor(Umines(i,1)/100);
% Umines(i,2)=floor(Umines(i,2)/100);
% Dmines(i,1)=floor(Dmines(i,1)/100);
% Dmines(i,2)=floor(Dmines(i,2)/100);
% 
% 
% Uminesquare(Umines(i,1),Umines(i,2))=Uminesquare(Umines(i,1),Umines(i,2))+1;
% Dminesquare(Dmines(i,1),Dmines(i,2))=Dminesquare(Dmines(i,1),Dmines(i,2))+1;
% end
% 
% %% filtering and drwing map
% finalarr=zeros(20,20);
% Dgood=50;%%to be determined by testing
% Ugood=50;%%to be determined by testing
% for i=1:20
%     for j=1:20
%         if Dminesquare(i,j)>Dgood
%             finalarr(i,j)= 1;
%         end
%         
%         if Uminesquare(i,j)>Ugood
%             finalarr(i,j)= 2;
%         end
%     end
% end
% save minearray finalarr;
% grid on
% image (finalarr);
% colorbar