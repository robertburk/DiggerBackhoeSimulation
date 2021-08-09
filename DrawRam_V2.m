function [ ] = DrawRam_V2(B,B2,A,r_ram,r_housing,theta,rotation)
%DrawRam_V2(B,B2,A,r_ram,r_housing,theta)
% Creates the ram given  
% a slider-crank mechanism
%
% Inputs:
% rab (real scalar, positive) equals length of side ab in mm
% theta_ab (real scalar, positive, less than 2*pi) equals initial estimate 
%       for unknown angle ab in radians
% rcb (real scalar, positive) equals length of side ab in mm
% theta_cb (real scalar, positive, less than 2*pi) equals initial estimate 
%       for unknown angle cb in radians
% rac (real scalar, positive) equals length of side ab in mm
% theta_ac (real scalar, positive, less than 2*pi) equals known angle in
%       radians
%
% Outputs:
% theta_ab (real scalar, positive, less than 2*pi) equals angle ab as 
%       as calculated using closure equations using the Newton Raphson 
%       for a system of equations
% theta_cb (real scalar, positive, less than 2*pi) equals angle cb as 
%       as calculated using closure equations using the Newton Raphson 
%       for a system of equations
%
% Version 7: created 115/03/21. Author: Robert Burke

% assume p1 is [x y z] vector

% Create rotation Matrix
rotation_matrixz =[cos(theta) (-sin(theta)) 0;sin(theta) cos(theta) 0;0 0 1];

% Initialise the number of vertices
N = 100;    %   Number of vertices on circular cross section
phi = [0:(2*pi)/N:(2*pi)-(2*pi)/N]';    %   Angle between each vertices


ram_circle_data = rotation_matrixz*[(r_ram)*(cos(phi)) ones(N,1) (r_ram)*(sin(phi))]';
housing_circle_data = rotation_matrixz*[(r_housing)*(cos(phi)) ones(N,1) (r_housing)*(sin(phi))]';



v_ram_low = ram_circle_data'+[A(1) A(2) 0];
v_ram_high = ram_circle_data'+[B2(1) B2(2) 0];
vertices_ram = [v_ram_low*rotation;v_ram_high*rotation];

v_housing_low = housing_circle_data'+[B2(1) B2(2) 0];
v_housing_high = housing_circle_data'+[B(1) B(2) 0];
vertices_housing = [v_housing_low*rotation;v_housing_high*rotation];



faces = [[1:100];[1:100]' [[2:100] 1]' [(100+[2:100]) 101]' ((100+[1:100])')*ones(1,97);100+[1:100]];
patch('Vertices',vertices_ram,'Faces',faces,'FaceColor',[0.6 0.6 0.6],'LineStyle','none','FaceLighting','phong');
patch('Vertices',vertices_housing,'Faces',faces,'FaceColor',[0 0 0],'LineStyle','none','FaceLighting','phong');

end

