tic

clear;
COM = "COM6";



for i = 1:200
s = serialport(COM, 9600, 'Parity', 'None',...
   'DataBits', 8, 'FlowControl',...
   'none', 'StopBits', 1, 'Timeout', 6);    
    k = 1;
    while k == 1 || strlength(readline(s)) < 7
        r = readline(s)
        k = k + 1;
    end
    pause(1);
    [c, f] = clock;
    
    sec(i) = c(6);
    min(i) = c(5);
    hour(i) = c(4);
     
    time(i) = 3600 * hour(i) + 60 * min(i) + sec(i);
    
    K(i) = k;
    R(i) = r;

    clear s
end
time = time - ones(1,length(time))*time(1);
%flush(s)
%clear s

toc