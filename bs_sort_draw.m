bs_result = load('bs_result_1000.mat');
horizontal = zeros(16*patch_size,16*patch_size);
vertical = zeros(16*patch_size,16*patch_size);
zigzag = zeros(16*patch_size,16*patch_size);
for ii=1:size(final_index)
  fprintf('draw block %d\n',ii);
  tmp = dic(:,final_index(ii));
  tmp = reshape(tmp,patch_size,patch_size);
  h_i = round(floor((ii-1)/16));
  h_j = round(mod(ii-1,16));
  h_ii = h_i*patch_size+1:(h_i+1)*patch_size;
  h_jj = h_j*patch_size+1:(h_j+1)*patch_size;
  horizontal(h_ii,h_jj) = tmp;
end

horizontal = abs(horizontal);
max_ = max(max(horizontal));
min_ = min(min(horizontal));
fenzi = horizontal - min_;
fenmu =  max_ - min_ ;
horizontal = fenzi / fenmu;
imwrite(horizontal,'dic_map.jpg');
disp('ok');