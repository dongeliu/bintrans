Matlab code to train a binary autoencoder using MAC, for binary hashing

(C) 2015 by Ramin Raziperchikolaei and Miguel A. Carreira-Perpinan
    Electrical Engineering and Computer Science
    University of California, Merced
    http://eecs.ucmerced.edu

The functions in this package can be used to optimize the binary autoencoder
(BA) and binary factor analysis (BFA) objective functions, using the method
of auxiliary coordinates (MAC). The resulting encoder function of BA or BFA
can be used to map input vectors to binary codes, as a hash function, and
thus to do binary hashing for fast approximate information retrieval.

Reference:
  M. A. Carreira-Perpinan and R. Raziperchikolaei:
  "Hashing with Binary Autoencoders".
  arXiv:1501.00756 [cs.LG], Jan 5, 2015.

The main functions are ba.m and bfa.m. See each function for detailed usage
instructions. The script demo.m illustrates how to use them to train BA and
BFA and do binary hashing using a subset of the SIFTsmall dataset contained
in the file SIFTsubset.mat (the original dataset is available at
http://corpus-texmex.irisa.fr).

List of functions:
- demo.m: trains hash functions on the SIFTsmall subset using 4 methods
  (BA, BFA, tPCA, ITQ) and plots their K-nearest-neighbor precision.
- ba.m, bfa.m (in AUX/): learn binary hash functions by optimizing BA, BFA.

The training algorithm depends on the following functions (in AUX/):
- binset: return the set of all n-bit binary numbers.
- optenc: train an encoder (hash function) given input data and binary codes.
- itq: learn a binary hash function using ITQ or tPCA.
- KNNPrecision: compute K-nearest-neighbor precision.
- linf: apply a linear function to a data matrix.
- linftrain: train a linear function.
- linh: apply a linear hash function to a data matrix and return binary codes.
- proxbqp: solve proximal bound-constrained quadratic program using ADMM.
- sqdist: matrix of Euclidean squared distances between two point sets.
- Zaltopt: optimize over the binary codes by alternating optimization.
- Zenum: optimize over the binary codes by enumeration.
- Zrelaxed: optimize over the binary codes by relaxing to [0,1] and truncating.

Notes:
- The training algorithm achieves a significant speedup if run in parallel.
  If you have the Matlab Parallel Processing Toolbox, simply start 'parpool'
  with the appropriate number of processors (see demo.m), and the iterations
  of every "parfor" loop in the code will be run in parallel. The code will
  run like a normal (serial) "for" if you don't have the Matlab Parallel
  Processing Toolbox.
- The code currently uses a linear (thresholded) encoder and a linear decoder.
  You can use a nonlinear encoder or decoder by providing a corresponding
  training function in the step over the encoder or decoder.

Installation notes:
- We train linear SVMs using LIBLINEAR:
    Fan et al: "LIBLINEAR: a library for large linear classification",
    JMLR 2008, http://www.csie.ntu.edu.tw/~cjlin/liblinear
  and its extension for incremental learning:
    Tsai et al: "Incremental and decremental training for linear
    classification", KDD 2014, http://www.csie.ntu.edu.tw/~cjlin/papers/ws.
  We have provided a Matlab wrapper (matlab/train.c) for the latter by
  modifying the original LIBLINEAR Matlab wrapper.
- Quick-start instructions:
  1. Install LIBLINEAR:
     change to liblinear-warmstart-1.95/, run 'make'.
  2. Install the Matlab interface of LIBLINEAR:
     change to liblinear-warmstart-1.95/matlab/, run 'make'.
     Make sure MATLABDIR (in Makefile) matches your Matlab filesystem.
  3. Run our code:
     change to the main directory, run 'demo.m'.
     It should take less than a minute to run in a workstation.

