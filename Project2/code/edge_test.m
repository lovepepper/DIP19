%DIP16 Assignment 2
%Edge Detection
%In this assignment, you should build your own edge detection and edge linking 
%function to detect the edges of a image.
%Please Note you cannot use the build-in matlab edge and bwtraceboundary function
%We supply four test images, and you can use others to show your results for edge
%detection, but you just need do edge linking for rubberband_cap.png.
clc; close all;

% Load the test image
%imgTest = im2double(imread('rubberband_cap.png'));
imgTest = im2double(imread('bird.png'));
imgTestGray = rgb2gray(imgTest);
figure; clf;
imshow(imgTestGray);

%now call your function my_edge, you can use matlab edge function to see
%the last result as a reference first
imgEdge = edge(imgTestGray);
%img_edge = my_edge(filter_gray_image);
figure;clf;
imshow(imgEdge);

%using imtool, you select a object boundary to trace, and choose
%an appropriateedge point as the start point 

%imtool(imgEdge);
edgePoints = [126, 232; 50, 92; 282, 227; 196, 79; 93, 296];

%now call your function my_edgelinking, you can use matlab bwtraceboundary 
%function to see the last result as a reference first. please trace as many 
%different object boundaries as you can, and choose different start edge points.

% figure;clf;
% background = imbinarize(imgTestGray, 1);
% imshow(background);
% 
% [rows, cols] = size(edgePoints);
% for i  = 1 : rows
%     Bxpc = bwtraceboundary(imgEdge, [edgePoints(i, 1), edgePoints(i, 2)], 'N');
%     hold on
%     plot(Bxpc(:,2), Bxpc(:,1), 'w', 'LineWidth', 1);
% end

%Bxpc = my_edgelinking(img_edge, 197, 329);