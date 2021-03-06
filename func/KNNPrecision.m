% P = KNNPrecision(trainZ,testZ,K,gt) K-nearest neighbors precision
%
% In:
%   trainZ: NxL binary matrix containing binary codes for training set.
%   testZ: MxL binary matrix containing binary codes for test set.
%   K: number of neighbors, or a list of neighbors.
%   gt: MxK matrix containing the index of the K-nearest-neighbors of the
%      test points (ground truth).
% Out:
%   P: K-nearest neighbor precision or list of precisions (if K is a list).

% Copyright (c) 2015 by Ramin Raziperchikolaei and Miguel A. Carreira-Perpinan

function P = KNNPrecision(trainZ,testZ,K,gt)

[numTest,b] = size(testZ); P = zeros(size(K));
for i = 1:numTest
  point = testZ(i,:);
  dist = sum(bsxfun(@xor,trainZ,point),2);
  [~,idx] = sort(dist);
  for j = 1:numel(K)
    idx1 = idx(1:K(j));
    c = intersect(idx1,gt(i,:));
    retrievedGoodPairs = numel(c);
    P(j) = P(j) + retrievedGoodPairs/K(j);
  end
end
P = P/numTest;

end

