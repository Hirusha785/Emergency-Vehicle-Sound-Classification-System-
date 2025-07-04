function [model, cvAccuracy] = train_classifier(features, labels)
    % Normalize features column-wise (feature scaling)
    mu = mean(features, 1);
    sigma = std(features, 0, 1);
    features = (features - mu) ./ (sigma + eps);
    
    % Train SVM classifier with cross-validation
    fprintf('Training SVM classifier...\n');
    model = fitcsvm(features, labels, 'KernelFunction', 'rbf', 'Standardize', true, 'KernelScale', 'auto');
    
    % Cross-validation (K-Fold)
    cvmodel = crossval(model, 'KFold', 5); % 5-fold cross-validation
    cvAccuracy = 1 - kfoldLoss(cvmodel);
    
    % Save model and accuracy
    save('scripts/classifier.mat', 'model', 'cvAccuracy');
    
    % Display cross-validation accuracy
    fprintf('Cross-validation accuracy: %.2f%%\n', cvAccuracy * 100);
end
