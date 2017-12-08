% A demo for evaluation on SYSU-MM01 dataset using features learned by deep
% zero padding in "RGB-Infrared Cross-Modality Person Re-identification"

% Features of each cameras are saved in seperated mat files named "name_cam#.mat"
% In the mat files, feature{id}(i,:) is a row feature vector of the i-th image of id
feature_info.name = 'feat_deep_zero_padding';
feature_info.dir = './feature';
result_dir = './result'; % directory for saving result

setting.mode = 'all_search'; %'all_search' 'indoor_search'
setting.number_shot = 1; % 1 for single shot, 10 for multi-shot

model.test_fun = @euclidean_dist; % Similarity measurement function
% (You could define your own function in the same way as euclidean_dist function)
model.name = 'euclidean'; % model name
model.para = []; % No parameter is needed for euclidean distance here
% (If mahalanobis distance is used, the parameter can be the metric M learned from training data)

% load data split
content = load('./data_split/test_id.mat'); % fixed testing person IDs
data_split.test_id = content.id;

content = load('./data_split/rand_perm_cam.mat'); % fixed permutation of samples in each camera
data_split.rand_perm_cam = content.rand_perm_cam;

% evaluation
performance = evaluation_SYSU_MM01(feature_info, data_split, model, setting, result_dir);