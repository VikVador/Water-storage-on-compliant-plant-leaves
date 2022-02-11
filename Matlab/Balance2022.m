tic

COM = 'COM4';
s = serialport(COM, 9600, 'Parity', 'None',...
               'DataBits', 8, 'FlowControl',...
               'none', 'StopBits', 1, 'Timeout', 6);

for i = 1:25
           
    k = 1;
    while k == 1 || strlength(readline(s)) < 7
        r = readline(s);
        k = k + 1;
    end

    K(i) = k;
    R(i) = r;

end

flush(s)
clear s

toc