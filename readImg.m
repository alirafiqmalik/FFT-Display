clc;clear all;close all
imgs_data = csvread('test.csv');
img_t       = imgs_data(21,:);
img = reshape(img_t,28,28);
imshow(img')
