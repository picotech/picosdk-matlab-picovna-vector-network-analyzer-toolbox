function [frequency, data]=getBlockDataVNA(obj, Spara, datatype)
%obj is the VNA com object, Spara is the S parameter you want data for,
%datatype is the measurement type you want data for
%frequency will output a vector of the frquency values, data will ouput the
%data points for the measurement

%Get data from VNA
rawdata=obj.GetData(Spara,datatype,0);
%Split Data into frequency and data
splitdata=strsplit(rawdata,',');
%change from string to double for frequency
frequency=str2double(splitdata(:,1:2:end));
%change from string to double for data
data=str2double(splitdata(:,2:2:end));

end