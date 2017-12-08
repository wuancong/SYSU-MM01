function [performance] = evaluation_SYSU_MM01(feature_info, data_split, model, setting, result_dir)
% evaluation on SYSU-MM01 dataset with input features and model
% input:
% Features of each cameras are saved in seperated mat files named "name_cam#.mat"
% In the mat files, feature{id}(i,:) is a row feature vector of the i-th image of id
% feature_info.name = 'feat_deep_zero_padding';
% feature_info.dir = './feature';
% result_dir = './result'; % directory for saving result
%
% setting.mode = 'all_search'; %'all_search' 'indoor_search'
% setting.number_shot = 1; % 1 for single shot, 10 for multi-shot
%
% model.test_fun = @euclidean_dist; % Similarity measurement function (You could define your own function in the same way as euclidean_dist function)
% model.name = 'euclidean'; % model name
% model.para = []; % No parameter is needed for euclidean distance here (If mahalanobis distance is used, the parameter can be the metric M learned from training data)
%
% content = load('./data_split/test_id.mat'); % fixed testing person IDs
% data_split.test_id = content.id;
%
% content = load('./data_split/rand_perm_cam.mat'); % fixed permutation of samples in each camera
% data_split.rand_perm_cam = content.rand_perm_cam;
%
% output:
% performance.cmc_mean & performance.map_mean - average results of 10 trials
% performance.cmc_all & performance.map_mean - results of each trial

feature_name = feature_info.name;
feature_dir = feature_info.dir;

mode = setting.mode; % 'all_search' 'indoor_search'
number_shot = setting.number_shot; % 1 for single shot, 10 for multi-shot
test_id = data_split.test_id;
rand_perm_cam = data_split.rand_perm_cam;

%% begin
switch mode
    case 'all_search'
        gallery_cam_list=[1 2 4 5];
        probe_cam_list=[3 6];
    case 'indoor_search'
        gallery_cam_list=[1 2];
        probe_cam_list=[3 6];
    otherwise
        disp('mode input error');
end

% load features of 6 cameras
load_cam_list = union(probe_cam_list,gallery_cam_list);
cam_count = 6;
feature_cam=cell(cam_count,1);
Y=cell(cam_count,1);

cam_id = [1 2 2 4 5 6]; % camera 2 and 3 are in the same location

for i_cam=1:length(load_cam_list)
    cam_label=load_cam_list(i_cam);
    load_name=[feature_name '_cam' num2str(cam_label) '.mat'];
    content=load(fullfile(feature_dir,load_name));
    feature_cam{cam_label}=content.feature;
    Y{cam_label}=(1:length(content.feature))';
end
clear content

% begin testing
cmc_all=cell(10,1);
map_all=zeros(10,1);

for run_time=1:10
    disp(['trial #',num2str(run_time)]);
    % For X_..., each row is an observation
    [X_gallery, Y_gallery, Y_cam_gallery, X_probe, Y_probe, Y_cam_probe]=get_testing_set...
        (feature_cam, Y, rand_perm_cam, run_time, number_shot, gallery_cam_list, probe_cam_list, test_id, cam_id);
    dist = model.test_fun(X_gallery,X_probe,model.para);
    cmc = get_cmc_multi_cam(Y_gallery,Y_cam_gallery,Y_probe,Y_cam_probe,dist);
    map = get_map_multi_cam(Y_gallery,Y_cam_gallery,Y_probe,Y_cam_probe,dist);
    disp('rank 1 5 10 20');
    disp(cmc([1 5 10 20]));
    disp('mAP');
    disp(map);
    cmc_all{run_time}=cmc;
    map_all(run_time,:)=map;
end
cmc_all=cell2mat(cmc_all);
performance.cmc_all=cmc_all;
performance.map_all=map_all;
cmc_mean=mean(performance.cmc_all);
performance.cmc_mean=cmc_mean;
map_mean=mean(performance.map_all);
performance.map_mean=map_mean;

% display
disp('Average CMC:');
disp('rank 1 5 10 20');
disp(cmc_mean([ 1 5 10 20]));
disp('Average mAP:');
disp(map_mean);

% save
save_path=fullfile(result_dir,['result_' feature_name '_' model.name '_' mode '_' num2str(number_shot) 'shot.mat']);
save(save_path,'performance','setting','-v7.3');

end