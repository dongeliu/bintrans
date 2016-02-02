function img = blks2img(blks, blk_width, img_width)
% Convert blocks to image
[blk_cnt, blk_siz] = size(blks);
assert(mod(blk_siz, blk_width) == 0, 'Input blocks and block width are not matched');
assert(mod(img_width, blk_width) == 0, 'Input image width is invalid');
blk_height = blk_siz / blk_width;
num_block_rowwise = img_width / blk_width;
img_height = ceil(blk_cnt / num_block_rowwise) * blk_height;
img = zeros(img_height, img_width, 'like', blks);
for bidx = 1 : blk_cnt
    ridx = floor((bidx - 1) / num_block_rowwise);
    cidx = bidx - 1 - ridx * num_block_rowwise;
    img(ridx * blk_height + 1 : (ridx + 1) * blk_height, cidx * blk_width + 1 : (cidx + 1) * blk_width) = reshape(blks(bidx, :), blk_height, blk_width);
end