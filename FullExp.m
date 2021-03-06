%% Initialize
% Clear the workspace and the screen
sca;
close all;
clearvars;

%Make variables global for use in functions
global returnKey spaceKey escapeKey leftKey rightKey upKey downKey window
global App_Evectors Shape_Evectors happy gender happyS genderS intercept interceptS base_points interp

%Turn off SyncTests
%Will need to investigate later, but for this experiment timing doesn't
%matter
Screen('Preference', 'SkipSyncTests', 1);

% Here we call some default settings for setting up Psychtoolbox
PsychDefaultSetup(2);

% Get the screen numbers. This gives us a number for each of the screens
% attached to our computer.
screens = Screen('Screens');

% To draw we select the maximfum of these numbers. So in a situation where we
% have two screens attached to our monitor we will draw to the external
% screen.
screenNumber = max(screens);


%sheight = 1455; % screen height
%swidth = 2561; % screen width


sheight = 500; % screen height
swidth = 500; % screen width



%Get Subject Number
%sNum = input('Enter subject number ');


%% Load AAM 
%load Acive Appearance model
load model
mface = reshape(Data.AppearanceData.g_mean, [251,179,3]);
App_Evectors = Data.AppearanceData.Evectors;
Shape_Evectors = Data.ShapeData.Evectors;


%Load appearance weights
weights = readtable('weightsAlt.txt');
w = table2array(weights(:,3:9));

intercept = w(:,5);
happy = w(:,4);
gender = w(:,3);
skintone = w(:,6);
attractive = w(:,1);
dominance = w(:,2);
trust = w(:,7);

%Load shape weights
weights = readtable('weightsShapeAlt.txt');
w = table2array(weights(:,3:9));

interceptS = w(:,5);
happyS = w(:,4);
genderS = w(:,3);
skintoneS = w(:,6);
attractiveS = w(:,1);
dominanceS = w(:,2);
trustS = w(:,7);

%params
interp.method = 'invdist'; %'invdist','nearest'; %'none' % interpolation method
interp.radius = 10; % radius or median filter dimension
interp.power = 5; %power for inverse wwighting interpolation method

%base_points
base_points = [Data.ShapeData.x_mean(1:end/2) Data.ShapeData.x_mean(end/2+1:end)];
base_points = [Data.ShapeData.x_mean(1:end/2) Data.ShapeData.x_mean(end/2+1:end)];

% Normalize the base points to range 0..1
base_points = base_points - repmat(min(base_points),size(base_points,1),1);
base_points = base_points ./ repmat(max(base_points),size(base_points,1),1);

% Transform the mean contour points into the coordinates in the texture
% image.
base_points(:,1)=1+(251-1)*base_points(:,1); %-md
base_points(:,2)=1+(179-1)*base_points(:,2); %-md

%% Screen Parameters
% Open an on screen window using PsychImaging and color it black
black = [0 0 0]';     
[window, windowRect] = PsychImaging('OpenWindow', screenNumber, black, [0 0 swidth sheight]);

%Set Text Size
Screen('TextSize', window, 40);

% Query the frame duration
ifi = Screen('GetFlipInterval', window);




% The avaliable keys to press
returnKey = 40;
spaceKey = KbName('space');
escapeKey = KbName('ESCAPE');
oneKey = KbName('1!');
twoKey = KbName('2@');
threeKey = KbName('3#');
fourKey = KbName('4$');
fiveKey = KbName('5%');
sixKey = KbName('6^');
sevenKey = KbName('7&');
eightKey = KbName('8*');
nineKey = KbName('9(');
zeroKey = KbName('0)');
rightKey = KbName('RightArrow');
leftKey = KbName('LeftArrow');
upKey = KbName('UpArrow');
downKey = KbName('DownArrow');



% Get the centre coordinate of the window
[xCenter, yCenter] = RectCenter(windowRect);


% Sync us and get a time stamp
vbl = Screen('Flip', window);
waitframes = 1;

% Maximum priority level
topPriorityLevel = MaxPriority(window);
Priority(topPriorityLevel);


%% Experiment
slider(mface);

% Wait 
WaitSecs(1);

sca;








