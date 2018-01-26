%% connectVNA
%
%% Description
% connectVNA Creates PicoVNA COM object.
%
% connectVNA() returns a COM object to a PicoVNA device.
%
% See also <disconnectVNA.html disconnectVNA> .
%


function [obj] = connectVNA()
    % Create VNA COM object.
    obj = actxserver('PicoControl2.PicoVNA_2');

    % Check for an available VNA. 
    findPicoVNA = obj.FND;
    
    if (findPicoVNA==0)
        error('connectVNA:VNANotFound', 'No PicoVNA device found.');
    end

end

%%
% Copyright: © 2017-2018 Pico Technology Ltd. All rights reserved.