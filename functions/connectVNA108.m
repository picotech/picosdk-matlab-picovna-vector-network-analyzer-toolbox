%% connectVNA108
%
%% Description
%
% |connectVNA108()| creates and returns a COM object to a PicoVNA108 device.
%
% *Output Arguments:*
%
% * |obj| - the VNA108 COM object corresponding to the PicoVNA device
%
% See also <disconnectVNA.html disconnectVNA> .

function [obj] = connectVNA180()

    % Create VNA COM object.
    obj = actxserver('PicoControl3.PicoVNA_3');

    % Check for an available VNA. 
    findPicoVNA = obj.FND();
    
    if (findPicoVNA==0)
        error('connectVNA:VNANotFound', 'No PicoVNA device found.');
    end

end

%%
% *Copyright:* © 2017-2020 Pico Technology Ltd. All rights reserved.