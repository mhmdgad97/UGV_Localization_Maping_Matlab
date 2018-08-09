% final map
% this code floors all the dots position and put it in the down left node of
% %each square 
% 
clear 
clc

a = 0;
b = 2000;

U=1000;
D=1000;

Umines=(b-a).*rand(U,2) + a;
Dmines=(b-a).*rand(D,2) + a;
 
Uminesquare=zeros(21,21);
Dminesquare=zeros(21,21);
 
for i=1:U
Umines(i,1)=floor(Umines(i,1)/100);
Umines(i,2)=floor(Umines(i,2)/100);
Uminesquare(Umines(i,1)+1,Umines(i,2)+1)=Uminesquare(Umines(i,1)+1,Umines(i,2)+1)+1;
end

for i=1:D
Dmines(i,1)=floor(Dmines(i,1)/100);
Dmines(i,2)=floor(Dmines(i,2)/100);
Dminesquare(Dmines(i,1)+1,Dmines(i,2)+1)=Dminesquare(Dmines(i,1)+1,Dmines(i,2)+1)+1;
end
% 
% %% filtering and drawing map
 finalarr=zeros(20,20)+45;
 Dgood=0;%%to be determined by testing
 Ugood=0;%%to be determined by testing 
 
 Dcolor = 1000;
 Ucolor = 0;
 
 for i=1:20
     for j=1:20
        if Dminesquare(i,j)>Dgood
            finalarr(i,j)= Dcolor;
        end
        
        if Uminesquare(i,j)>Ugood
            finalarr(i,j)= Ucolor;
        end
    end
end
save minearray finalarr;
grid on
im=image (finalarr);
yticks(1:20)
xticks(1:20)
set(gca,'YDir','normal');

saveas(im,'finalarr','png')
colorbar