function dataConvert
data = readmatrix('Data_nextGen_KEtesting_allresults.csv');
time = data(:,1);
% make calculations for the vnots of the various models.
model_A_vnot = vnotCalculate(2, data);
model_B_vnot = vnotCalculate(22, data);
model_C_vnot = vnotCalculate(42, data);
model_D_vnot = vnotCalculate(62, data);
model_E_vnot = vnotCalculate(82, data);
% print function below here
display(model_A_vnot);
display(model_B_vnot);
display(model_C_vnot);
display(model_D_vnot);
display(model_E_vnot);
end

function vnot = vnotCalculate(starting, data)
% for each 10 values in the dataset
collection = zeros(10);
ending = starting + 10;
% look at each testing iteration
for j = starting:ending
    % give a slope variable
    basis = 10; % this is the placement of the value to check to.
    slope = zeros(basis);
    % find the slope between the two different datapoints
    original_data = data(:,starting);
    duplicate_data = data(:,starting+10);
    % smooth the data before processing
    original_smooth = smooth(original_data(:));
    duplicate_smooth = smooth(duplicate_data(:));
    % find the slope for each 
    for i = 2:basis
        % find the midpoint between the two datasets
        difference_first = (original_smooth(i) - duplicate_smooth(i));
        % find t 
        difference_second = (original_smooth(i+1) - duplicate_smooth(i+1));
        % find the slope
        slope(i-1) = (difference_second - difference_first);
    end
    % save the function.
    collection(j) = mean(slope,'all');
end
vnot = mean(collection);
end