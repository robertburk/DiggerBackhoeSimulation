function [ ] = DrawTriangular(plane,depth)
%UNTITLED2 Summary of this function goes here
%   plane = [x1 y1 0;x2 y2 0;x3 y3 0]


surface_offset = [0 0 depth/2; 0 0 depth/2; 0 0 depth/2];
surface1 = plane + (ones(3,3)*surface_offset);
surface2 = plane - (ones(3,3)*surface_offset);


body = [surface1;surface2];

faces = [1 2 3 3; 4 5 6 6;1 2 5 4; 1 3 6 4;2 3 6 5];

patch('Faces',faces,'Vertices',body,'FaceColor','red');


end

