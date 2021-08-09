function [ ] = DrawRotationAxles(A,depth,rotation)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

r = 40;
N = 100; % Number of points on circular cross section

% phi = [0:360/N:360-(360)/N]';
phi = [0:(2*pi)/N:(2*pi)-(2*pi)/N]'; 

verticeslowA = [r*cos(phi) r*sin(phi) depth*ones(N,1)]+A;
verticeshighA = [r*cos(phi) r*sin(phi) -depth*ones(N,1)]+A;
verticesA = [verticeslowA*rotation;verticeshighA*rotation];


faces = [[1:100];[1:100]' [[2:100] 1]' [(100+[2:100]) 101]' ((100+[1:100])')*ones(1,97);100+[1:100]];
rotation_axles = patch('Vertices',verticesA,'Faces',faces,'FaceColor','black','LineStyle','none','FaceLighting','phong');
set(rotation_axles,'DiffuseStrength',1.0,'SpecularStrength',1.0);

end

