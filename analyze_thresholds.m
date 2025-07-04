function thresh = analyze_thresholds()
    % Load training features and labels
    load('features_train.mat', 'featuresTrain', 'labelsTrain');
    
    % Validate data
    if ~exist('featuresTrain', 'var') || ~exist('labelsTrain', 'var')
        error('Required variables not found in features_train.mat');
    end
    
    % Convert logical indices
    ambulance_idx = (labelsTrain == 'ambulance');
    firetruck_idx = (labelsTrain == 'firetruck');
    
    % Use column 6 (energy ratio) for threshold calculation
    amb_ratio = featuresTrain(ambulance_idx, 6);
    fire_ratio = featuresTrain(firetruck_idx, 6);
    
    % Clean data - remove NaN/Inf values
    amb_ratio = amb_ratio(isfinite(amb_ratio));
    fire_ratio = fire_ratio(isfinite(fire_ratio));
    
    % Verify we have enough samples
    if isempty(amb_ratio) || isempty(fire_ratio)
        error('Insufficient valid samples for threshold calculation');
    end
    
    % Calculate robust statistics (median and MAD)
    med_amb = median(amb_ratio);
    med_fire = median(fire_ratio);
    mad_amb = mad(amb_ratio, 1);  % MAD (median absolute deviation)
    mad_fire = mad(fire_ratio, 1);
    
    % Calculate threshold using robust statistics
    % Weighted midpoint based on class separation
    thresh = (med_amb*mad_fire + med_fire*mad_amb) / (mad_amb + mad_fire);
    
    % Visualization (optional)
    figure('Name', 'Threshold Analysis', 'Position', [100 100 800 400]);
    
    subplot(1,2,1);
    hold on;
    histogram(amb_ratio, 'BinWidth', 0.1, 'FaceColor', 'b', 'EdgeColor', 'none');
    histogram(fire_ratio, 'BinWidth', 0.1, 'FaceColor', 'r', 'EdgeColor', 'none');
    xline(thresh, '--k', 'LineWidth', 2, 'Label', sprintf('Threshold: %.2f', thresh));
    xlabel('Energy Ratio (E_{amb}/E_{fire})');
    ylabel('Count');
    legend('Ambulance', 'Firetruck');
    title('Feature Distribution');
    grid on;
    
    subplot(1,2,2);
    boxplot([amb_ratio; fire_ratio], [ones(size(amb_ratio)); 2*ones(size(fire_ratio))], ...
            'Labels', {'Ambulance', 'Firetruck'});
    hold on;
    plot(xlim, [thresh thresh], '--k', 'LineWidth', 1.5);
    ylabel('Energy Ratio');
    title('Boxplot Analysis');
    grid on;
    
    fprintf('\n=== Threshold Calculation Report ===\n');
    fprintf('Ambulance median ratio: %.3f (MAD: %.3f)\n', med_amb, mad_amb);
    fprintf('Firetruck median ratio: %.3f (MAD: %.3f)\n', med_fire, mad_fire);
    fprintf('Optimal threshold: %.3f\n', thresh);
end