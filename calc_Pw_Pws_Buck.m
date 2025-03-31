
function es = calc_Pw_Pws_Buck(T,p,phase_flag,year)

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% AUTHORS:
%
%   Christopher Cox (NOAA) christopher.j.cox@noaa.gov
%
% REFERENCES:
%
%   Buck, A.L. (1981) New equations for computing vapor pressure and
%       enhancement factor. J. Apple. Meteorol., 20, 1527-1532,
%       https://doi.org/10.1175/1520-0450(1981)020<1527:NEFCVP>2.0.CO;2
%
%   Buck, A.L. (1996) Model CR-1A Hygrometer with Autofill. Buck Research
%       Instruments, CR-1A-users-manual-2009-12.
%       https://www.hygrometers.com/wp-content/uploads/ ...
%       CR-1A-users-manual-2009-12
%
% PURPOSE:
% 
%   Calculate saturation vapor pressure over water and ice.
%   We usually use 1981, but there were some updates in 1996 that provide
%   slightly better agreement with Vaisala (calc_Pw_Pws.m) at cold
%   temperatures. Notably, ifthe enhancement factor (EF) is ignored, the
%   agreement with Vaisala is better than 0.02% from -10 to +30 C. It's
%   more like 0.2% with it.
%
% INPUT:
%
%   (may be a vector)
%   T = temperature in C
%   p = air pressure in mb
%   phase_flag = 'ice' or 'water'
%   (optional) year = 1981 or 1996 (default 1996)
%
% OUTPUT:
%
%   es = saturation vapor presure [hPa]
%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if nargin < 4
    year = 1996;
end

% determine equation then determine coefficients then calculate

switch year

    case 1996

        switch phase_flag

            case 'water'

                % WATER %
        
                % coefficients
                a = 6.1121;
                b = 18.678;
                c = 257.14;
                d = 234.5;
                % enhancement factor
                EF = 1 + 1e-4.*(7.2 + p.*(0.0320 + 5.9e-6.*T.^2));

            case 'ice'

                 % ICE %
        
                % coefficients
                a = 6.1115;
                b = 23.036;
                c = 279.82;
                d = 333.7;
                % enhancement factor
                EF = 1 + 1e-4.*(2.2 + p.*(0.0383 + 6.4e-6.*T.^2));

        end

        % calculation
        es = EF .* a .* exp( (b - (T./d)) .* (T./(T+c)) );     

    case 1981

         switch phase_flag

            case 'water'

                % WATER %
        
                % coefficients
                a = 1.0007;
                b = 3.46e-6;
                c = 6.1121;
                d = 17.502;
                f = 240.97;

            case 'ice'

                 % ICE %
        
                % coefficients
                a = 1.0003;
                b = 4.18e-6;
                c = 6.1115;
                d = 22.452;
                f = 272.55;

        end

        % calculation
        es = ( a + (b.*p) ) .* c .* exp( (d.*T) ./ (f + T) );

end