function design_filters()
    fs = 44100; % Sampling rate
    trainFiles = dir(fullfile('train', '**', '*.wav'));
    
    % Initialize with fixed FFT size
    N_fft = 2^14;
    ambulance_spectra = zeros(N_fft/2, 0);
    firetruck_spectra = zeros(N_fft/2, 0);
    
    % Define specific frequency bands for ambulance and firetruck filters
    ambulance_bands = {
        [300, 800],   % Ambulance Low band
        [800, 1500],  % Ambulance Mid band
        [1500, 2500], % Ambulance High band
        [2500, 4000]  % Ambulance Very high band
    };
    
    firetruck_bands = {
        [300, 600],   % Firetruck Low band
        [600, 1200],  % Firetruck Mid band
        [1200, 2500], % Firetruck High band
        [2500, 4000]  % Firetruck Very high band
    };
    
    % Analyze spectra for both classes
    for i = 1:length(trainFiles)
        try
            [x, fs_file] = audioread(fullfile(trainFiles(i).folder, trainFiles(i).name));
            x = mean(x, 2); % Convert to mono
            x = x / max(abs(x)); % Normalize
            
            if length(x) > N_fft
                x = x(1:N_fft);
            else
                x(end+1:N_fft) = 0;
            end
            
            X = abs(fft(x, N_fft));
            X = X(1:N_fft/2); % Take positive frequencies only
            
            if contains(lower(trainFiles(i).folder), 'ambulance')
                ambulance_spectra(:, end+1) = X;
            elseif contains(lower(trainFiles(i).folder), 'firetruck')
                firetruck_spectra(:, end+1) = X;
            end
            
        catch ME
            fprintf('Error processing file %s: %s\n', trainFiles(i).name, ME.message);
            continue;
        end
    end
    
    % Compute average spectra for both classes
    avg_amb = mean(ambulance_spectra, 2);
    avg_fire = mean(firetruck_spectra, 2);
    f = linspace(0, fs/2, N_fft/2); % Frequency vector
    
    % Create bandpass filters for each frequency range for ambulance and firetruck
    ambulance_filters = struct('b', {}, 'a', {}, 'band', {}, 'name', {});
    firetruck_filters = struct('b', {}, 'a', {}, 'band', {}, 'name', {});
    filter_names_ambulance = {'Ambulance Low Band', 'Ambulance Mid Band', 'Ambulance High Band', 'Ambulance Very High Band'};
    filter_names_firetruck = {'Firetruck Low Band', 'Firetruck Mid Band', 'Firetruck High Band', 'Firetruck Very High Band'};
    
    % Create ambulance filters
    for i = 1:length(ambulance_bands)
        band = ambulance_bands{i};
        nyquist = fs / 2;
        band_norm = band / nyquist;
        
        % Design bandpass filter for ambulance
        [b, a] = butter(6, band_norm, 'bandpass');
        
        % Store the filter coefficients, band information, and names for ambulance
        ambulance_filters(i).b = b;
        ambulance_filters(i).a = a;
        ambulance_filters(i).band = band;
        ambulance_filters(i).name = filter_names_ambulance{i};
        
        fprintf('%s: %.2f - %.2f Hz\n', filter_names_ambulance{i}, band(1), band(2));
    end
    
    % Create firetruck filters
    for i = 1:length(firetruck_bands)
        band = firetruck_bands{i};
        nyquist = fs / 2;
        band_norm = band / nyquist;
        
        % Design bandpass filter for firetruck
        [b, a] = butter(6, band_norm, 'bandpass');
        
        % Store the filter coefficients, band information, and names for firetruck
        firetruck_filters(i).b = b;
        firetruck_filters(i).a = a;
        firetruck_filters(i).band = band;
        firetruck_filters(i).name = filter_names_firetruck{i};
        
        fprintf('%s: %.2f - %.2f Hz\n', filter_names_firetruck{i}, band(1), band(2));
    end
    
    % Visualization of all filters (1 plot for ambulance filters, 1 plot for firetruck filters)
    fig = figure('Name', 'Bandpass Filter Responses', 'Position', [100 100 1200 800], 'NumberTitle', 'off');
    
    % Plot for ambulance filters (Top plot)
    subplot(1, 2, 1);
    hold on;
    for i = 1:length(ambulance_filters)
        [h, w] = freqz(ambulance_filters(i).b, ambulance_filters(i).a, 2048, fs);
        plot(w, 20 * log10(abs(h)), 'DisplayName', ambulance_filters(i).name);
    end
    title('Ambulance Filter Responses');
    xlabel('Frequency (Hz)');
    ylabel('Gain (dB)');
    legend('show');
    grid on; xlim([0 fs/2]);
    
    % Plot for firetruck filters (Bottom plot)
    subplot(1, 2, 2);
    hold on;
    for i = 1:length(firetruck_filters)
        [h, w] = freqz(firetruck_filters(i).b, firetruck_filters(i).a, 2048, fs);
        plot(w, 20 * log10(abs(h)), 'DisplayName', firetruck_filters(i).name);
    end
    title('Firetruck Filter Responses');
    xlabel('Frequency (Hz)');
    ylabel('Gain (dB)');
    legend('show');
    grid on; xlim([0 fs/2]);
    
    drawnow;
end
