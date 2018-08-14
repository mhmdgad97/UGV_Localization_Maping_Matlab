global Umines
global Dmines
global U
global D
global flooredUmines
global flooredDmines

clear all
clc
%%User Defined Properties

baudrate=115200;
SerialPort='com8'; %serial port

try
    fclose(instrfind);
    delete(instrfind);
    s = serial(SerialPort);
    set(s,'BaudRate',baudrate); % to be known from arduino
    fopen(s);
catch
    s = serial(SerialPort);
    set(s,'BaudRate',baudrate); % to be known from arduino
    fopen(s);
end
%%
%postion defined variables(get more specific info from 3agmy)

coilpos=[50 0];%the absolute postion of the coil relative to the centre of the robot
robpos=[0 0];% robot inetial postion

coildist=50;

L = (coilpos(1,1)^2 + coilpos(1,2)^2 )^.5;
phi=-atand(coilpos(1,1)/coilpos(1,2)) ;
% testvector=zeros(1000000,10);

encoderfactor=1.02774922918808*(2*pi*8)/800 ;

Umines=zeros(100000,2);%pre allocation
U=1;% upper mine index
Dmines=zeros(100000,2);%pre allocation
D=1;%down mine index

flooredUmines=zeros(100000,2);%pre allocation
fU=1;% upper mine index
flooredDmines=zeros(100000,2);%pre allocation
fD=1;%down mine index

%% filtering variables

finalarr=zeros(20,20)+45;

Dcolor = 1000;
Ucolor = 0;
%%

rob=zeros(100000,2);%pre allocation
allminestates=zeros(100000,1);%pre allocation

rob(1,1)=robpos(1,1);
rob(1,2)=robpos(1,2);
robi=1;%robot postion index

rawdata=zeros(100000,8);
rawi=1;
%% plot variables and functions
% the dimension of the map 20m by 20m
yMax  = 2500;                 %y Maximum Value (cm)
yMin  = -500;                %y minimum Value (cm)
min = -500;                         % set x-min (cm)
max = 2500;                      % set x-max (cm)


plotTitle = 'Mine sweeper map';  % plot title
xLabel = 'X axis';     % x-axis label
yLabel = 'Y axis';      % y-axis label
legend1 = 'Robot';
legend2 = 'Upper Mine';
legend3 = 'Under mine';

robot=plot(rob(:,1),rob(:,2),'-' );
hold on;
uppermines = scatter(Umines(:,1),Umines(:,2),'og');
lowermines = scatter(Dmines(:,1),Dmines(:,2),'+r' );

title(plotTitle,'FontSize',15);
xlabel(xLabel,'FontSize',15);
ylabel(yLabel,'FontSize',15);
legend(legend1,legend2,legend3)
axis([yMin yMax min max]);
yticks(yMin:100:yMax)
xticks(min:100:max)
grid('on');

drawnow
%%

while ishandle(robot)%need to check if it works and faster than traditional(what if the robot got out by mistake !!!!!)
    
    try
        recieved=fscanf(s);
        if (recieved=='0') %|| (recieved== 0)
            recieved='20000000';
%             rawdata(rawi)=recieved;
            rawi=rawi+1;
        else
            
%             rawdata(rawi,:)=recieved;
%             rawi=rawi+1;
            disp (recieved);
            yangle=str2double(recieved(5:7));%the angle is between the y axis and the robot front direction
            sign=str2double(recieved(1));
            encoder=str2double(recieved(2:4))*((-1)^sign)*encoderfactor ;
            minestate=str2double(recieved(8));
        end
        %zangle=str2double(recieved(4:6));
    catch
        
        recieved='20000000';
        
%         rawdata(rawi,:)=recieved;%raw data
%         rawi=rawi+1;
        
        disp (recieved);
        yangle=str2double(recieved(5:7));%the angle is between the y axis and the robot front direction
        sign=str2double(recieved(1));
        encoder=str2double(recieved(2:4))*((-1)^sign)*encoderfactor ;
        minestate=str2double(recieved(8));
    end
    %-----------------------------------------------------------------------------------------
    
    
    robpos(robi+1,1)=robpos(robi,1)+ encoder * sind(yangle) ;
    robpos(robi+1,2)=robpos(robi,2)+ encoder * cosd(yangle) ;
    robi=robi+1;
   
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
    
    drawnow limitrate
end

% end

try
    delete(s);
    fclose(instrfind);
    delete(instrfind);
catch
end

disp('Plot Closed and arduino object has been deleted');
finalarr=constfilter(5,5,Umines(:,:),Dmines(:,:),U,D);
[Ufiltered,Dfiltered]=freqfilter(5,5,Umines(:,:),Dmines(:,:),U,D);
save 1_minepositions;