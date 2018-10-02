%% connectVNA_1
%
%% Description
%
% |connectVNA_1()| creates and returns a COM object to a PicoVNA device.
%
% *Output Arguments:*
%
% * |obj| - the VNA COM object corresponding to the PicoVNA device
%
% See also <disconnectVNA_1.html disconnectVNA_1> .

function [obj] = connectVNA_1()

    % Create VNA COM object.
    obj = actxserver('PicoControl2_1.PicoVNA_2_1');

    % Check for an available VNA. 
    findPicoVNA = obj.FND;
    
    if (findPicoVNA==0)
        error('connectVNA:VNANotFound', 'No PicoVNA device found.');
    end

end

%%
% *Copyright:* © 2017-2018 Pico Technology Ltd. All rights reserved.