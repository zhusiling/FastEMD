%place this script in the same folder as your data folder
%run the script and type the image number you want to try

%% get user input

prompt = 'Enter Image Number: ';
inputImgNum = input(prompt);

%% input image and intialization

input_image_name = strcat('data/sample_', num2str(inputImgNum), '.jpg');
I = imread(input_image_name);

hsvimage = rgb2hsv(I);

h = hsvimage(:,:,1);
s = hsvimage(:,:,2);
v = hsvimage(:,:,3);

hhist = histogram(h(:),100);
hVals = hhist.Values;
shist = histogram(s(:),100);
sVals = shist.Values;
vhist = histogram(v(:),100);
vVals = vhist.Values;

Hist_intersection = zeros(1, 1000);

%% calculate intersection for each image, get the 3 most similar images

for k = 1:1000
    jpgFileName = strcat('data/sample_', num2str(k), '.jpg');
    if exist(jpgFileName,'file') && k ~= inputImgNum
        imgfile = imread(jpgFileName);
        hsvimage2 = rgb2hsv(imgfile);

        h2 = hsvimage2(:,:,1);
        s2 = hsvimage2(:,:,2);
        v2 = hsvimage2(:,:,3);

        hhist2 = histogram(h2(:),100);
        hVals2 = hhist2.Values;
        shist2 = histogram(s2(:),100);
        sVals2 = shist2.Values;
        vhist2 = histogram(v2(:),100);
        vVals2 = vhist2.Values;
         
        intersecth = 0;
        intersects = 0;
        intersectv = 0;
        for i = 1:100
            intersecth = intersecth + min((hVals(i)),(hVals2(i)));
            intersects = intersects + min((sVals(i)),(sVals2(i)));
            intersectv = intersectv + min((vVals(i)),(vVals2(i)));
        end
        Hist_intersection(k) = intersecth + intersects + intersectv;
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

