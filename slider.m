function [ output_args ] = slider(face) %, cue, prompt, d1, d2, feedback)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%Make variables global for use in functions
global returnKey spaceKey escapeKey leftKey rightKey upKey downKey window
global App_Evectors Shape_Evectors happy gender happyS genderS intercept interceptS base_points interp
exitDemo = false;
exitTrial = false;

imageTexture = Screen('MakeTexture', window, face);

                            

dim1 = 0;
dim2 = 0;
while exitDemo == false & exitTrial == false
    Screen('DrawTexture', window, imageTexture, [], [], 0);
    
    % Flip to the screen
    Screen('Flip', window);
    
    
    [keyIsDown,secs, keyCode] = KbCheck(2);
    if keyIsDown   
        if keyCode(escapeKey) %If escape key, exit
            exitDemo = true;
        elseif keyCode(rightKey)
            dim1 = dim1 + .1;  
        elseif keyCode(leftKey)
            dim1 = dim1 - .1;
        elseif keyCode(upKey)
            dim2 = dim2 + .1;
        elseif keyCode(downKey)
            dim2 = dim2 - .1;
        elseif keyCode(spaceKey) %If space key, lock in answer
            exitTrial = true;
        end
        newApp = App_Evectors * (happy * dim1 + gender * dim2 + intercept);
        newApp = reshape(newApp, [251,179,3]) + face;
        %Warp
        new_locs = Shape_Evectors * (happyS * dim1 + genderS * dim2 + interceptS);
        new_locs = reshape(new_locs, [62,2]) + base_points;
        [imgw, imgwr, map] = tpswarp(newApp, [size(newApp,2) size(newApp,1)], base_points, new_locs, interp);
        imageTexture = Screen('MakeTexture', window, imgw);
    end
    
    if(exitTrial == true)
        %TODO: save params
        
    end
    
end





end

