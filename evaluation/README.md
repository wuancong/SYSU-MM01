# Testing demo for SYSU-MM01 dataset
A MATLAB version testing demo is provided for evaluation on SYSU-MM01 dataset in "RGB-Infrared Cross-Modality Person Re-identification, ICCV 2017".

Dataset download links:

Baiduyun: http://pan.baidu.com/s/1gfIlcmZ

Dropbox: https://www.dropbox.com/sh/v036mg1q4yg7awb/AABhxU-FJ4X2oyq7-Ts6bgD0a?dl=0

Project page: http://isee.sysu.edu.cn/project/RGBIRReID.htm

Testing code:
https://github.com/wuancong/SYSU-MM01/blob/master/evaluation

## Citation
If you use the dataset, please cite the following paper:

Ancong Wu, Wei-Shi Zheng, Hong-Xing Yu, Shaogang Gong and Jianhuang Lai. RGB-Infrared Cross-Modality Person Re-Identification. IEEE International Conference on Computer Vision (ICCV), 2017.

## Testing procedure

1. Train a model using the samples of the IDs in "./data_split/train_id.mat" on SYSU-MM01.

2. Extract features of SYSU-MM01 dataset using data in "SYSU_MM01.zip" (can be found in the download links). 
To apply our provided testing code, the features should be saved in the following form:
Features of each camera are saved in seperated mat files named "name_cam#.mat".
In each mat file, feature{id}(i,:) is a row feature vector of the i-th image of id.
An example of our proposed deep zero padding features is provided in "./feature".

3. Run "demo.m". The default setting in "demo.m" is single-shot all-search mode. The input parameters can be set according to the comments in "demo.m". A fixed data split of testing set and 10 trials is provided in "./data_split". The average CMC and mAP results of 10 trials of random split will be displayed when testing is finished. The result of this demo is an re-implemented version and is slightly better than the one reported in the paper.

## Contact Information
If you have any questions, please feel free to contact wuancong@mail2.sysu.edu.cn.