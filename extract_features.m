function [featuresTrain, labelsTrain, featuresTest, labelsTest] = extract_features()
    % Load the training and test data
    trainFiles = dir(fullfile('train', '**', '*.wav'));
    testFiles = dir(fullfile('test', '**', '*.wav'));
    
    % Sampling rate (fixed for your case)
    fs = 44100;
    
    % Initialize feature matrices
    featuresTrain = zeros(length(trainFiles), 13); % 13 MFCC features per file
    featuresTest = zeros(length(testFiles), 13);
    
    % Process training files
    fprintf('Processing %d training files...\n', length(trainFiles));
    for i = 1:length(trainFiles)
        [x, fs_file] = audioread(fullfile(trainFiles(i).folder, trainFiles(i).name));
        x = mean(x, 2); % Convert to mono
        if fs_file ~= fs
            x = resample(x, fs, fs_file); % Resample if needed
        end
        x = x / max(abs(x)); % Normalize
        
        % Extract MFCC features (using MATLAB's built-in function)
        coeffs = mfcc(x, fs); % Extract 14 MFCCs
        coeffs = coeffs(:, 2:end); % Remove the 0th coefficient (log energy)
        featuresTrain(i, :) = mean(coeffs, 1); % Use mean of MFCC coefficients
        
        % Assign labels
        if contains(lower(trainFiles(i).folder), 'ambulance')
            labelsTrain{i} = 'ambulance';
        else
            labelsTrain{i} = 'firetruck';
        end
    end
    
    % Process test files
    fprintf('Processing %d test files...\n', length(testFiles));
    for i = 1:length(testFiles)
        [x, fs_file] = audioread(fullfile(testFiles(i).folder, testFiles(i).name));
        x = mean(x, 2); % Convert to mono
        if fs_file ~= fs
            x = resample(x, fs, fs_file); % Resample if needed
        end
        x = x / max(abs(x)); % Normalize
        
        % Extract MFCC features (using MATLAB's built-in function)
        coeffs = mfcc(x, fs); % Extract 14 MFCCs
        coeffs = coeffs(:, 2:end); % Remove the 0th coefficient (log energy)
        featuresTest(i, :) = mean(coeffs, 1); % Use mean of MFCC coefficients
        
        % Assign labels
        if contains(lower(testFiles(i).folder), 'ambulance')
            labelsTest{i} = 'ambulance';
        else
            labelsTest{i} = 'firetruck';
        end
    end
    
    % Convert labels to categorical
    labelsTrain = categorical(labelsTrain');
    labelsTest = categorical(labelsTest');
    
    % Save features
    save('features_train.mat', 'featuresTrain', 'labelsTrain');
    save('features_test.mat', 'featuresTest', 'labelsTest');
end
