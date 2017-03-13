function [categoryLabel] = kNearestNeighbors_majority(dataMatrix, inputPoint, k)
%--------------------------------------------------------------------------
% Program to find the k - nearest neighbors (kNN) within a set of points. 
% Distance metric used: Euclidean distance
% 
% Usage:
% [neighbors distances] = kNearestNeighbors(dataMatrix, queryMatrix, k);
% dataMatrix  (N x D) - N vectors with dimensionality D (within which we search for the nearest neighbors)
% queryMatrix (M x D) - M query vectors with dimensionality D
% k           (1 x 1) - Number of nearest neighbors desired


numDataVectors = size(dataMatrix,1);

dist = sum((repmat(inputPoint,numDataVectors,1)-dataMatrix(:,1:2)).^2,2);
[sortval, sortpos] = sort(dist,'ascend');
neighborIds = sortpos(1:k);
%neighborDistances = sqrt(sortval(1:k));
neighborCategory = dataMatrix(neighborIds,3);
categoryLabel = mode(neighborCategory);

