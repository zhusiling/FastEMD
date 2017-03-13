%place this script in the same folder as your data folder
%run the script and type the image number you want to try

%% get user input

prompt = 'Enter Image Number: ';
inputImgNum = input(prompt);

%% input image and intialization

input_image_name = strcat('data/sample_', num2str(inputImgNum), '.jpg');
I = imread(input_image_name);
inputImgHist = histogram(I,255);
inVals = inputImgHist.Values;
Hist_intersection = zeros(1, 1000);

%% calculate intersection for each image, get the 3 most similar images

for k = 1:1000
    jpgFileName = strcat('data/sample_', num2str(k), '.jpg');
    if exist(jpgFileName,'file') && k ~= inputImgNum
        imgfile = imread(jpgFileName);
        h = histogram(imgfile,255);
        values = h.Values;
        intersect = 0;
        for i = 1:255
            intersect = intersect + min((inVals(i)),(values(i)));
        end
        Hist_intersection(k) = intersect;
    end
end 

[sortVal, sortPos] = sort(Hist_intersection, 'descend');

mostSim3Pos = sortPos(1:3);
mostSim3Val = sortVal(1:3);

%% display the images

figure()
subplot(221); imshow(strcat('data/sample_', num2str(inputImgNum),'.jpg')); title('Original');
subplot(222); imshow(strcat('data/sample_', num2str(mostSim3Pos(1)),'.jpg')); title(['IMG ', num2str(mostSim3Pos(1)), ' Score: ', num2str(mostSim3Val(1))]);
subplot(223); imshow(strcat('data/sample_', num2str(mostSim3Pos(2)),'.jpg')); title(['IMG ', num2str(mostSim3Pos(2)), ' Score: ', num2str(mostSim3Val(2))]);
subplot(224); imshow(strcat('data/sample_', num2str(mostSim3Pos(3)),'.jpg')); title(['IMG ', num2str(mostSim3Pos(3)), ' Score: ', num2str(mostSim3Val(3))]);

