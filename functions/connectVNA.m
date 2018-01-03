function [obj]=connectVNA()
%Create the VNA COM object and check that there is a VNA connected and
%avaliable for Matlab to use

%Create VNA COM object
obj=actxserver('PicoControl2.PicoVNA_2');

%check for an avaliable VNA 
findPicoVNA=obj.FND;
if (findPicoVNA==0)
    error('No VNA found')
end

end