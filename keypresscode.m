while 1
    w = waitforbuttonpress;
value = double(get(gcf,'CurrentCharacter'))
    if w == 0
        disp('Button click')
    else
        disp('Key press')
    end
end