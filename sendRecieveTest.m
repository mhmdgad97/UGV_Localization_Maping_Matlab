clear all
clc
% fclose(instrfind);
% delete(instrfind);
%User Defined Properties
SerialPort='com10'; %serial port
s = serial(SerialPort);
set(s,'BaudRate',9600); % to be known from arduino
fopen(s);
while 1
a = fscanf(s); 
disp (a);
end
fclose(instrfind);
delete(instrfind);