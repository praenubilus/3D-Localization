classdef LocalizationManager < handle
	%UNTITLED Preliminary work to make the python integration its own class
	%   Detailed explanation goes here
	
	properties
		IP;
		Port;
		
		BeaconIds = {};
		Conns = {};
	end
	
	methods
		function obj = LocalizationManager(ip, port, varargin)
			obj.IP = ip;
			obj.Port = port;
			
			PyPath = py.sys.path;
			if PyPath.count('.') == 0
			   insert(PyPath,int32(0),'.');
			end
			PyModule = py.sys.modules;
			if isa(PyModule.get('udpclient'),'py.NoneType')
				py.importlib.import_module('udpclient');
			end
			
			for i = 1:nargin
				obj.BeaconIds{i} = varargin(i);
				obj.Conns{i} = py.udpclient.udp_factory(ip,uint16(port),uint16(obj.BeaconIds(i)));
			end
		end
	end
	
end

