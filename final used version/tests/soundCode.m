
amp=10 ;
fs=20500;  % sampling frequency
duration=2/10;
freq=1000;
values=0:1/fs:duration;
a=amp*sin(2*pi* freq*values);
sound(a)