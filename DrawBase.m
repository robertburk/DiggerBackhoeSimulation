function [A,C] = DrawBase(theta_ab,rotation)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

ra = 300;
rc = ra;

theta_a = deg2rad(135)+theta_ab;
theta_c = deg2rad(45)+theta_ab;

r1 = [0 0 0];
A = [(ra)*(cos(theta_a)) (ra)*(sin(theta_a)) 0]; %LHS base
C = [(rc)*(cos(theta_c)) (rc)*(sin(theta_c)) 0 ];   %RHS Base

depth = 150;
thickness = 120;
plane = [r1;A;C];


surface_offset = [0 0 depth/2; 0 0 depth/2; 0 0 depth/2];
wall_offset = [0 0 thickness/2; 0 0 thickness/2; 0 0 thickness/2];
surface1 = plane + (ones(3,3)*surface_offset);
surface2 = plane - (ones(3,3)*surface_offset);
surface3 = plane + (ones(3,3)*wall_offset);
surface4 = plane - (ones(3,3)*wall_offset);


body = [surface1*rotation;surface2*rotation;surface3*rotation;surface4*rotation];

faces = [1 2 3 3;4 5 6 6;1 2 8 7; 1 3 9 7; 2 3 8 9;4 5 11 10;4 6 12 10;5 6 12 11;];

base = patch('Faces',faces,'Vertices',body,'FaceColor','yellow','LineStyle','none','FaceLighting','phong');
set(base,'DiffuseStrength',1.0,'SpecularStrength',1.0);


DrawRotationAxles(A,0.75*(thickness + depth),rotation);
DrawRotationAxles([0 0 0],0.75*(thickness+depth),rotation);
DrawRotationAxles(C,0.75*(thickness+depth),rotation);
end

