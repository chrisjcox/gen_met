
function [rho_dry, rho] = calc_rho_air(T,rh,p)

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% AUTHORS:
%
%   Christopher Cox (NOAA) christopher.j.cox@noaa.gov
%
% REFERENCES:
%
%   Ideal Gas Law...
%
% PURPOSE:
% 
%   Calculate air density
%
% INPUT:
%
%   (may be vectors)
%   T = temperature in degC
%   rh = relative humidity wrt water in %
%   p = air pressure in hPa
%
% OUTPUT:
%
%   rho_dry = density of the dry air [kg m^-3]
%   rho = density of the moist air [kg m^-3]
%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Constants:
Rd = 287     ; % Gas constant, dry air [J K^-1 kg^-1]
Rv = 461     ; % Gas constant, water vapor [J K^-1 kg^-1]
p = p .* 100 ; % Air pressure from hPa to Pa

% Relative humidity to partial pressure
[Pw, ~] = calc_Pw_Pws(T,rh);

% Calculate
rho_dry = p ./ (Rd.*T);
rho_wet = p ./ (Rv.*T);
rho     = rho_dry.*((p-Pw)./p) + rho_wet.*(Pw./p);