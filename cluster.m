blk_width = 8;
cluster_bits = 14; K = 2 ^ cluster_bits;

all_blks = zeros(0, blk_width * blk_width);
for i = 1 : 24
    img = imread(['../kodak_pgm/kodim',num2str(i, '%02d'),'.pgm']);
    all_blks = [all_blks; img2blks(img, blk_width)];
end
rng(0);
opts = statset('Display', 'iter', 'MaxIter', 5000);
idx = kmeans(double(all_blks), K, 'onlinephase', 'off', 'options', opts);

train_data = cell(1, K);
for i = 1 : K
    train_data{i} = all_blks(idx == i, :);
end
save(['train_data_kodak24pgm_b',num2str(blk_width),'_K',num2str(K),'.mat'], 'train_data');