%% stopButtonVNA
%
%% Description
%
% StopButtonVNA  Displays a stop button.
%
% [F, H] = StopButton(X, Y, H, W) displays a Stop button to check abort of data collection - 
% based on MathWorks solution 1-15JIQ (http://uk.mathworks.com/matlabcentral/answers/100558-how-do-i-set-up-a-uicontrol-callback-to-interrupt-a-routine) and MATLAB Central Forum.
%   
%% Input arguments:
%
% X - See left in Location and Size for FIGURE
% Y - See bottom in Location and Size for FIGURE
% W - See width in Location and Size for FIGURE
% H - See height in Location and Size for FIGURE
%
%% Output arguments:
%
% F - the handle to the button's figure 
% H - the uicontrol object.
%
% See also <matlab:doc('figure') figure> , <matlab:doc('uicontrol') uicontrol> .


function [f, h] = stopButton(x, y, w, h)
    % Check for valid inputs
    validateattributes(x,{'numeric'},{'nonnegative'});
    validateattributes(y,{'numeric'},{'nonnegative'});
    validateattributes(w,{'numeric'},{'positive'});
    validateattributes(h,{'numeric'},{'positive'});

    f = figure('Name', 'PicoVNA','numbertitle','off', 'menubar', 'none',...
              'units', 'pix',...
              'pos', [x y w h]);
          
    h = uicontrol('string', 'STOP', ...
                'callback', 'setappdata(gcf, ''run'', 0)', 'units', 'pixels',...
                'position',[10 10 100 30]);

end

%%
%   Copyright: © 2017-2018 Pico Technology Ltd. All rights reserved.