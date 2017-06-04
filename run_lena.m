%KSVD demo

clc;clear;
param.K = 256;
param.numIteration = 1000;
param.preserveDCAtom = 1;
param.displayProgress = 1;
param.InitializationMethod = 'DataElements';
param.errorFlag = 1;
param.errorGoal = 0;

lena = imread('lena512color.jpg');
image_gray=rgb2gray(lena);
[n,m]= size(image_gray);
patch_size = 8;
patch_num = 1000;
crop_list = zeros(64,patch_num);
for i =1:patch_num
    crop = image_gray(randi(n-patch_size+1)+(0:patch_size-1),randi(m-patch_size+1)+(0:patch_size-1));
    crop_list(:,i) = reshape(crop,patch_size*patch_size,1);
end

data = crop_list;
[dic,output] = KSVD(data,param);
save('KSVD_result');
disp('K-SVD complete,start sorting..');


%ksvd_result = load('KSVD_result_1000.mat');
%dic = ksvd_result.Dictionary;
epsilon = 1e-5;
s = zeros(256,1);
final_pi_U = zeros(256,1);

for i=1:patch_num
    fprintf('process patch %d\n',i);
    % step 4: Solve BP Problem
    patch = ksvd_result.crop_list(:,i);
    v_i = bp(dic,patch);
    %step 5: identify support and the set of active basis
    %I_i = find(abs(v_i)>epsilon);
    %I_i = 1:size(v_i);
    %U_xi = dic(:,I_i);
    %step 6: calculate magnitude vector a_i
    a_i = abs(v_i);
    %step 7: sort the active basis.
    [tmp,I] = sort(a_i,'descend');
    
    for j= 1:size(tmp)
       if tmp(j+1) < epsilon
           break;
       end
    end
    indices_to_be_updated = I(1:j);
    %save current postion
    for ii=1:j
        final_pi_U(I(ii)) = final_pi_U(I(ii)) + ii;
    end
    %update s
    s(indices_to_be_updated) = s(indices_to_be_updated) + 1;
end
%if s =0,just put it in the rear of list.
for i = 1:256
    if abs(s(i)) < epsilon
        s(i) = epsilon;
    end
end
for i = 1:256
  if abs(final_pi_U(i)) < epsilon
      final_pi_U(i) = 1e5;
  end
end
final_pi_U = final_pi_U./s;


[tmp,final_index] = sort(final_pi_U);
save('bs_result_1000');




