function [ ] = DrawCylinder(r1,h)

%[ ] = DrawCylinder(r1,h)
%   Draws cylinder assuming constant radius

N = 100; % Number of points on circular cross section

phi = [0:(2*pi)/N:(2*pi)-(2*pi)/N]';

verticeslow = [r1*cos(phi) r1*sin(phi) zeros(N,1)];
verticeshigh = [r1*cos(phi) r1*sin(phi) h*ones(N,1)];
vertices = [verticeslow;verticeshigh];


faces = [[1:100];[1:100]' [[2:100] 1]' [(100+[2:100]) 101]' ((100+[1:100])')*ones(1,97);100+[1:100]];
disp(faces);
patch('Vertices',vertices,'Faces',faces,'FaceColor',[1 0 0],'LineStyle','none','FaceLighting','phong');
axis([-1.5*r1 1.5*r1 -1.5*r1 1.5*r1 -1.5*h 1.5*h]);
light('Position',[-1 -1 -2]);
end

