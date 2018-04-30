clear all; close all; 

%% init
init;
default.diff_corr.type=cst.corr.X0_FIXED;

%% cr3bp initializzation
cr3bp=init_CR3BP('EARTH','MOON',default);

%% Initialization of the orbit
orbit = init_orbit(cr3bp, ...                     % Parent CR3BP
                   cr3bp.l2, ...                  % Parent libration point is EML2
                   cst.orbit.type.HALO, ...       % Halo orbit
                   cst.orbit.family.NORTHERN, ... % Northern class
                   65000, ...                     % Of vertical extension Az ~ 12000km
                   cst);                          % Numerical constants
%% Orbit
% orbit=orbit_computation(cr3bp,orbit,default,cst);
orbit = halo_orbit_interpolation(cr3bp,orbit, halo_init_EML2, default, cst);
