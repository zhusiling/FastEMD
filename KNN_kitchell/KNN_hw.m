
%% set up the clusters
numPointsPerCluster = 1000;

centersX = [0 1 2];
centersY = [0 4 2];
Clusters = [];

for thisCluster = 1:size(centersX,2)
    x = randn(1,numPointsPerCluster) + centersX(thisCluster);
    y = randn(1,numPointsPerCluster) + centersY(thisCluster);
    temp_cluster = [x' y' repmat(thisCluster,numPointsPerCluster,1)];
    Clusters = [Clusters; temp_cluster];
end

%% set up input point
inputPoint = [1 1];

%% Plot the clusters and input point
graphLabels = {'r.', 'g.', 'b.', 'm*'};

num = 1;
for cluster = 1:size(centersX,2)
    plot(Clusters(num:(cluster * numPointsPerCluster),1),  Clusters(num:(cluster * numPointsPerCluster),2), graphLabels{cluster});
    hold on
    num = num + numPointsPerCluster;
end
plot(inputPoint(1), inputPoint(2), graphLabels{(size(centersX,2)+1)});
hold off

%% Run KNN majority and weighted scripts

categoryLabel = kNearestNeighbors_majority(Clusters, inputPoint,100);

categoryLabel_weighted = kNearestNeighbors_weighted(Clusters, inputPoint, 100);

categoryLabel
categoryLabel_weighted

