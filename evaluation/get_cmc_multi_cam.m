function [cmc,ind]=get_cmc_multi_cam(Y_gallery,Y_cam_gallery,Y_probe,Y_cam_probe,dist)
[~, ind]=sort(dist,2);
Y_result=Y_gallery(ind);
Y_cam_result=Y_cam_gallery(ind);
valid_probe_sample_count=0;
gallery_unique_count=length(unique(Y_gallery));
match_counter=zeros(1,gallery_unique_count);
probe_sample_count=length(Y_probe);
for i=1:probe_sample_count
    % remove gallery samples from the same camera of the probe
    Y_result_i=Y_result(i,:);
    Y_result_i(Y_cam_result(i,:)==Y_cam_probe(i))=[];
    % remove duplicated id
    Y_result_unique_i=unique(Y_result_i,'stable');
    % match for probe i
    match_i=(Y_result_unique_i==Y_probe(i));
    if sum(match_i)~=0 % if there is true matching in gallery
        valid_probe_sample_count=valid_probe_sample_count+1;
        for r=1:length(match_i)
            match_counter(r)=match_counter(r)+match_i(r);
        end
    end
end
rankk=match_counter/valid_probe_sample_count;
cmc=cumsum(rankk);
end