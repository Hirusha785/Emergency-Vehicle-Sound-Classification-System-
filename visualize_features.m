function visualize_features(thresh)
    % Load data
    load('features_train.mat');
    load('scripts/filters.mat');
    
    % Create main figure
    fig1 = figure('Name', 'Feature Analysis', 'Position', [100 100 1000 800], 'NumberTitle', 'off');
    
    % 1. Feature Scatter Plot
    subplot(3,1,1);
    hold on;
    scatter(featuresTrain(labelsTrain=='ambulance',6),...
            featuresTrain(labelsTrain=='ambulance',3), 'bo');
    scatter(featuresTrain(labelsTrain=='firetruck',6),...
            featuresTrain(labelsTrain=='firetruck',3), 'rx');
    xline(thresh, '--k', 'Threshold', 'LineWidth', 1.5);
    xlabel('Energy Ratio (E_{amb}/E_{fire})');
    ylabel('Zero Crossing Rate');
    legend('Ambulance','Firetruck','Location','best');
    grid on;
    title('Feature Distribution');
    
    % 2. Magnitude Response
    subplot(3,1,2);
    [h_amb, w] = freqz(b_amb, a_amb, 2048, fs);
    [h_fire, ~] = freqz(b_fire, a_fire, 2048, fs);
    plot(w, 20*log10(abs(h_amb)), 'b', w, 20*log10(abs(h_fire)), 'r', 'LineWidth', 1.5);
    xlabel('Frequency (Hz)');
    ylabel('Magnitude (dB)');
    legend('Ambulance','Firetruck');
    grid on;
    title('Magnitude Response');
    xlim([0 fs/2]);
    
    % 3. Phase Response
    subplot(3,1,3);
    [phi_amb, w] = phasez(b_amb, a_amb, 2048, fs);
    [phi_fire, ~] = phasez(b_fire, a_fire, 2048, fs);
    plot(w, phi_amb, 'b', w, phi_fire, 'r', 'LineWidth', 1.5);
    xlabel('Frequency (Hz)');
    ylabel('Phase (radians)');
    legend('Ambulance','Firetruck');
    grid on;
    title('Phase Response');
    xlim([0 fs/2]);
    
    % Interactive filter visualization
    fvtool(b_amb, a_amb, b_fire, a_fire);
    hfvt = findobj('Type', 'figure', 'Name', 'Filter Visualization Tool');
    set(hfvt, 'Position', [200 200 800 600]);
    legend('Ambulance Filter', 'Firetruck Filter');
    
    drawnow;
end