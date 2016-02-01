% We train BA and BFA on a subset of the SIFTsmall dataset and compare them
% with tPCA and ITQ. The script should take less than 1 minute to run.

addpath('func','liblinear-warmstart-1.95/matlab');

% Use parallel processing (requires the Matlab Parallel Processing Toolbox)
%parpool(2)

load 'SIFTsubset.mat';	% Dataset: X Test groundtruth
X = double(X); Test = double(Test);

L = 12;			% Number of bits in the hash function

% Train BFA. This initializes by default from tPCA, but you can provide another
% initialization.
[BFA_h BFA_Z] = bfa(X,L);

% Train BA. This initializes by default from ITQ, but you can provide another
% initialization. It needs a schedule for the penalty parameter mu, ie a list
% of nondecreasing positive values, where mu(k) is the mu value in the kth
% iteration of the MAC algorithm.
mu = [0 0 0 0 .0005 .0005 .0005 .0005 .001 .001...
      .001 .002 .002 .005 .005 .01 .01 .05 .05 .2];
[BA_h BA_Z] = ba(X,L,mu);

% Train ITQ and tPCA (for comparison purposes)
[ITQ_h ITQ_Z] = itq(X,L); [tPCA_h tPCA_Z] = itq(X,L,0);

% Compute the precision of the different hash functions...
k = 50:10:100;		% Number of neighbors to retrieve
BAP = KNNPrecision(BA_Z,linh(Test,BA_h),k,groundtruth);
BFAP = KNNPrecision(BFA_Z,linh(Test,BFA_h),k,groundtruth);
ITQP = KNNPrecision(ITQ_Z,linh(Test,ITQ_h),k,groundtruth);
tPCAP = KNNPrecision(tPCA_Z,linh(Test,tPCA_h),k,groundtruth);
% ...and plot the results.
prec = [BAP;BFAP;ITQP;tPCAP];
figure(1); h = plot(k,prec); set(gca,'XTick',k);
xlabel('number of neighbors'); ylabel('precision');
legend(h,'BA','BFA','ITQ','tPCA','Location','NorthEast');

