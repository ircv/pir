clear all; close all; 

%% init
init;
default.plot.XY = false;
default.diff_corr.type=cst.corr.X0_FIXED;
default.plot.firstPrimDisp=false;
default.plot.allLibPoints=false;

%% cr3bp initializzation
cr3bp=init_CR3BP('EARTH','MOON',default);

%% Initialization of the orbit
orbit = init_orbit(cr3bp, ...                     % Parent CR3BP
                   cr3bp.l2, ...                  % Parent libration point is EML2
                   cst.orbit.type.HALO, ...       % Halo orbit
                   cst.orbit.family.NORTHERN, ... % Northern class
                   70000, ...                     % Of vertical extension Az ~ 12000km
                   cst,...                        % Numerical constants
                   cst.orbit.subtype.NRO);        % The orbit desired is an NRO
%% Orbit
orbit=orbit_computation(cr3bp,orbit,default,cst);
% hold on;
% orbit2=nro_interpolation(cr3bp,orbit,nro_init_EML2,default,cst,'Az',orbit.Azdim);

% %% Manifold
% 
%% Stop plotting on Figure 1
default.plot.XY = false;
% 
%% Integration duration: arbitrarily fixed to 22 days
t = 70*cst.env.days*2*pi/cr3bp.T;
% 
%% Initialization of the manifold
 msi = init_manifold_branch(cst.manifold.UNSTABLE,...    %it is an UNSTABLE manifold.
                            cst.manifold.INTERIOR);      %it is an INTERIOR manifold: it will go towards the Moon.
                      
%% Computation of the manifold
msi = manifold_branch_computation   (cr3bp,orbit,msi,1,t,default,cst);  
