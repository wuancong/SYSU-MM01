function map=get_map_multi_cam(Y_gallery,Y_cam_gallery,Y_probe,Y_cam_probe,dist)
[~, ind]=sort(dist,2);
Y_result=Y_gallery(ind);
Y_cam_result=Y_cam_gallery(ind);
valid_probe_sample_count=0;
probe_sample_count=length(Y_probe);
ap_sum=0;
for i=1:probe_sample_count
    % remove gallery samples from the same camera of the probe
    Y_result_i=Y_result(i,:);
    Y_result_i(Y_cam_result(i,:)==Y_cam_probe(i))=[];
    % match for probe i
    match_i=(Y_result_i==Y_probe(i));
    true_match_count=sum(match_i);
    if true_match_count~=0 % if there is true matching in gallery
        valid_probe_sample_count=valid_probe_sample_count+1;
        true_match_rank=find(match_i==1);
        ap=mean((1:true_match_count)./true_match_rank);
        ap_sum=ap_sum+ap;
    end
end
map=ap_sum/valid_probe_sample_count;
end