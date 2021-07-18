% reading files
fds = imageDatastore('*.tif', 'ReadFcn', @importdata);
file_names = fds.Files;
len = length(file_names);

% model-based approach
for i = 1:len  
    image = imread(file_names{i});
    image = im2double(image); %changing from int to double to process 
    edge_detect = edge(image,'canny', 0.15); %edge detection
    strelled = strel('sphere', 2); % giving shape to detected edges
    transformed = imdilate(edge_detect, strelled); % transformation
    final_image = imfill(transformed, 'holes'); %fill holes
    imwrite(final_image, file_names{i}) % writing out
end
