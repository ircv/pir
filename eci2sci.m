function [zsci] = eci2sci(t,zeci,mu,dist_se,epsilon)
%ECI2SCI from earth centered reference system to sun centered reference
%system

if ( size(zeci,2) ~= 1)
    zeci = zeci';
end

% rotation 
RotMat=[0 0 1; cos(epsilon) sin(epsilon) 0; -sin(epsilon) cos(epsilon) 0];
zeci = RotMat*zeci;

% position of the earth around the sun
ze = dist_se*[cos(t) sin(t) 0]';

% velocity of the earth around the sun
ve = sqrt(mu/dist_se)*[-sin(t) cos(t) 0]';

% earth state vector
esci = [ze; ve];

% output
zsci = esci + zeci;


end

