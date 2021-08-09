function [ ] = DrawBucket_V2(A,B,theta,rotation)
%[ ] = DrawBucket_V2(A,B,theta,rotation)
% This function draws the bucket of the backhoe at the defined angle theta,
% rotation determined by the inputed rotation matrix, and locates the
% origin at A
%   
% Inputs:
% A (row vector of form [x y z]) equals location of point A
% B (row vector of form [x y z]) equals location of point B
% theta (real scalar, positive, less than 2*pi) equals value of theta 
%       in radians
% rotation (3x3 rotation matrix0 for rotation around global coordinate system
%       if swivel is required
%
% Outputs:
% none
%
% Version 5: created 15/03/21. Author: Robert Burke

% Initiate values required for the curved section of the bucket
N = 100;    % Number of points around the curved section
phi = [pi:(pi/N):(2*pi)-(pi/N)]';   % angles of the arc created by the 
%curved section. This generates a semicircle  starting at the negative x
%axis swooping counter clockwise to the positive x axis
r_circle = 200;     % radius of curved section
depth = 500;    % depth of the bucket
    
%% Generate locations for circle

circle_data = [((r_circle)*(cos(phi))) ((r_circle)*(sin(phi))) (zeros(N,1))];
% locations of circle vertices
minx = min(circle_data(:,1));   % Calculate min and maximum points on the 
maxy = max(circle_data(:,2));   % circle 

circle_low = circle_data + [-minx -maxy -depth/2]; %   transpose to the 
                                                   % origin and create
                                                   % upper surface
circle_high = circle_data+[-minx -maxy depth/2];   %   transpose to the 
                                                   % origin and create
                                                   % upper surface

[xmax,location_xmax] = max(circle_high(:,1));   % find max x value

circle_ram = [circle_low;circle_high]; % Generate vertices for curved section

% Scale for oblong shape
circle_ram(:,2) = circle_ram(:,2)*2;

% Generate faces for curved section
faces_circle = [[1:100];[1:100]' [[2:100] 1]' [(100+[2:100]) 101]' ...
    ((100+[1:100])')*ones(1,97);100+[1:100]];
faces_circle(101,:) = ones(1,100);  % Removed segment face so it is an open shape

%% Generate locations for the triangle link to H and L

U = [ 100 -5 0];
plane = [0 0 0;0 norm(A-B) 0;U]; 
plane_low = plane + [0 0 -depth/2]; % Create upper surface
plane_high = plane + [0 0 depth/2]; % Create lower Surface
connection = [plane_low;plane_high];    % Create vertices for link

connection_faces = [1 2 3 3;4 5 6 6;1 2 5 4;2 3 6 5]; % Create faces for link


%% Generate locations for the teeth
% Following line
triangle = [xmax (circle_ram(location_xmax,2)) 0;xmax ...
    (circle_ram(location_xmax,2))+80 0;xmax-60 (circle_ram(location_xmax,2)) 0];

tooth_surfaces_negative = [zeros(10,2) (-depth/20)*[10:-1:1]']; % Create 
                                                        % lower surface
tooth_surfaces_positive = [zeros(10,2) (depth/20)*[1:10]']; % Create upper
                                                        % surface
T1 = [triangle+tooth_surfaces_negative(1,:)];
T2 = [triangle+tooth_surfaces_positive(1,:)];

for i = 2:10 % generate teeth vertices
    T1 = [T1;[triangle+tooth_surfaces_negative(i,:)]]; 
    T2 = [T2; [triangle+tooth_surfaces_positive(i,:)]];
end


faces_triangle = [[1:3:28]' [2:3:29]' [3:3:30]' [3:3:30]'];
faces_teeth = [[1:6:25]' [2:6:26]' [5:6:29]' [4:6:28]';[1:6:25]' [3:6:30]' [6:6:30]' [4:6:28]'];
teeth_faces = [faces_triangle;faces_teeth]; % Generate teeth faces


%% Rotate all points about the z axis

rotation_z = [cos(theta) -sin(theta) 0;sin(theta) cos(theta) 0;0 0 1];

circle_ram = circle_ram*rotation_z;
connection = connection*rotation_z;
T1 = T1*rotation_z;
T2 = T2*rotation_z;


%% Translate all points to the desired location at A
circle_ram = circle_ram+A;
connection = connection+A;
T1 = T1+A;
T2 = T2+A;

%% Rotate all points about z-axis if swivel required
circle_ram = circle_ram*rotation;
connection = connection*rotation;
T1 = T1*rotation;
T2 = T2*rotation;


%% Draw Shapes

patch('Vertices',circle_ram,'Faces',faces_circle,'FaceColor',[0.6 0.6 0.6],'LineStyle','none','FaceLighting','phong');
patch('Vertices',connection,'Faces',connection_faces,'FaceColor',[0.6 0.6 0.6],'LineStyle','none','FaceLighting','phong');
patch('Vertices',T1,'Faces',teeth_faces,'FaceColor',[0 0 0],'LineStyle','none','FaceLighting','phong');
patch('Vertices',T2,'Faces',teeth_faces,'FaceColor',[0 0 0],'LineStyle','none','FaceLighting','phong');


end

