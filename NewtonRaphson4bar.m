function [theta_ab,theta_bc,i] = NewtonRaphson4bar(rad,theta_ad,rab,theta_ab,rbc,theta_bc,rdc,theta_dc)
%[theta_ab,theta_bc] = NewtonRaphson4bar(rad,theta_ad,rab,theta_ab,rbc,theta_bc,rdc,theta_dc)
% Computes the two unknown angles as present in our closure equations for 
% a four bar linkage
%
% Inputs:
% rad (real scalar, positive) equals length of side ad in mm
% theta_ad (real scalar, positive, less than 2*pi) equals known ad angle in
%       radians
% rab (real scalar, positive) equals length of side ab in mm
% theta_ab (real scalar, positive, less than 2*pi) equals initial estimate 
%       for unknown angle ab in radians
% rbc (real scalar, positive) equals length of side bc in mm
% theta_bc (real scalar, positive, less than 2*pi) equals initial estimate 
%       for unknown angle abc in radians
% rdc (real scalar, positive) equals length of side dc in mm
% theta_dc (real scalar, positive, less than 2*pi) equals known angle dc in
%       radians
%
% Outputs:
% theta_ab (real scalar) equals angle ab as 
%       as calculated using closure equations using the Newton Raphson 
%       for a system of equations
% theta_bc (real scalar) equals angle bc as 
%       as calculated using closure equations using the Newton Raphson 
%       for a system of equations
%
% Version 4: created 15/03/21. Author: Robert Burke


%% Test Validity of user inputs
if(~isscalar(rab)) || (~isreal(rab)) ||  rab <= 0
    error('Input argument rab must a positive real scalar above 0')
elseif(~isscalar(rbc)) || (~isreal(rbc)) ||  rbc <= 0
    error('Input argument rbc must a positive real scalar above 0')
elseif(~isscalar(rdc)) || (~isreal(rdc)) ||  rdc <= 0
    error('Input argument rdc must a positive real scalar above 0')
elseif(~isscalar(rad)) || (~isreal(rad)) ||  rad <= 0
    error('Input argument rad must a positive real scalar above 0')
elseif(~isscalar(theta_ab)) || (~isreal(theta_ab))
    error('Input argument theta_ab must a positive real scalar')
elseif(~isscalar(theta_bc)) || (~isreal(theta_bc))
    error('Input argument theta_bc must a positive real scalar')
elseif(~isscalar(theta_dc)) || (~isreal(theta_dc))
    error('Input argument theta_dc must a positive real scalar')
elseif(~isscalar(theta_ad)) || (~isreal(theta_ad))
    error('Input argument theta_ad must a positive real scalar')
end

iteration_limit = 20;   % max number of iterations permitted

%% Initiate angles and compute constants

theta = [theta_ab;theta_bc];    %   Create column vector for N-R method
theta_cd = theta_dc - pi;   % reverse direction of angle so it can be used...
                            % in vector addition

rad_cos = rad*cos(theta_ad);
rdc_cos = rdc*cos(theta_cd);
rad_sin = rad*sin(theta_ad);
rdc_sin = rdc*sin(theta_cd);

    f = [rad_cos - rab*cos(theta(1)) - rbc*cos(theta(2)) - rdc_cos;...
         rad_sin - rab*sin(theta(1)) - rbc*sin(theta(2)) - rdc_sin];
% disp('f1 = ');
% disp(f);
                            

%% Compute Newton Raphson Method
for i = 1:iteration_limit + 1
    
%   Calculate system of equations
    f = [rad_cos - rab*cos(theta(1)) - rbc*cos(theta(2)) - rdc_cos;...
         rad_sin - rab*sin(theta(1)) - rbc*sin(theta(2)) - rdc_sin];
     
%   Test if tolerance criteria is met
    if abs(f)< 1e-8
%         disp('fbreak = ');
%         disp(f);
        break
    end
    
%   Calculate Jacobian of f
    Df = [rab*sin(theta(1)) rbc*sin(theta(2)); -rab*cos(theta(1)) -rbc*cos(theta(2))];

%   Compute the Newton Raphson step using the inverse of the Jacobian
    theta = theta - (1/(Df(1,1)*Df(2,2)-Df(1,2)*Df(2,1)))*([Df(2,2) -Df(1,2);-Df(2,1) Df(1,1)])*f;

end

% Update values for output as you can't index in an output argument
theta_ab = theta(1);
theta_bc = theta(2); 

end

