% main.m
clc; clear; close all;
rng(42);

% Ensure script runs from its own directory
cd(fileparts(mfilename('fullpath')));

% Create scripts directory if needed
if ~exist('scripts', 'dir')
    mkdir('scripts');
end

fprintf('=== Emergency Vehicle Sound Classification ===\n');

% 1. Design frequency-specific filters
fprintf('\n=== Step 1: Designing Filters ===\n');
design_filters();

% 2. Feature extraction
fprintf('\n=== Step 2: Feature Extraction ===\n');
[featuresTrain, labelsTrain, featuresTest, labelsTest] = extract_features();

% 3. Analyze feature distributions
fprintf('\n=== Step 3: Analyzing Feature Thresholds ===\n');
thresh = analyze_thresholds();
save('scripts/thresh.mat', 'thresh');

% 4. Visualize features and filters
fprintf('\n=== Step 4: Visualizing Features ===\n');
visualize_features(thresh);
drawnow; % Force figure update

% 5. Train classifier
fprintf('\n=== Step 5: Training Classifier ===\n');
[model, cvAccuracy] = train_classifier(featuresTrain, labelsTrain);
fprintf('Cross-validation accuracy: %.2f%%\n', cvAccuracy*100);

% 6. Evaluate performance
fprintf('\n=== Step 6: Evaluation ===\n');
test_accuracy = evaluate_classifier(model, featuresTest, labelsTest);
fprintf('\n=== Final Test Accuracy: %.2f%% ===\n', test_accuracy);