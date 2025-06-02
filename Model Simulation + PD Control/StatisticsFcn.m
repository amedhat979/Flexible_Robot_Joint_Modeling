%Function to compute Settling time, Overshoot, and final settling val

function [final_val, overshoot, settling_time] = StatisticsFcn(signal, t)
%Overshoot Calculation
    final_val = signal(end);
    min_val = min(signal);
    peak_val = max(signal);
    initial_val = signal(1);
    
         if initial_val == 0
            overshoot = (peak_val - final_val) / abs(final_val) * 100;
             elseif min_val < final_val
                 overshoot = (final_val - min_val) / abs(final_val) * 100;
         end

    % Settling time (within 2% band)
    tolerance = 0.02;
    band_upper = final_val * (1 + tolerance);
    band_lower = final_val * (1 - tolerance);

    in_band = (signal > band_lower) & (signal < band_upper);

    % Find the first time from which it stays inside band
    window = 50;  % number of consecutive points to define "stays within"
    for i = 1:(length(in_band) - window)
        if all(in_band(i:end))
            settling_time = t(i);
            return;
        end
    end

end
