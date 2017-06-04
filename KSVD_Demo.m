%KSVD demo
clc;clear;
param.K = 5;
param.numIteration = 100;
param.preserveDCAtom = 1;
param.displayProgress = 1;
param.InitializationMethod = 'DataElements';
param.errorFlag = 1;
param.errorGoal = 0;

data = rand(10,100);
[Dictionary,output] = KSVD(data,param);
