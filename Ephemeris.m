function [theta] = Ephemeris(date,body)
%EPHEMERIS 
% Computation of the true anomaly of a planet or of the moon around the sun
% at the given date
% input: 
%   - date:           julian dates for which the positions are calculated. It
%                     can be a scalar or column vector with M elements.
%                     Alternatively, the date can be given as a 2 element
%                     vector or M by 2 matrix. The first element can be a
%                     fixed Julian date and the second element can be the
%                     elapsed time between the fixed Julian date and the
%                     ephemeris time. 
%  - target:          String defining the planet or point of interest for
%                     which the position and velocity is calculated. It can
%                     be: 'Sun', 'Mercury', 'Venus', 'Earth', 'Moon', 'Mars',
%                     'Jupiter', 'Saturn', 'Uranus', 'Neptune','Pluto',
%                     'SolarSystem' (for the Solar System barycenter) and
%                     'EarthMoon' (for the Earth-Moon barycenter).
%
% OUTPUT: true anomaly [rad]
% Reference frame adopted: International Celestial Reference Frame (adopted
% in 2010) (the ecliptic sun centered reference frame).

mu_sun = 0.19891000000000E+31*6.67259e-20;

[pos,vel] = planetEphemeris(date,'Sun',body,'423');
kep = car2kep(mu_sun,pos,vel);

theta = kep(6);

end

