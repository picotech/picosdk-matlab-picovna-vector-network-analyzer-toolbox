%% disconnectVNA
%
%% Description
%
% disconnectVNA(obj) closes the connection to the VNA and deletes the COM
% Object from the workspace:
%
% *Input Arguments:*
%
% * obj - the COM object pointing to the PicoVNA device.
% 
%
% See also <connectVNA.html connectVNA> .


function disconnectVNA(obj)

    % Check inputs are valid
    validateattributes(obj,{'COM.PicoControl2_PicoVNA__2'},{});
    
    % Close connection to PicoVNA.
    obj.CloseVNA();

    % Delete VNA COM object from the workspace.
    delete(obj);

end
%%
% Copyright: � 2017-2018 Pico Technology Ltd. All rights reserved.