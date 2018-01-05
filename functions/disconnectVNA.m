%% DisconnectVNA
%
%% Desciption
% DISCONNECTVNA Closes the connection to the PicoVNA device.
%
%   disconnectVNA(obj) closes the connection to the VNA and deletes the COM
%   Object from the workspace:
%
%   obj - the COM object pointing to the PicoVNA device.
%
% Copyright: © 2017-2018 Pico Technology Ltd. All rights reserved.
%
% See also CONNECTVNA.

function disconnectVNA(obj)
    %Check inputs are valid
    validateattributes(obj,{'COM.PicoControl2_PicoVNA__2'},{});
    
    % Close connection to PicoVNA.
    obj.CloseVNA();

    % Delete VNA COM object from the workspace.
    delete(obj);

end