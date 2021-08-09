function [D,theta_bd] = DrawMainArm(rab,rad,A,B,theta_ab,rot_y)
%[D,theta_bd] = DrawMainArm(rab,rad,A,B,theta_ab,rot_y)
% This function computes angle theta_bd and locates coordinate D by simple
% trigonometry as the main arm is a rigid body
%   
% Inputs:
% rab (real scalar, positive) equals length of side ab in mm
% rad (real scalar, positive) equals length of side ad in mm
% A (row vector of form [x y z]) equals location of point A
% B (row vector of form [x y z]) equals location of point B
% rab (real scalar, positive) equals length of side ab in mm
% theta_ab (real scalar, positive, less than 2*pi) equals value of theta ab
%       in radians
% rot_y (3x3 rotation matrix for rotation around global coordinate system
%       if swivel is required
%
% Outputs:
% D as calculated by vector addition
% theta_bd (real scalar) equals angle bd as calculated by simple
%       trigonometry
%
% Version 5: created 15/03/21. Author: Robert Burke


%% Test Validity of user inputs
if(~isscalar(rab)) || (~isreal(rab)) ||  rab <= 0
    error('Input argument rab must a positive real scalar above 0')
elseif(~isscalar(rad)) || (~isreal(rad)) ||  rad <= 0
    error('Input argument rad must a positive real scalar above 0')
elseif(~isscalar(theta_ab)) || (~isreal(theta_ab))
    error('Input argument theta_ab must a positive real scalar')
elseif(size(A) ~= [1 3])
    error('Input argument A must be a 1x3 row vector')
elseif(size(B) ~= [1 3])
    error('Input argument B must be a 1x3 row vector')
elseif(size(rot_y) ~= [3 3]) 
    error('Input argument B must be a 3x3 matrix')
end

%% Calculation of internal angles of rigid body referenced to +ve x-axis
theta_ad = theta_ab + (pi/12);
theta_bd = theta_ad + (pi/12);

D = [rad*cos(theta_ad)+A(1) rad*sin(theta_ad)+A(2) 0];  % Locate D

%% Create data for patch creation
plane = [A;B;D];    % Initial vertices data
depth = 100;    % desired thickness/extrusion of body

surface_offset = [0 0 depth/2; 0 0 depth/2; 0 0 depth/2];

surface1 = plane + (ones(3,3)*surface_offset);      % Create upper surface
surface2 = plane - (ones(3,3)*surface_offset);      % Create lower surface

% Rotate body using inputed rotation matrix if swivel is required
body = [surface1*rot_y;surface2*rot_y];

% Order faces
faces = [1 2 3 3;4:6 6;1 2 5 4; 1 3 6 4; 2 3 6 5];

% Create Patch
main_arm = patch('Faces',faces,'Vertices',body,'FaceColor',[0.5 0.5 0.5],'Linestyle','none','FaceLighting','phong');
set(main_arm,'DiffuseStrength',1.0,'SpecularStrength',1.0);

%% Draw rotation axles

DrawRotationAxles(B,0.75*depth,rot_y);
DrawRotationAxles(D,0.75*depth,rot_y);


end

