function orbit = orbit_computation(cr3bp, orbit, params, cst)
% ORBIT_COMPUTATION generic routine for the computation of halo, nro, vertical
% and planar lyapunov symmetric periodic orbits in the CRTBP.
%
% ORBIT = ORBIT_COMPUTATION(CR3BP, ORBIT, PARAMS, CST) is the default call
% to compute an orbit in the system CR3BP, with the desired characteristics
% listed in the structure ORBIT (size or energy, lagrange point).
% It makes use of a third-order richardson first guess to initialize the
% initial conditions.
% Then, a differential correction process is applied to get a real periodic
% orbit.
% Finally, a post process routine is applied in order to compute various
% characteristics of the orbit, listed below. Depending on the user-defined
% parameter structure PARAMS, the result can be plotted at the end of the
% routine.
%
% See Koon et al. 2006, chapter 6, for details <a href="matlab:
% web('http://www.cds.caltech.edu/~marsden/volume/missiondesign/KoLoMaRo_DMissionBook_2011-04-25.pdf','-browser')">(link)</a>.
%
% At the end of this routine, the following parameters are updated in the
% orbit structure:
%
%   - ORBIT.y0:  the initial conditions.
%   - ORBIT.T12: the half period.
%   - ORBIT.T:   the full period.
%   - Either the couple (Az, Azdim) - vertical extension for halo and
%   vertical orbits, or the couple (Ax, Axdim), maximum planar extension
%   for planar lyapunov orbits.
%   - ORBIT.C: the jacobian constant
%   - ORBIT.E: the energy
%   - ORBIT.yv: the state along the orbit on a given grid over the interval
%   [0, orbit.T].
%   - ORBIT.monodromy: the monodromy matrix.
%   - ORBIT.eigenvalues: the eigenvalues of the monodromy matrix in vector
%   form.
%   - ORBIT.stable_direction: the stable eigenvector of the monodromy
%   matrix.
%   - ORBIT.unstable_direction: the unstable eigenvector of the monodromy
%   matrix.
%
%
% BLB 2016

