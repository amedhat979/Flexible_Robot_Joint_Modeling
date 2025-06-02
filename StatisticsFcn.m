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

    % Settling time (within 2% band) ---
    tolerance = 0.02;
    band_upper = final_val * (1 + tolerance);
    band_lower = final_val * (1 - tolerance);

    idx_settled = find(signal > band_lower & signal < band_upper);
    if ~isempty(idx_settled)
        % Last time it entered the settling band continuously
        diffs = diff(idx_settled);
        gap_idx = find(diffs > 1, 1, 'last');
        if isempty(gap_idx)
            settling_time = t(idx_settled(end));
        else
            settling_time = t(idx_settled(gap_idx + 1));
        end
    else
        settling_time = NaN;
    end
end