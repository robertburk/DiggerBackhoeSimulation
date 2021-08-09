function [F,H,theta_df,theta_dh,theta_fh] = DrawSecondArm(rde,D,E,theta_de,rotation)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

%% Generate point coordinates
rdf = rde;
rdh = 2256;

theta_df = theta_de + (pi/6);
theta_dh = theta_df + (11/18)*pi;
theta_fh = theta_dh + pi/18;

F = D + [rdf*cos(theta_df) rdf*sin(theta_df) 0];
H = D + [rdh*cos(theta_dh) rdh*sin(theta_dh) 0];
plane = [D;E;F;H];
depth = 100;

%% Draw Surfaces
surface_offset = [0 0 depth/2; 0 0 depth/2; 0 0 depth/2];
surface1 = plane + (ones(4,3)*surface_offset);
surface2 = plane - (ones(4,3)*surface_offset);


body = [surface1*rotation;surface2*rotation];

faces = [1 2 3 4;5 6 7 8;1 2 6 5; 1 4 8 5; 2 3 7 6;3 4 8 7];

secondarm = patch('Faces',faces,'Vertices',body,'FaceColor',[0.5 0.5 0.5],'LineStyle','none','FaceLighting','phong');
set(secondarm,'DiffuseStrength',1.0,'SpecularStrength',1.0);

DrawRotationAxles(F,0.75*depth,rotation);
DrawRotationAxles(E,0.75*depth,rotation);

end

