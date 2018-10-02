%% disconnectVNA_2
%
%% Description
%
% |disconnectVNA_2(obj)| closes the connection to the VNA and deletes the COM
% Object from the workspace:
%
% *Input Arguments:*
%
% * |obj| - the COM object pointing to the PicoVNA device.
% 
%
% See also <connectVNA_2.html connectVNA_2> .


function disconnectVNA_2(obj)

    % Check inputs are valid
    validateattributes(obj,{'COM.PicoControl2__2_PicoVNA__2__2'},{});
    
    % Close connection to PicoVNA.
    obj.CloseVNA();

    % Delete VNA COM object from the workspace.
    delete(obj);

end
%%
% *Copyright:* © 2017-2018 Pico Technology Ltd. All rights reserved.