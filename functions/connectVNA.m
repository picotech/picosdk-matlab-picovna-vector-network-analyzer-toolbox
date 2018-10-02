%% ConnectVNA_SN
%
%% Description
% CONNECTVNA_SN Creates PicoVNA COM object.
%
%   connectVNA() returns a COM object to a PicoVNA device.
%
% Copyright: � 2017-2018 Pico Technology Ltd. All rights reserved.
%
% See also DISCONNECTVNA.

function [obj] = connectVNA()
    % Create VNA COM object.
    obj = actxserver('PicoControl2.PicoVNA_2');

    % Check for an available VNA. 
    findPicoVNA = obj.FND();
    
    if (findPicoVNA==0)
        error('ConnectVNA:VNANotFound', 'No PicoVNA device found.');
    end

end