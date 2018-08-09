
function finalarr=constfilter(Ugood,Dgood,Umines,Dmines,U,D)
%% final map
% this code floors all the dots position and put it in the down left node of
% this code 


finalarr=zeros(20,20)+45;
Dcolor = 1000;
Ucolor = 0;

Uminesquare=zeros(20,20);
Dminesquare=zeros(20,20);

for i=1:U
    flooredUmines(i,1)=floor(Umines(i,1)/100);
    flooredUmines(i,2)=floor(Umines(i,2)/100);
    if (flooredUmines(i,1)>=0) && (flooredUmines(i,1)<20)&&(flooredUmines(i,2)>=0) && (flooredUmines(i,2)<20)
        Uminesquare(flooredUmines(i,1)+1,flooredUmines(i,2)+1)=Uminesquare(flooredUmines(i,1)+1,flooredUmines(i,2)+1)+1;
    end
end

for i=1:D
    flooredDmines(i,1)=floor(Dmines(i,1)/100);
    flooredDmines(i,2)=floor(Dmines(i,2)/100);
    if (flooredDmines(i,1)>=0) && (flooredDmines(i,1)<20)&&(flooredDmines(i,2)>=0) && (flooredDmines(i,2)<20)
        Dminesquare(flooredDmines(i,1)+1,flooredDmines(i,2)+1)=Dminesquare(flooredDmines(i,1)+1,flooredDmines(i,2)+1)+1;
    end
end

save 2_minesPosFloored ;

% %% filtering and drwing map

for i=1:20
    for j=1:20
        if Dminesquare(i,j)>=Dgood 
            finalarr(i,j)= Dcolor;
        end
        
        if Uminesquare(i,j)>=Ugood
            finalarr(i,j)= Ucolor;
        end
    end
end
save finalminearray ;
grid on
im=image (transpose(finalarr));
set(gca,'YDir','normal');
yticks(1:20)
xticks(1:20)
saveas(im,'constfilterimage','png')
colorbar
end
