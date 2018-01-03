function [f, h] = stopButton(x, y, w, h)
% STOPBUTTONVNA Displays a stop button.
%   [F, H] = STOPBUTTON(X, Y, H, W) displays a Stop button to check abort of data collection - 
%   based on MathWorks solution 1-15JIQ (http://uk.mathworks.com/matlabcentral/answers/100558-how-do-i-set-up-a-uicontrol-callback-to-interrupt-a-routine) and MATLAB Central Forum.
%   
% *Input arguments:*
%
%   X - See left in Location and Size for FIGURE
%   Y - See bottom in Location and Size for FIGURE
%   W - See width in Location and Size for FIGURE
%   H - See height in Location and Size for FIGURE
%
% *Output arguments:*
%
%   F - the handle to the button's figure 
%   H - the uicontrol object.
%
%   Copyright: © 2017-2018 Pico Technology Ltd. All rights reserved.
%
%   See also FIGURE, UICONTROL.

    f = figure('Name', 'PicoVNA','numbertitle','off', 'menubar', 'none',...
              'units', 'pix',...
              'pos', [x y w h]);
          
    h = uicontrol('string', 'STOP', ...
                'callback', 'setappdata(gcf, ''run'', 0)', 'units', 'pixels',...
                'position',[10 10 100 30]);

end

