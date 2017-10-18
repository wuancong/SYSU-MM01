# RGB-Infrared Cross-Modality Re-ID Dataset
The SYSU-MM01 dataset is an RGB-Infrared (IR) multi-modality pedestrian dataset for cross-modality person re-identification. It is the first attempt to address the RGB-IR cross-modality Re-ID problem.

Download links:

Baiduyun: http://pan.baidu.com/s/1gfIlcmZ

Dropbox: https://www.dropbox.com/sh/v036mg1q4yg7awb/AABhxU-FJ4X2oyq7-Ts6bgD0a?dl=0

Porject page: http://isee.sysu.edu.cn/project/RGBIRReID.htm
(This link may not be available now and we will fix it as soon as possible.)

## Dataset Description
SYSU-MM01 contains RGB and IR images of 491 identities from 6 cameras including 4 RGB cameras and 2 IR cameras. RGB cameras work in bright scenarios while IR cameras work in dark scenario. There are totally 287,628 RGB images and 15,792 IR images in the dataset.

Here are some examples of the dataset and some statistics of SYSU-MM01:
![](https://github.com/wuancong/SYSU-MM01/blob/master/img/example.jpg)
<div align=center>
![](https://github.com/wuancong/SYSU-MM01/blob/master/img/overview.jpg)
</div>
As for the image captureing details of each camera, RGB images of camera 1 and 2 were captured in two bright indoor rooms (room 1 and 2) by Kinect V1. For each person, there are at least 400 continuous RGB frames with different poses and viewpoints. IR images of camera 3 and camera 6 are captured by IR cameras in the dark. The IR images have only one channel, and they are different from 3-channel RGB images. Camera 3 is placed in room 2 in dark environment,
while camera 6 is placed in an outdoor passage with background clutters. Camera 4 and 5 are RGB surveillance cameras
placed in two outdoor scenes named "gate" and "garden".

## Files Description
Two zip files "SYSU-MM01.zip" and "cam1_2_video.zip" are provided.

"SYSU-MM01.zip" contains data of 6 cameras in directories "cam1" to "cam6" and data split in "exp".
- "cam1" to "cam6": The name of each directory is ID. Notice that not every person appears in all 6 cameras.
- "exp": There is a fixed split for training and testing. To get training, validation and testing IDs, either "txt" or "mat" files can be used. "available_id" contains 491 valid IDs that appear in at least 2 cameras. "train_id", "val_id" and "test_id" are nonoverlap and the union of them are "available_id".

"cam1_2_video.zip" contains the Kinect RGB videos of camera 1 and 2, while "cam1" and "cam2" in "SYSU-MM01.zip" are subsampled versions. Data in directories "cam1_video_train" and "cam2_video_train" of training IDs can be used for training. Directories "cam1_video_test" and "cam2_video_test" contain videos of testing IDs, which are currently not used.

## Evaluation Protocol
There are 491 valid IDs in SYSU-MM01 dataset. We have a fixed split using 296 identities for training, 99 for
validation and 96 for testing. During training, all images of the 296 persons in training set in all cameras can be applied. Notice that, if validation set is not needed, it can also be used for training.

In the testing stage, samples from RGB cameras are for gallery set, and those from IR cameras are for probe set.
We design two modes, all-search mode and indoor-search mode. For all-search mode, RGB cameras 1, 2, 4 and 5 are
for gallery set and IR cameras 3 and 6 are for probe set. For indoor-search mode, RGB cameras 1 and 2 (excluding
outdoor cameras 4 and 5) are for gallery set and IR cameras 3 and 6 are for probe set, which is less challenging.

For both modes, we adopt single-shot and multi-shot settings. For every identity under an RGB camera, we randomly
choose one/ten image(s) of the identity to form the gallery set for single-shot/multi-shot setting. As for probe
set, all images are used. Given a probe image, matching is conducted by computing similarities between the probe image
and gallery images. Notice that matching is conducted between cameras in different locations, that is, camera 2 and camera 3 are in the same location, so probe images of camera 3 skip the gallery images of camera 2. After computing similarities, we can get a ranking list according to descending order of similarities.

For indicating the performance, we use Cumulative Matching Characteristic (CMC) and mean average precision (mAP). Notice that, for CMC under multi-shot setting, only the maximum similarity in all gallery images of
the same person is taken to compute the rank list. We repeat the above evaluation 10 times with random split of gallery and probe set and compute the average performance finally.

## Citation
If you use the dataset, please cite the following paper:

Ancong Wu, Wei-Shi Zheng, Hong-Xing Yu, Shaogang Gong and Jianhuang Lai. RGB-Infrared Cross-Modality Person Re-Identification. IEEE International Conference on Computer Vision (ICCV), 2017.

## Contact Information
wuancong@mail2.sysu.edu.cn