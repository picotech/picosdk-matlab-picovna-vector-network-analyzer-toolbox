function [frequency, data] = getBlockDataVNA(obj, Spara, datatype)
% GETBLOCKDATAVNA Returns frequency and data points.
%   getBlockDataVNA(obj, Spara, datatype) returns frequency and data points
%   from a measurement sweep performed by a PicoVNA on a DUT.
%   The Measure command should be called on the COM object corresponding to
%   the PicoVNA device before calling this function.
%
% *Input arguments:*
%
%   obj - the VNA COM object corresponding to the PicoVNA device
%   Spara - the S parameter for which data is required
%   datatype - the measurement type for which you require data 
%
% *Output arguments:*
%
%   frequency - a vector of the frequency values
%   data - a vector of data points for the measurement
%
% Copyright: � 2017-2018 Pico Technology Ltd. All rights reserved.

    % Get data from VNA.
    rawdata = obj.GetData(Spara,datatype,0);
    
    % Split Data into frequency and data.
    splitdata = strsplit(rawdata,',');
    
    % Change from string to double for frequency.
    frequency = str2double(splitdata(:,1:2:end));
    
    % Change from string to double for data.
    data = str2double(splitdata(:,2:2:end));

end