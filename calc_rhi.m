
function rhi = calc_rhi(T,rh)

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% AUTHORS:
%
%   Christopher Cox (NOAA) christopher.j.cox@noaa.gov
%
% REFERENCES:
%
%   Hyland, R.W. & A. Wexler (1983) Formulations for the thermodynamic 
%       properties of the saturated phases of H2O from 173.15 K to 
%       473.15 K. ASHRAE Trans. 89, 500–519 (1983).
%
% PURPOSE:
% 
%   Calculate relative humidity with respect to ice.
%
% INPUT:
%
%   T = temperature in K; may be a vector
%   rh = relative humidity wrt water in %
%
% OUTPUT:
%
%   kair = thermal conductivity in W m^-1 C^-1
%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Get the saturation vapor pressure over water
[Pw, Pws] = calc_Pw_Pws(T,rh);

% RHi, the saturation vapor pressure over ice, then finally RHI, Hyland & Wexler (1983)

% Saturation vapor pressure over ice (Eq. 18)
c0 = -0.56745359*1e4   ;    
c1 =  0.63925247*1e1   ;
c2 = -0.96778430*1e-2  ;
c3 =  0.62215701*1e-6  ;
c4 =  0.20747825*1e-8  ;
c5 = -0.94840240*1e-12 ;
D  =  0.41635019*1e1   ;

term = (c0.*T.^(-1)) + (c1.*T.^(0)) + (c2.*T.^(1)) + (c3.*T.^(2)) + (c4.*T.^(3)) + (c5.*T.^(4)); 
Psi = exp(term + (D.*log(T))); % Pa

% Convert RHw to RHi
rhi = 100.*(rh.*0.01.*Pws)./Psi;