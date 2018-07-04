clear
clc
%User Defined Properties 
SerialPort='com6'; %serial port
s = serial(SerialPort);
set(s,'BaudRate',4800); % to be known from arduino
fopen(s);
plotTitle = 'Mine sweeper map';  % plot title
xLabel = 'X axcis';     % x-axis label
yLabel = 'Y axais';      % y-axis label
legend1 = 'Robot'
legend2 = 'Under Mine'
legend3 = 'Upper mine'
%%i cannot tell the difference
yMax  = 2000   ;                 %y Maximum Value (CM)
yMin  = 0       ;                %y minimum Value (CM)
plotGrid = 'on';                 % 'off' to turn off grid
min = 0;                         % set y-min (CM)
max = 2000;                      % set y-max (CM)
%%
delay = .01;      % make sure sample faster than resolution (connot understand what he means)
%Define Function Variables

time = 0;
data = 0;
data1 = 0;
data2 = 0;
count = 0;
recived =0;
%Set up Plot
plotGraph = plot(time,data,'-r' )  % every AnalogRead needs to be on its own Plotgraph
hold on                            %hold on makes sure all of the channels are plotted
plotGraph1 = plot(time,data1,'-b')
plotGraph2 = plot(time, data2,'-g' )

title(plotTitle,'FontSize',15);
xlabel(xLabel,'FontSize',15);
ylabel(yLabel,'FontSize',15);
legend(legend1,legend2,legend3)
axis([yMin yMax min max]);

grid(plotGrid);
tic

while ishandle(plotGraph) %Loop when Plot is Active will run until plot is closed (dont know the function use)
         
         recived=fscanf(s,'%s'); %%need to make sure that (%s) works correctly
         
         yangle=recieved(1:3);
         zangle=recieved(4:6);
         encoder=reciveed(7:9);
         minestate=recieved(10);
         
% dont know the importance of this chunk of code
%          dat = ; %Data from the arduino
%          dat1 = ; 
%          dat2 = ;       
%          count = count + 1;    
%          time(count) = toc;    
%          data(count) = dat(1);         
%          data1(count) = dat1(1)
%          data2(count) = dat2(1)

         %This is the magic code 
         %Using plot will slow down the sampling time.. At times to over 20
         %seconds per sample!
%----------------------------------------------------------------------
%to-do  the logic that will make sence of the data



%----------------------------------------------------------------------
         set(plotGraph,'XData',time,'YData',data);
         set(plotGraph1,'XData',time,'YData',data1);
         set(plotGraph2,'XData',time,'YData',data2);
          axis([0 time(count) min max]);
          %Update the graph
          pause(delay);
end
delete(a);
disp('Plot Closed and arduino object has been deleted');