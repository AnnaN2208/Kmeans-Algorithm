%{
%Ntagiou Anna
%AEM:432
%}
close all;
clear all;
clc;

figure(1);
hold on
title('Data points');

%{
%1st Distribution
%}
center1=[4,0];
sigma1=[0.29 0.4 ; 0.4 4];
Data1=mvnrnd(center1,sigma1,50);
plot(Data1(:,1),Data1(:,2),'b*');

%{
%2nd Distribution
%}
center2=[5,7];
sigma2=[0.29 0.4 ; 0.4 0.9];
Data2=mvnrnd(center2,sigma2,50);
plot(Data2(:,1),Data2(:,2),'go');

%{
%3rd Distribution
%}
center3=[7,4];
sigma3=[0.64 0 ; 0 0.64];
Data3=mvnrnd(center3,sigma3,50);
plot(Data3(:,1),Data3(:,2),'r+');

legend({'1st Distribution', '2nd Distribution', '3rd Distribution'}, ...
    'Location', 'SouthEast')
hold off
Data=[Data1 ; Data2 ; Data3];

%{
%Entry of K variable and call of mykmeans function
%}
K = input('Enter the number of data groups (K): \n');
[ClusterCenters, IDC] = mykmeans(Data,K);

