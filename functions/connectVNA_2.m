%% connectVNA_2
%
%% Description
%
% |connectVNA_2()| creates and returns a COM object to a PicoVNA device.
%
% *Output Arguments:*
%
% * |obj| - the VNA COM object corresponding to the PicoVNA device
%
% See also <disconnectVNA_2.html disconnectVNA_2> .

function [obj] = connectVNA_2()

    % Create VNA COM object.
    obj = actxserver('PicoControl2_2.PicoVNA_2_2');

    % Check for an available VNA. 
    findPicoVNA = obj.FND;
    
    if (findPicoVNA==0)
        error('connectVNA:VNANotFound', 'No PicoVNA device found.');
    end

end

%%
% *Copyright:* © 2017-2018 Pico Technology Ltd. All rights reserved.