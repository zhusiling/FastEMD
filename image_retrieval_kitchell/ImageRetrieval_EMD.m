%place this script in the same folder as your data folder
%and your FastEMD folder. Run the script and type the image number you 
%want to try.

%% set up and get user input
addpath ./FastEMD/
addpath ./FastEMD/demo_FastEMD4/

prompt = 'Enter Image Number: ';
inputImgNum = input(prompt);

%% input image

input_image_name = strcat('data/sample_', num2str(inputImgNum), '.jpg');
EMD = zeros(1,1000);

%% calculate EMD for each image and get the 3 images with smallest EMD

for k = 1:1000
    jpgFileName = strcat('data/sample_', num2str(k), '.jpg');
    if exist(jpgFileName,'file') && k ~= inputImgNum
        emd_hat_mex_val_with_flow = run_EMD4(input_image_name, jpgFileName);
        EMD(k) = emd_hat_mex_val_with_flow;
    else
        EMD(k) = 1000000;
    end
  
end 

[sortVal, sortPos] = sort(EMD, 'ascend');

mostSim3Pos = sortPos(1:3);
mostSim3Val = sortVal(1:3);

%% display the images

figure()
subplot(221); imshow(strcat('data/sample_', num2str(inputImgNum),'.jpg')); title('Original');
subplot(222); imshow(strcat('data/sample_', num2str(mostSim3Pos(1)),'.jpg')); title(['IMG ', num2str(mostSim3Pos(1)), ' Score: ', num2str(mostSim3Val(1))]);
subplot(223); imshow(strcat('data/sample_', num2str(mostSim3Pos(2)),'.jpg')); title(['IMG ', num2str(mostSim3Pos(2)), ' Score: ', num2str(mostSim3Val(2))]);
subplot(224); imshow(strcat('data/sample_', num2str(mostSim3Pos(3)),'.jpg')); title(['IMG ', num2str(mostSim3Pos(3)), ' Score: ', num2str(mostSim3Val(3))]);

