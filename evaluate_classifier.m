function accuracy = evaluate_classifier(model, features, labels)
    % Normalize features
    load('scripts/normalization.mat', 'mu', 'sigma');
    features = (features - mu) ./ (sigma + eps);
    
    % Predict and calculate accuracy
    predictedLabels = predict(model, features);
    accuracy = mean(predictedLabels == labels) * 100;
    
    % Display confusion matrix
    figure;
    cm = confusionchart(labels, predictedLabels);
    cm.Title = 'Confusion Matrix';
    cm.XLabel = 'Predicted Label';
    cm.YLabel = 'True Label';
    
    % Display accuracy
    fprintf('Test Accuracy: %.2f%%\n', accuracy);
end
