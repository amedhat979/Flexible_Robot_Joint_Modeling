% Parameters
K = 350;
m1 = 0.6;
m2 = 1.0;
%System Initial Conditions
x1_0 = 5;
x2_0 = 0;
x1Dot_0 = 0; 
x2Dot_0 = 0;

zeta_list = [0.2, 0.4, 0.6, 0.8, 1];
results_x1 = {};
results_x2 = {};
time_vec = [];

for i = 1:length(zeta_list)
    zeta = zeta_list(i);
    
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

    % Energy Plausibility check (only for Zeta = 0.6 Case)
    if abs(zeta - 0.6) < 1e-3
        KE = 0.5 * m1 * dx1.^2 + 0.5 * m2 * dx2.^2;
        PE = 0.5 * K * (x2 - x1).^2;
        E_total = KE + PE;

        figure;
        plot(t, KE, '-', 'LineWidth', 1.2); hold on;
        plot(t, PE, '-', 'LineWidth', 1.2);
        plot(t, E_total, '--', 'LineWidth', 1.5);
        xlabel('Time [s]'); ylabel('Energy [J]');
        legend('Kinetic Energy', 'Potential Energy', 'Total Energy');
        title('Energy Dissipation Check');
        grid on;
    end

    % Evaluate statistics for x1
    [final1, overshoot1, settle1] = StatisticsFcn(x1, t);

    % Evaluate statistics for x2
    [final2, overshoot2, settle2] = StatisticsFcn(x2, t);

    % Store in result arrays
    final_x1(i) = final1;
    overshoot_x1(i) = overshoot1;
    settling_x1(i) = settle1;

    final_x2(i) = final2;
    overshoot_x2(i) = overshoot2;
    settling_x2(i) = settle2;

    % Save results
    results_x1{i} = x1;
    results_x2{i} = x2;
    if isempty(time_vec)
        time_vec = t;
    end
end

% === Plot All x1 ===
figure;
hold on;
for i = 1:length(zeta_list)
    plot(time_vec, results_x1{i}, 'DisplayName', ['\zeta = ' num2str(zeta_list(i))]);
end
xlabel('Time [s]'); ylabel('x_1 [m]');
title('x_1 response for different \zeta');
legend show; grid on;

% === Plot All x2 ===
figure;
hold on;
for i = 1:length(zeta_list)
    plot(time_vec, results_x2{i}, 'DisplayName', ['\zeta = ' num2str(zeta_list(i))]);
end
xlabel('Time [s]'); ylabel('x_2 [m]');
title('x_2 response for different \zeta');
legend show; grid on;

% Print Statistics 
T_x1 = table(zeta_list(:), final_x1(:), overshoot_x1(:), settling_x1(:), ...
    'VariableNames', {'Zeta', 'FinalValue_x1', 'Undershoot_x1', 'SettlingTime_x1'});

T_x2 = table(zeta_list(:), final_x2(:), overshoot_x2(:), settling_x2(:), ...
    'VariableNames', {'Zeta', 'FinalValue_x2', 'Overshoot_x2', 'SettlingTime_x2'});

T_all = [T_x1(:,1), T_x1(:,2:end), T_x2(:,2:end)];

% Display
disp('x1 and x2 Statistics for different Zeta Values');
disp(T_all);
