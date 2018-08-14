clear all
clc
% fclose(instrfind);
% delete(instrfind);
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

while 1
a = fscanf(s); 
disp (a);
end

