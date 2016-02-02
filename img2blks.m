function blks = img2blks(img, blk_width, horiz_str, blk_height, vert_str)
% Convert image to blocks, enable stride
if ~exist('horiz_str', 'var')
    horiz_str = blk_width;
end
if ~exist('blk_height', 'var')
    blk_height = blk_width;
end
if ~exist('vert_str', 'var')
    vert_str = horiz_str;
end
assert(ismatrix(img), 'Input is not a grayscale image');
[img_height, img_width] = size(img);
assert(mod(img_width - blk_width, horiz_str) == 0 && mod(img_height - blk_height, vert_str) == 0, 'The image size, block size, and stride are not matched');
num_block_rowwise = (img_width - blk_width) / horiz_str + 1;
num_block_colwise = (img_height - blk_height) / vert_str + 1;
blks = zeros(num_block_colwise * num_block_rowwise, blk_height * blk_width, 'like', img);
for bidx = 1 : size(blks, 1)
    ridx = floor((bidx - 1) / num_block_rowwise);
    cidx = bidx - 1 - ridx * num_block_rowwise;
    blks(bidx, :) = reshape(img(ridx * vert_str + 1 : ridx * vert_str + blk_height, cidx * horiz_str + 1 : cidx * horiz_str + blk_width), 1, []);
end