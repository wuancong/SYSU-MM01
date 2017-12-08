function [ dist ] = euclidean_dist( X_gallery, X_probe, model_para )
    dist=pdist2(X_probe,X_gallery,'euclidean');
end

