function [categoryLabel] = kNearestNeighbors_weighted(dataMatrix, inputPoint, k)
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
numCategories = size(unique(dataMatrix(:,3)),1);

colors = rand(numCategories + 1, 3);


dist = sum((repmat(inputPoint,numDataVectors,1)-dataMatrix(:,1:2)).^2,2);
[sortval sortpos] = sort(dist,'ascend');
neighborIds = sortpos(1:k);
neighborDistances = sqrt(sortval(1:k));
inv_neighborDistances = 1./neighborDistances;
neighborCategory = dataMatrix(neighborIds,3);
sum_distances_for_cat = zeros(1,numCategories);
for i=size(inv_neighborDistances,2)
    temp_cat = neighborCategory(i);
    sum_distances_for_cat(temp_cat) = sum_distances_for_cat(temp_cat) + inv_neighborDistances(i);
end

[val weightedCat] = max(sum_distances_for_cat); 

categoryLabel = weightedCat;

