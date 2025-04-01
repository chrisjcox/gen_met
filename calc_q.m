
function [q,r] = calc_q(vp,p)

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% AUTHORS:
%
%   Christopher Cox (NOAA) christopher.j.cox@noaa.gov
%
% REFERENCES:
%
%   Bolton, D. (1980) The computation of equivalent potential temperature.
%       Mon. Weath. Rev., 108, 1046-1053, 
%       https://doi.org/10.1175/1520-0493(1980)108<1046:TCOEPT>2.0.CO;2
%
%   Harrison, L.P. (1965) Some fundamental considerations regarding 
%       psychrometry. In Humidity and Moisture: Measurement and Control in 
%       Science and Industry. A. Wexler, Ed., Reinhold, New York.
%       - refer to page 27
%
% PURPOSE:
% 
%   Calculate specific humidity using a common formula.
%
% INPUT:
%
%   vp = vapor pressure [hPa]
%   p = total pressure [hPa]
%
% OUTPUT:
%
%   q = specific humidity [hPa]
%   r  = mixing ratio
%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


r = (vp .* 0.622) ./ (p - vp); % mixing ratio (e.g., Bolton, 1980)  

q = r ./ (1 + r); % from mixing ratio to specific humidity.