function [zsci] = syn2sci(t,zsyn,mu)
%SYN2SCI Change of coordinates: from Sun-Planet synodic to Sun-centered
%inertial coordinates

if ( size(zsyn,2) ~= 1)
    zsyn = zsyn';
end 


%--------------------------------------------------------------------------
% Sun state in synodical coordinates
%--------------------------------------------------------------------------
zsyn_s = [-mu ; 0 ; 0 ;  0 ; 0 ; 0 ];

%--------------------------------------------------------------------------
% COC
%--------------------------------------------------------------------------
zsci = sciRotMat(t)*(zsyn - zsyn_s);

end


%--------------------------------------------------------------------------
% Subroutines
%--------------------------------------------------------------------------
function RotMat = sciRotMat(theta)
% Compute the rotation matrix associated to the angle theta
%
%   R =  | R11    0  |
%        | R21  R11  |
% with
%
%         | c -s 0 |          | -s -c 0 |
%   R11 = | s  c 0 |,   R21 = |  c -s 0 | 
%         | 0  0 1 |          |  0  0 0 |
% and
%       c = cos(theta), s = sin(theta)
%
% BLB 2016
RotMat11 = [+cos(theta) -sin(theta) 0; +sin(theta) +cos(theta) 0 ; 0 0 1];
RotMat21 = [-sin(theta) -cos(theta) 0; +cos(theta) -sin(theta) 0 ; 0 0 0];
RotMat   = [RotMat11 zeros(3) ; RotMat21 RotMat11];
end

