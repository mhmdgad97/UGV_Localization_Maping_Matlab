
function [Ufiltered,Dfiltered]=freqfilter(Ugood,Dgood,Umines,Dmines,U,D)
%% final map
% this code floors all the dots position and put it in the down left node of
% %each square
% this filter draws a mine if a number of (ugood) was detected in the same
% exact postion

Ufiltered=zeros(1000,2);
Dfiltered=zeros(1000,2);

Ui=1;
Di=1;

Uflag=0;
Dflag=0;
%% filtering and drwing map

for i=1:(U-4)
        if Umines(i,:)==Umines(i+1,:)
            Uflag=Uflag+1;
        else 
            Uflag=0;
        end
        
        if Uflag==Ugood
            Ufiltered(Ui,:) = Umines(i,:);
            Ui=Ui+1;
            Uflag=Uflag-1;
        end
end

for i=1:(D-4)
        if Dmines(i,:)==Dmines(i+1,:)
            Dflag=Dflag+1;
        else 
            Dflag=0;
        end
        
        if Dflag==Dgood
            Dfiltered(Di,:) = Dmines(i,:);
            Di=Di+1;
            Dflag=Dflag-1;
        end
end

yMax  = 2500;                 %y Maximum Value (cm)
yMin  = -500;                %y minimum Value (cm)
min = -500;                         % set x-min (cm)
max = 2500;                      % set x-max (cm)


plotTitle = 'Mine sweepers filtered map';  % plot title
xLabel = 'X axis';     % x-axis label
yLabel = 'Y axis';      % y-axis label
legend1 = 'Robot';
legend2 = 'Upper Mine';
legend3 = 'Under mine';

figure(); 

umine=plot(Ufiltered(:,1),Ufiltered(:,2),'og' );
hold on;
dmine = scatter(Dfiltered(:,1),Dfiltered(:,2),'+r' );

saveas(umine,'uppermines','png'); 
saveas(umine,'upperminesfigure','fig');

saveas(dmine,'downmines','png'); 
saveas(dmine,'downminesfigure','fig');

title(plotTitle,'FontSize',15);
xlabel(xLabel,'FontSize',15);
ylabel(yLabel,'FontSize',15);
axis([yMin yMax min max]);
yticks(yMin:100:yMax)
xticks(min:100:max)
grid('on');

end
