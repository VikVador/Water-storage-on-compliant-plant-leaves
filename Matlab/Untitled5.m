% Loading the data

Data = readtable("../Experiments/Initial/Data/Experiment_1.txt");
mass = Data(:,2);
mass = string(mass{:,1});
mass = erase(mass,'?');
mass = str2double(mass);

time = Data(:,1);
time = double(time{:,1});


tab = table(time, mass, 'VariableNames', {'Time [s]', 'Mass [g]'});
writetable(tab, "../Experiments/Initial/Data/Experiment_1_1.txt");