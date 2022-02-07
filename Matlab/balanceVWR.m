% function balanceVWR(obj)

% Check that balance "PC-Prtr" mode is set to "PC Cont" ! Press the Menu 
% button until the alarm sound goes off, then use Menu and  Cal buttons to
% select the adequate submenu and Print to select. To quit the menu, go to
% End at the end of the list. A priori the "PC-Prtr" mode does not change
% its state once the balance is turned off.

% If an error appears when the script is first launched saying that 'COM12'
% is not available but that port 'COMXX' is, change the port number here
% below (l. 15)

warning('off', 'all');

s = 'COM3';                                                                 % check which COM port number is available by typing "instrfind" in the command window
if isa(s, 'serial')
    obj.interface = s;
elseif isa(s, 'char')
    obj.interface = serial(s);
else
    error('You need to specify a serial interface (char ou serial)');
end

obj.interface.BaudRate = 9600;                                              % if problem, check that all values are the same on the balance side
obj.interface.DataBits = 8;
obj.interface.Parity = 'none';
obj.interface.FlowControl = 'none';
obj.interface.StopBits = 0;
obj.interface.Terminator = 'LT';
obj.interface.InputBufferSize = 1000;
obj.interface.Timeout = 10;

try
if (strcmp(obj.interface.Status, 'closed'))
	fopen(obj.interface);                                                   % open the interface
end
if (obj.interface.BytesAvailable)
	fread(obj.interface, obj.interface.BytesAvailable);                     % flush the serial port
end


disp('Initialisation ok');
catch                                                                       % if something wrong, the communication could not be established
    l = lasterror;
    delete(obj.interface);                                                  % delete the serial port open
    error(l.message);                                                       % rethrow error
    disp('Initialisation NOT ok')
end
fclose(obj.interface);

return

pause(2);


%% UI control box for plotting the graph

bg = uibuttongroup('Visible','off',...
                  'Position',[0 0 .1 1],...
                  'SelectionChangedFcn',@bselection);
              
% Create three radio buttons in the button group.
r1 = uicontrol(bg,'Style',...
                  'radiobutton',...
                  'String','Zero ',...                                      % Strings must have the same length so do not remove the space after "Zero " !!!
                  'Position',[10 300 100 30],...
                  'HandleVisibility','off');
              
r2 = uicontrol(bg,'Style','radiobutton',...
                  'String','Stop ',...
                  'Position',[10 175 100 30],...
                  'HandleVisibility','off');

r3 = uicontrol(bg,'Style','radiobutton',...
                  'String','Start',...
                  'Position',[10 50 100 30],...
                  'HandleVisibility','off');
              
% Make the uibuttongroup visible after creating child objects. 
bg.Visible = 'on';

time_start = now;
time_file =  datestr(now,'mmmm dd yyyy HH-MM-SS');
filename = char(strcat('Biomim', {' '}, time_file, '.xlsx'));

xlswrite(filename, {'Time (s)', 'Mass (g)'}, 'sheet1', 'A1:B1');

i = 1;
k = 1;

return

    function bselection(source,event)
%        disp(['Previous: ' event.OldValue.String]);                        % dummy test to check if menu box is working or not
%        disp(['Current: ' event.NewValue.String]);
%        disp('------------------');

       while k == 1
           if event.NewValue.String == 'Start'
                fopen(obj.interface);                                       % fopen and fclose the output everytime or phase lag :( 
                pause(0.05);
                out = fscanf(obj.interface);
                    while length(out) ~= 15
                        pause(0.1);                                         % to make sure fopen works correctly 
                        out = fscanf(obj.interface);
                    end
                poids = str2double(out(1:10));                              % always coded on  15 first bits if reading was complete
                
                if i == 1
                    y(i, :) = [(now - time_start)*24*60*60, poids];
                    Y(i, :) = [0, poids];
                else
                    y(i, :) = [(now - time_start)*24*60*60, poids];
                    Y(i, :) = [(y(i, 1) - y(1, 1)), poids];
                end
                
                plot(Y(i, 1), Y(i, 2), '-o', 'color', 'k');
                hold on 
                xlabel('Time (s)')
                ylabel('Mass (g)');
                
                fclose(obj.interface);                                      % if not close must restart Matlab
                               
                xlRange = strcat('A', num2str(i + 1), ':B', num2str(i + 1));
                xlswrite(filename, [Y(i, 1), Y(i, 2)], 'sheet1', xlRange);
                                
                i = i + 1;
           elseif event.NewValue.String == 'Stop '
               k = 2;
               break;
           end
       end
       
       if event.NewValue.String == 'Zero '                                  % need to reinitialize to keep taking measurements ; measurements as function of current time
           k = 1;
       end
    end
% end