function [theta_ab, theta_cb,i] = NewtonRaphSimult(rab,theta_ab,rcb,theta_cb,rac,theta_ac)
%[theta_ab, theta_cb] = NewtonRaphSimult(rab,rcb,rac,theta_ac,theta_ab,theta_cb)
% Computes the two unknown angles as present in our closure equations for 
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


%% Test Validity of user inputs
if(~isscalar(rab)) || (~isreal(rab)) ||  rab <= 0
    error('Input argument r1 must a positive real scalar above 0')
elseif(~isscalar(theta_ab)) || (~isreal(theta_ab))
    error('Input argument theta_ab must a positive real scalar')
elseif(~isscalar(rcb)) || (~isreal(rcb)) ||  rcb <= 0
    error('Input argument r2 must a positive real scalar above 0')
elseif(~isscalar(theta_cb)) || (~isreal(theta_cb))
    error('Input argument theta_cb must a positive real scalar')
elseif(~isscalar(rac)) || (~isreal(rac)) ||  rac <= 0
    error('Input argument r3 must a positive real scalar above 0')
elseif(~isscalar(theta_ac)) || (~isreal(theta_ac))
    error('Input argument theta_ac must a positive real scalar')
elseif((rab+rcb)<rac) ||((rab+rac)<rcb) || ((rcb+rac)<rab)
    error('Triangle do be broken')
end 


%% Initiate Values outside of loop

theta = [theta_ab;theta_cb];

rac_cos = (rac)*(cos(theta_ac));
rac_sin = (rac)*(sin(theta_ac));
f = [(rab)*(cos(theta(1)))-(rcb)*(cos(theta(2)))-rac_cos; (rab)*(sin(theta(1)))-(rcb)*(sin(theta(2)))-rac_sin];
disp('f1 = ');
disp(f);

%% Iterate Newton Raphson Mathod
for i = 1:20
    
%   Calculate system of equations
    f = [(rab)*(cos(theta(1)))-(rcb)*(cos(theta(2)))-rac_cos; (rab)*(sin(theta(1)))-(rcb)*(sin(theta(2)))-rac_sin];


%   Test if tolerance is satisfactory
    if abs(f)< 1e-8
        disp('fbreak = ');
        disp(f);
        break
    end
    
    
%   Calculate Jacobian of f
    Df = [(-rab)*(sin(theta(1))) (rcb)*(sin(theta(2))); (rab)*(cos(theta(1))) (-rcb)*(cos(theta(2)))];


    theta = theta - (1/(Df(1,1)*Df(2,2)-Df(1,2)*Df(2,1)))*([Df(2,2) -Df(1,2);-Df(2,1) Df(1,1)])*f;
%     disp('theta = ');
%     disp(theta);

        
end

theta_ab = (theta(1));
theta_cb = (theta(2));


end

