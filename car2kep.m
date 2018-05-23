function [a,e,i,OM,om,theta]=car2kep(mu,rv,vv)

% car2kep.m - calculates the orbital parameters starting from position 
%   and velocity vectors.
%
% PROTOTYPE:
%   [a,e,i,OM,om,theta] = car2kep(mu,rv,vv)
%
% DESCRIPTION:
%   This function returns all the orbit parameters as single scalars given
%   the position and velocity as vectors.
%
% INPUT:
%   rv[3,1]  vector position                       [km]
%   vv[3,1]  vector velocity                       [km/s]
%   mu       planetary constant                    [km^3/s^2]
%
% OUPUT:
%   a        semi-major axis                       [km]
%   e        orbital eccentricity                  []
%   i        inclination                           [rad]
%   OM       right ascension of the ascending node [rad]
%   om       argumentum of pericentre              [rad]
%   theta    true anomaly                          [rad]
%
% CALLED FUNCTIONS:
%   -
%
% CONTRIBUTORS:
%   Irene Cavallari
%   Giulia Bortolato 
% ------------------------------------------------------------------------

% CONTROL
if size(rv,2)>1
    rv=rv';
end 
if size(vv,2)>1
    vv=vv';
end 

% tern of the cartesian reference system
I=[1 0 0]';
J=[0 1 0]';
K=[0 0 1]';
% modulus of rv and vv
r=norm(rv);
v=norm(vv); 
% specific angular momentum [km^2/s] (vector hv and modulus h)
hv= cross(rv,vv);
h=norm(hv);
% orbital eccentricity (vector ev and modulus e)
ev=(1/mu)*( (v^2-mu/r)*rv - dot(rv,vv)*vv);
e=norm(ev);
% mechanical energy E
E=1/2*v^2-mu/r;
% semi-major axis a
if e~=1
    a= -mu/(2*E);
    p=a*(1-e^2);
else
    p=h^2/mu;
    %a=inf;
end
% inclination i
i=acos(dot(hv,K)/h);
% line of nodes 
if i~=0 && e~=0        %ELLIPTICAL INCLINED
    nv=cross(K,hv);
    % Right Ascension of ascending node
    OM=acos(dot(I,nv)/norm(nv));
    if dot(nv,J)<0
        OM=2*pi-OM;
    end
end
if i<1e-6 && e~=0        %ELLIPTICAL EQUATORIAL            
    nv=I;                
    %Right Ascension of ascending node
    OM=0;
end 
if i~=0 && e<1e-6        %CIRCULAR INCLINED
    nv=cross(K,hv);
    ev=nv;
    % Right Ascension of ascending node
    OM=acos(dot(I,nv)/norm(nv));
    if dot(nv,J)<0
        OM=2*pi-OM;
    end
end    
if i<1e-6 && e<1e-6        %CIRCULAR EQUATORIAL          
    nv=I;
    ev=I;               
    %Right Ascension of Ascending node
    OM=0;
end
% Anomaly of periapsis
om=acos(dot(nv,ev)/(norm(ev)*norm(nv))); 
if i<1e-6 && dot(ev,J)<0                    
    om=2*pi-om;
end
if dot(ev,K)<-1e-6
    om=2*pi-om;
end 

% True anomaly
theta=acos(dot(rv,ev)/(r*norm(ev)));
if dot(rv,vv)<0
    theta=2*pi-theta; 
end 

if e<1e-8
    e=0;
end
if i<1e-8
    i=0;
end
if om<1e-8
    om=0; 
end 
if OM<1e-8
    OM=0; 
end 


end 
