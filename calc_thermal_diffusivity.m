
function alpha = calc_thermal_diffusivity(kair,rho,cp)

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% AUTHORS:
%
%   Christopher Cox (NOAA) christopher.j.cox@noaa.gov
%
% REFERENCES:
%
%   n/a
%
% PURPOSE:
% 
%   Calculates thermal diffusivity
%       
% INPUT:
%
%   (may be vectors)
%   kair = thermal conductivity in W m^-1 C^-1
%   cp = specific heat [m^2 s^-2 K^-1]
%   rho = density [kg m^-3]
%
% OUTPUT:
%
%   alpha = thermal diffusivity [m^2 s^-1]
%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

alpha = kair./(rho.*cp);