clear all; close all; 

%% init
init;

%% cr3bp initializzation
cr3bp=init_CR3BP('EARTH','MOON',default);


%% Initialization of the orbit
orbit = init_orbit(cr3bp, ...                     % Parent CR3BP
                   cr3bp.l2, ...                  % Parent libration point is EML2
                   cst.orbit.type.PLYAP, ...      % Planar Lyapunov orbit
                   cst.orbit.family.PLANAR, ... % Northern class
                   70000, ...                     % Of vertical extension Az ~ 12000km
                   cst);                          % Numerical constants
               
%% Orbit
orbit=orbit_computation(cr3bp,orbit,default,cst);