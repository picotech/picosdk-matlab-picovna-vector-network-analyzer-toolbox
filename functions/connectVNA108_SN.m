%% ConnectVNA108_SN
%
%% Description
% CONNECTVNA108_SN Creates PicoVNA108 COM object.
%
%   connectVNA() returns a COM object to a PicoVNA108 device.
%
% Copyright: © 2017-2020 Pico Technology Ltd. All rights reserved.
%
% See also DISCONNECTVNA.

function [obj] = connectVNA_SN(serialNumber)
    % Create VNA COM object.
    obj = actxserver('PicoControl3.PicoVNA_3');

    % Check for an available VNA. 
    findPicoVNA = obj.FNDSN(serialNumber);
    
    if (findPicoVNA==0)
        error('ConnectVNA:VNANotFound', 'No PicoVNA device found.');
    end

end