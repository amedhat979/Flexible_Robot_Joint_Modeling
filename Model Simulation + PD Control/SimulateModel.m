% Parameters
K = 350;
m1 = 0.6;
m2 = 1.0;
%System Initial Conditions
x1_0 = 5;
x2_0 = 0;
x1Dot_0 = 0; 
x2Dot_0 = 0;
%Damping Ratio
zeta= 0.6;
%Controller Gains
Kp = 200;
Kd = 30;
%Desired Position
x_ref = 7;

    % Compute damping coefficients
    b1 = 2 * zeta * sqrt(K * m1);
    b2 = 2 * zeta * sqrt(K * m2);
    
    % Assign to base workspace
    assignin('base', 'K', K);
    assignin('base', 'm1', m1);
    assignin('base', 'm2', m2);
    assignin('base', 'b1', b1);
    assignin('base', 'b2', b2);
    
    % Run Simulink model
    simOut = sim('TaskSolution', 'ReturnWorkspaceOutputs', 'on');

    % Extract data
    t = simOut.get('tout'); 
    x1 = simOut.get('x1_out'); 
    x2 = simOut.get('x2_out');
    dx1 = simOut.get('x1Dot_out');
    dx2 = simOut.get('x2Dot_out');

% Plot x1
figure;
plot(t, x1, 'b', 'LineWidth', 1.5);
xlabel('Time [s]');
ylabel('x_1 [m]');
title('x_1 response');
grid on;

% Plot x2
figure;
plot(t, x2, 'r', 'LineWidth', 1.5);
xlabel('Time [s]');
ylabel('x_2 [m]');
title('x_2 response');
grid on;

% Evaluate statistics
[final_x1, overshoot_x1, settling_x1] = StatisticsFcn(x1, t);
[final_x2, overshoot_x2, settling_x2] = StatisticsFcn(x2, t);

% Display table
T = table(zeta, final_x1, overshoot_x1, settling_x1, ...
               final_x2, overshoot_x2, settling_x2, ...
    'VariableNames', {'Zeta', 'FinalValue_x1', 'Undershoot_x1', 'SettlingTime_x1', ...
                      'FinalValue_x2', 'Overshoot_x2', 'SettlingTime_x2'});

disp(T);