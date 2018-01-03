function disconnectVNA(obj)
%Disconnect the VNA and delete the COM Object from the workspace

%Close VNA
obj.CloseVNA();

%Delete VNA COM object from the workspace
delete(obj);

end