if ( strcmp(orbit.type,cst.orbit.type.PLYAP) || (~strcmp(orbit.type,cst.orbit.type.PLYAP) && orbit.Azdim<=30000) ) 
    %----------------------------------------------------------------------
    % Initialization from third order Richardson approximation.
    % The initial conditions are taken on the plane y = 0, at t = 0.0
    %----------------------------------------------------------------------
    yvg   =  third_order_orbit(orbit, 0.0, cst);
    % ---------------------------------------------------------------------
    % Computation with default parameters. This step makes use of a
    % differential correction process.
    %----------------------------------------------------------------------
    orbit = orbit_refinement(cr3bp, orbit, params, yvg, cst);

    else         
        %------------------------------------------------------------------
        % First computation: a true orbit is computed with a simple 
        % 3-dimensionnal differential corrector scheme 
        % (no pseudo-arclength). The z component of the initial state is 
        % fixed.
        %------------------------------------------------------------------
        if ( orbit.li.number == 1 )
            work_orbit= init_orbit(cr3bp, cr3bp.l1, orbit.type, cst.orbit.family.NORTHERN,2000,cst);   
        else
            work_orbit = init_orbit(cr3bp,cr3bp.l2, orbit.type, cst.orbit.family.NORTHERN,8000,cst);
        end       
        % Initialization from third order approximation
        yvg =  third_order_orbit(work_orbit, 0.0, cst);
        % Computation with default parameters
        work_orbit = orbit_refinement(cr3bp, work_orbit, params, yvg, cst, cst.corr.Z0_FIXED);
        work_orbit = orbit_postprocess(cr3bp,work_orbit,params,cst);
        %------------------------------------------------------------------
        % Second computation: initialized by the previous computation, a 
        % new orbit is obtained with a 4-dimensional differential corrector.
        % The z component is now part of the free variables. The objects 
        % necessary to go on with the continuation are initialized in orbit.
        % cont (free-variables vector,null vector of the Jacobian).
        %------------------------------------------------------------------
        work_orbit = orbit_refinement(cr3bp, work_orbit, params, work_orbit.y0, cst, cst.corr.MIN_NORM);
        work_orbit = orbit_postprocess(cr3bp,work_orbit,params,cst);
        % Arclength stepsize
        work_orbit.cont.ds = 0.01;
        % Loop
        datas.initialconditions(1,:)=work_orbit.y0(1:6)';
        datas.Az(1)=work_orbit.Azdim;
        i=2;stop=0;
        fprintf ('orbit computation in progress...');
        while (i>=stop)
            work_orbit = orbit_refinement_cont(cr3bp, work_orbit, params, cst);
            datas.Az(i)=work_orbit.Azdim;
            datas.initialconditions(i,:)=work_orbit.y0(1:6)';
            if ( (orbit.Azdim<datas.Az(i) && orbit.Azdim>datas.Az(i-1)) || (orbit.Azdim>datas.Az(i) && orbit.Azdim<datas.Az(i-1)) )
                if ( strcmp(orbit.subtype,cst.orbit.subtype.NRO) )
                    pos = work_orbit.perigee.position;
                    if( abs(pos(1) - cr3bp.m2.pos(1)) < cr3bp.m2.Rm/cr3bp.L && work_orbit.perigee.altitude > 0 )
                        stop=i+6;
                    end
                else
                    stop=i+6;
                end
            end
            i=i+1;
         end
         fit = interpol(datas, datas.Az, orbit.Azdim);
        %------------------------------------------------------------------
        % Third Computation: Interpolation results
        %------------------------------------------------------------------
        yv0 = fit.f(1:6);
        if( strcmp(orbit.family,cst.orbit.family.SOUTHERN) )
            yv0(3) = -yv0(3);
        end
        %------------------------------------------------------------------
        % Fourth Computation: differential correction
        %------------------------------------------------------------------
        orbit = orbit_refinement(cr3bp, orbit, params, yv0, cst);
end

%--------------------------------------------------------------------------
% Postprocess. After this step, the following elements are updated in the
% orbit structure:
%
%   - Either the couple (Az, Azdim) - vertical extension for halo and
%   vertical orbits, or the couple (Ax, Axdim), maximum planar extension
%   for planar lyapunov orbits.
%   - orbit.C: the jacobian constant
%   - orbit.E: the energy
%   - orbit.yv: the state along the orbit on a given grid over the interval
%   [0, orbit.T].
%   - orbit.monodromy: the monodromy matrix.
%   - orbit.eigenvalues: the eigenvalues of the monodromy matrix in vector
%   form.
%   - orbit.stable_direction: the stable eigenvector of the monodromy
%   matrix.
%   - orbit.unstable_direction: the unstable eigenvector of the monodromy
%   matrix.
%--------------------------------------------------------------------------
orbit = orbit_postprocess(cr3bp, orbit,params,cst);
% --------------------------------------------------------------------------
% Plotting (potentially)
% --------------------------------------------------------------------------
if(params.plot.orbit) %plotting
    orbit_plot(orbit, params);
end

end

function fit = interpol(abacus, data, value)

fit.half = 2;
[~, array_position] = min(abs(data - value));
mini = max(array_position - fit.half, 1);
maxi = min(array_position + fit.half, length(data));
fit.degree = length(mini:maxi)-1;
fit.x =  data(mini:maxi)';
for count =1:6
    fit.y(:,count) =  abacus.initialconditions(mini:maxi,count);
    %Fitting for every dimension of the state (6)
    [fit.p, ~, fit.mu] = polyfit(fit.x,fit.y(:,count),fit.degree);
    %Evaluation
    fit.f(count) = polyval(fit.p,value,[],fit.mu);
end

end
