c=45*ones(20,20);
U=0;
D=1000;

for i=1:20
    for j=1:20
        x=randi(3);
        
        switch x
            case 1
            result=U;
            case 2
            result=D;
            case 3
            result=45;
        end
        
        c(i,j)=result;
    end
end
grid on
image(c)
colorbar
