
function [Pw, Pws] = calc_Pw_Pws(T,rh)

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% AUTHORS:
%
%   Christopher Cox (NOAA) christopher.j.cox@noaa.gov
%
% REFERENCES:
%
%   Milosevich, L.M., H. Vomel, D.N. Whitemand, & T. Leblanc (2009)
%       Accuracy assessment and correction of Vaisala RS92 radiosonde water
%       vapor measurements. J. Geophys. Res.: Atmos. 114, D11303, 
%       https://doi.org/10.1029/2008JD011565
%
%   Vaisala (2015) User's Guide: PTU300. Vaisala. 
%
%
%   Wexler, A. (1976) Vapor pressure formulation for water in range 0 to
%       100 °C: A revision. J. Res. Natl. Bur. Stand. Tech., Sect. A 80, 
%       775–785, https://doi.org/10.6028/jres.080A.071
%
% PURPOSE:
% 
%   Calculate saturation vapor pressure over water.
%
% INPUT:
%
%   T = temperature in K; may be a vector
%   rh = relative humidity wrt water in %
%
% OUTPUT:
%
%   Pws = saturation vapor pressure [Pa]
%   Pw  = actual vapor pressure [Pa]
%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Calculate saturation vapor pressure (Pws) using two equations sets. 
% This follows Wexler (1976), but the formulation and coefficients are 
% supplied by Vaisala. We are often working with PTU300 output so it's
% important to be consistent (Milosovich et al, 2009).
%
% Vaisala Eq. (5)
c0    = 0.4931358        ;
c1    = -0.46094296*1e-2 ;
c2    = 0.13746454*1e-4  ;
c3    = -0.12743214*1e-7 ;
omega = T - ( c0.*T.^0 + c1.*T.^1 + c2.*T.^2 + c3.*T.^3 );

% Vaisala Eq. (6)
bm1 = -0.58002206*1e4    ;
b0  = 0.13914993*1e1     ;
b1  = -0.48640239*1e-1   ;
b2  = 0.41764768*1e-4    ;
b3  = -0.14452093*1e-7   ;
b4  = 6.5459673          ;
Pws = exp( ( bm1.*omega.^-1 + b0.*omega.^0 + b1.*omega.^1 + b2.*omega.^2 + b3.*omega.^3 ) + b4.*log(omega) ); % SVP [Pa]

% Vaisala Eq. (7)
Pw = rh.*Pws./100; % VP [Pa]