
%% Initialization
x = 0.5: 0.5:10;
y = linspace(0.5,10,20);

%% Algorithm
%data types 
integerValue = 42;
floatValue = 3.14159;
stringValue = 'Hello';

%print variables
fprintf('Integer: %d\n', integerValue);
fprintf('Float: %f\n', floatValue);
fprintf('String: %s\n', stringValue);

%functions
area1 = calculateArea(5,4);

%if else

% Define a variable
x = 10;

% Check the value of x
if x > 0
    fprintf('x is positive\n');
elseif x < 0
    fprintf('x is negative\n');
else
    fprintf('x is zero\n');
end

% While loop

% Initialize a counter variable
counter = 1;

% Define the condition for the while loop
while counter <= 5
    % Display the current value of the counter
    fprintf('Counter value: %d\n', counter);
    
    % Increment the counter
    counter = counter + 1;
    if counter >=3 
        fprintf('Iteration counter: %d\n', counter);
        break
    end

end

% Display a message after the while loop completes
fprintf('While loop completed!\n');


%% Visualization 
%2d plots
figure(1)
plot(x,y,'ms:','LineWidth',2,...
                       'MarkerEdgeColor','k',...
                       'MarkerFaceColor','g',...
                       'MarkerSize',10)
 
title('example')

hold on 
plot(x,y.^2,'cd:','LineWidth',2,...
                       'MarkerEdgeColor','k',...
                       'MarkerFaceColor','g',...
                       'MarkerSize',10)
grid on
legend('Data 1','Data 2')
xlim([0.5 10])
ylim([0 100])

% Subplots
figure(2)
x = linspace(0, 2*pi, 100);
y1 = sin(x);
y2 = cos(x);
y3 = tan(x);

% Create a 2x2 subplot grid and plot different functions
subplot(2, 2, 1);
plot(x, y1);
title('Sin Function');

subplot(2, 2, 2);
plot(x, y2);
title('Cos Function');

subplot(2, 2, 3);
plot(x, y3);
title('Tan Function');

% Create another plot in the same figure
subplot(2, 2, 4);
plot(x, y1.*y2);
title('Product of Sin and Cos');
% Adjust layout
sgtitle('Multiple Plots Example');

%5 3d plots 
figure(3)
x = 1:0.5:10.5;
y = 1:20;
[X,Y] = meshgrid(x,y)
Z = (X.^2)+cos(Y)
surf(X,Y,Z)
xlabel('x')
ylabel('y')
zlabel('z')
title('3d plots')

%% Functions
function area = calculateArea(length,width)
    area = length*width;
end



