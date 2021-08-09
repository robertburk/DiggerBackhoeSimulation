function [ ] = DrawYellowRocker(I,G,K,L,H,theta,rotation)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%% Generate Rocker Data
plane = [I;G;K];
depth = 200;
surface_1 = plane + [ 0 0 (depth/2)];
surface_2 = plane + [ 0 0 (-depth/2)];

vertices = [surface_1*rotation;surface_2*rotation];
faces = [1 2 3 3;4 5 6 6; 1 2 5 4;2 3 6 5; 1 3 6 4];

%% Generate remaining link
width = 40;

K1 = K + width*[cos(theta) sin(theta) 0];
K2 = K - width*[cos(theta) sin(theta) 0];
L1 = L + width*[cos(theta) sin(theta) 0];
L2 = L - width*[cos(theta) sin(theta) 0];

vertices_low = [K1;L1;L2;K2] + [0 0 -depth/2];
vertices_high = [K1;L1;L2;K2] + [0 0 depth/2];
vertices_link = [vertices_low*rotation;vertices_high*rotation];

faces_link = [ 1:4; 5:8; [1:3]' [2:4]' [6:8]' [5:7]';4 1 5 8];


rocker = patch('Faces',faces,'Vertices',vertices,'FaceColor',[1 1 0],'LineStyle','none','FaceLighting','phong');
set(rocker,'DiffuseStrength',1.0,'SpecularStrength',1.0);
link = patch('Faces',faces_link,'Vertices',vertices_link,'FaceColor',[1 1 0],'LineStyle','none','FaceLighting','phong');
set(link,'DiffuseStrength',1.0,'SpecularStrength',1.0);

DrawRotationAxles(I,0.75*depth,rotation);
DrawRotationAxles(K,0.75*depth,rotation);
DrawRotationAxles(L,0.75*depth,rotation);
DrawRotationAxles(H,0.75*depth,rotation);
DrawRotationAxles(G,0.75*depth,rotation);

end

