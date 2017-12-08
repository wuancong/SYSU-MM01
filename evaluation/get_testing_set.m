function [X_gallery, Y_gallery, Y_cam_gallery, X_probe, Y_probe, Y_cam_probe]=get_testing_set...
    (feature_cam, Y, rand_perm_cam, run_time, number_shot, gallery_cam_list, probe_cam_list, test_id, cam_id)
% get testing set for SYSU-MM01 multi-modality re-id dataset
% input:
% feature_cam - feature_cam{i}{id} is feature matrix (each row is a feature) of cam i of person id
% Y - person id for each cell
% rand_perm - rand permutation of indices for selecting gallery
% run_time - current count of evaluation time
% number_shot - 1 single shot, 5 multi-shot, -1 all except one
% test_cam_list - cam list of testing set
% test_id - list of testing persons
% output:
% X_... - feature vectors in each row
% Y_... - person label
% Y_cam_... - camera label

gallery_cam_count=length(gallery_cam_list);
X_gallery=cell(gallery_cam_count,1);
Y_gallery=cell(gallery_cam_count,1);
Y_cam_gallery=cell(gallery_cam_count,1);
probe_cam_count=length(probe_cam_list);
X_probe=cell(probe_cam_count,1);
Y_probe=cell(probe_cam_count,1);
Y_cam_probe=cell(probe_cam_count,1);

% gallery
for i_cam=1:gallery_cam_count
    cam_num=gallery_cam_list(i_cam);
    cam_label=cam_id(cam_num);
    Y_i_cam=Y{cam_num};
    id_count=length(Y_i_cam);
    
    X_gallery{i_cam}=cell(id_count,1);
    Y_gallery{i_cam}=[];
    Y_cam_gallery{i_cam}=[];
    for i_id=1:id_count
        if isempty(find(test_id==Y_i_cam(i_id)))
            continue;
        end
        rand_perm_this=rand_perm_cam{cam_num}{i_id}(run_time,:);
        if isempty(rand_perm_this)
            continue;
        end
        if number_shot<0
            ind_gallery_this=rand_perm_this(1:end+number_shot);
        else
            ind_gallery_this=rand_perm_this(1:number_shot);
        end
        X_test_this=feature_cam{cam_num}{i_id};
        X_gallery{i_cam}{i_id}=X_test_this(ind_gallery_this,:);
        frame_count=size(X_gallery{i_cam}{i_id},1);
        Y_gallery{i_cam}=[Y_gallery{i_cam};repmat(Y_i_cam(i_id),frame_count,1)];
        Y_cam_gallery{i_cam}=[Y_cam_gallery{i_cam};repmat(cam_label,frame_count,1)];
    end
    X_gallery{i_cam}=cell2mat(X_gallery{i_cam});
end

% probe
for i_cam=1:probe_cam_count
    cam_num=probe_cam_list(i_cam);
    cam_label=cam_id(cam_num);
    Y_i_cam=Y{cam_num};
    id_count=length(Y_i_cam);
    
    X_probe{i_cam}=cell(id_count,1);
    Y_probe{i_cam}=[];
    Y_cam_probe{i_cam}=[];
    for i_id=1:id_count
        if isempty(find(test_id==Y_i_cam(i_id)))
            continue;
        end
        rand_perm_this=rand_perm_cam{cam_num}{i_id}(run_time,:);
        if isempty(rand_perm_this)
            continue;
        end
        X_test_this=feature_cam{cam_num}{i_id};
        X_probe{i_cam}{i_id}=X_test_this;
        frame_count=size(X_probe{i_cam}{i_id},1);
        Y_probe{i_cam}=[Y_probe{i_cam};repmat(Y_i_cam(i_id),frame_count,1)];
        Y_cam_probe{i_cam}=[Y_cam_probe{i_cam};repmat(cam_label,frame_count,1)];
    end
    X_probe{i_cam}=cell2mat(X_probe{i_cam});
end

X_gallery=cell2mat(X_gallery);
Y_gallery=cell2mat(Y_gallery);
Y_cam_gallery=cell2mat(Y_cam_gallery);

X_probe=cell2mat(X_probe);
Y_probe=cell2mat(Y_probe);
Y_cam_probe=cell2mat(Y_cam_probe);

end