 load ('1_minepositions');

Max  = 2500;                 %y Maximum Value (cm)
yMin  = -500;                %y minimum Value (cm)
min = -500;                         % set x-min (cm)
max = 2500;                      % set x-max (cm)


plotTitle = 'Mine sweeper map';  % plot title
xLabel = 'X axis';     % x-axis label
yLabel = 'Y axis';      % y-axis label
legend1 = 'Robot';
legend2 = 'Upper Mine';
legend3 = 'Under mine';

robot=plot(robpos(:,1),robpos(:,2),'-' );
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