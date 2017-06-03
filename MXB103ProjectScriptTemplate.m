%% MXB103 Project Group 64:  BUNGEE!

%% 1  Introduction
% As part of Brisbane's "New World City" transformation, the Brisbane City
% Council is investigating a proposal to allow bungee jumping off the
% Story Bridge. This report addresses several key questions about the
% proposal.
%
% In Section 2 of this report, the proposal and the key questions relating 
% to it are discussed in more detail. In Section 3, the model is expanded
% on including the mathematical equation representing the acceleration of 
% the jumper and how this equation was formed. This is followed by a 
% disussion of the assumptions and limitations considered with the model 
% and throughout the study as well as the parameters the study is basing 
% its results on.
%
% Section 4 introduces the formulated model and parameters for the formula
% to then show the model in graph form. Then section 5 comes to the 
% analysis of the graphical predictions addressing the questions of the 
% proposal with further analysis. Finally  coming to a conclusion in
% section 6 discussing findings and future recommendations.

%% 2  The proposal
% What is the proposal exactly?
% What questions have you been asked to answer?
% What's your approach to doing this?
% A few paragraphs should be enough.
% Finish with a sentence linking to the next section on the model.
%
% The Brisbane City Council has proposed for a bungee jumping platform to
% be installed at the top of the Story Bridge. 
%
% We have been tasked with determining if the model will provide adequate
% thrill to the customers, whilst still retaining safety. The model is also
% used to determine the perfect trigger-point for a camera to go off, to
% ensure the customer can purchase a photo to remember their experience by.
%
% Furthermore, a 'water touch' experience is wanted to be offered to allow
% the customers to experience touching the water. The model is to be used
% to determine how closely they will touch the water, and how it can be
% modified to optimise for this without sacrificing safety.
%
% In order to solve this, a Fourth Order Runge-Kutta equation has been
% developed to solve the Ordinary Differential Equation that is the model.
%
% The following model will be used to answer these questions.

%% 3 The model
%
% The equation of motion for bungee jumping is
%%
% $$\frac{dv}{dt} = g - C|v|v - \max(0,K(y-L))$$
%
% Write a paragraph or two about the equation, including where it comes
% from and what the symbols mean.

%% 3.1 Assumptions and limitations
%
% Write a paragraph on the assumptions and limitations on the model,
% and a paragraph on the limitations on the study you have conducted.
%
% In the model there will be a range of assumptions that will have to be
% taken into consideration. The model assumes there be a constant drag on 
% the jumper and a vertical bounce from the bungee cord. The model also
% has a limitationin that it does not adjust for the different possible
% weather conditions.
%
% The following study conducted also has limitations. 

%% 3.2 Parameters
H = 74;             % Height of jump point (m)
D = 31;             % Deck height (m)
c = 0.9;            % Drag coefficient (kg/m)
m = 80;             % Mass of the jumper (kg)
L = 25;             % Length of bungee cord (m)
k = 90;             % Spring constant of bungee cord (N/m)
g = 9.8;            % Gravitational acceleration (m/s^2)
C = c/m;            % Scaled drag coefficient
K = k/m;            % Scaled spring constant

%% 4 The numerical method
%
% How do you formulate the model to solve numerically? (hint: you write it
% as two equations)

%% 4.1 Parameters

T = 60;             % Final time in simulation (s)
n = 10000;          % Number of subintervals (you decide how many you need)

%% 4.2 Solution
%
% The ordinary differential equations are solved using fourth order Runge-Kutta method.
[t, y, v, h] = RK4_bungee(T, n, g, C, K, L);

figure(1)
plot(t, y);
xlabel('time (s)');
ylabel('distance fallen (m)');
title('Figure 1: Distance fallen over time.');

figure(2)
plot(t, v);
xlabel('time (s)');
ylabel('velocity (m/s)');
title('Figure 2: Jumper velocity over time.');

%% 5 Analysis
%
% In this section, the model predictions are analysed with respect to the
% key questions being asked about the proposal.
%

%% 5.1 Timing and bounces
%
% Describe the question, and then answer it.  In this case, you will refer
% to Figure 1 of $y$ versus $t$.
% 
% The question describes the bungee company's suggested number of bounces
% that should take place within 60 seconds. The company recommends 10 
% bounces to be performed within the 60 seconds.

dwnCurve = 0;
for i = 3:n
    if(y(i) < y(i-1) && y(i-1) > y(i-2))
        dwnCurve = dwnCurve + 1;
    end
end

fprintf('In %d seconds, %d bounces take place.\n',T,dwnCurve);
%% 5.2 Maximum speed experienced by the jumper
%
% Describe the question, and then answer it.  In this case, you will create
% a figure of $v$ versus $t$ and refer to it to answer the question.
% 
% This question refers to finding the point at which the jumper reaches the
% maximum speed, for the highest thrill factor. 
% The graph shows the highest velocity of $value$ is reached at
% $$t(index)$$ seconds.

[value, index] = max(v);
fprintf('Maximum speed occurs at %.2d seconds',  t(index));

%% 5.3 Maximum acceleration experienced by the jumper
%
% Describe the question, and then answer it.  In this case, you will call
% a function to numerically differentiate $v$ to find $a$.  Then plot $a$ 
% versus $t$ and refer to it to answer the question.
%
% Knowing the acceleration at t = 0 is g we skip the first step in order 
% for the arrays v and y to grab values from the previous and next 
% index which allows the second order central differentiation to work

f = @(t) v(t);
a = zeros(1,n+1);
a(1) = g;
max_a = g; % Finding the maximum acceleration the jumper experiences
index = 1;
for j = 2:n
    a(j) = second_order_central(f, j, index, h);
    if max_a < abs(a(j))
       max_a = abs(a(j));
    end
end

figure(3)
plot(t, a);
xlabel('time (s)');
ylabel('fall acceleration (m/s^2)');
title('Figure 3: Fall acceleration over time.');
%% 5.4 Distance travelled by the jumper
%
% Describe the question, and then answer it.  In this case, you will call
% a function to numerically integrate $|v|$ to find the distance.
%
% As a requirement for promotional material, the question asks to compute
% the total distance the jumper has travelled in 60 seconds.

f_absv = @(t) abs(v(t));
a = 1;
b = 10001;

distance = simprule(f_absv, a, b, n, h);

fprintf('The jumper has traveled %.0f metres in %d seconds', distance, T);
%% 5.5 Automated camera system
%
% The client plans to implement an automated camera system in order to
% capture the jumper as they descend 
%
% Describe the question, and then answer it.  In this case, you will
% fit an interpolating polynomial through the four points in your solution
% $y$ that lie either side of the camera location.  Then use that
% polynomial to solve for when the jumper passes the camera.

y_cam = H - D; % Distance from the jumper to the camera
y_index = 1; % Indexing through y to find the closest value to y_cam

% Once a y value that exceeds y_cam is found, the four y values used for
% interpolation can be extracted
while y(y_index) < y_cam
    y_index = y_index + 1;
end
Y = [y(y_index - 2) y(y_index - 1) y(y_index) y(y_index + 1)];

% Also grabbing the time the same four points of Y
T = [t(y_index - 2) t(y_index - 1) t(y_index) t(y_index + 1)];

% Considering the y values are all equally spaced by interval h with
% regards to time, it is possible to use Newton Forward Difference Form to
% generate the interpolating polynomial for the four points gathered

M = forward_differences(Y);
t_interpol = T(1):h/100:T(length(T));
y_interpol = forward_eval(T, M, t_interpol);

% Using the bisection method to find the root of the interpolating
% polynomial at 43m
f_root = @(x) y_interpol(x);

% indeces of the first and last values of y_interpol
root_a = 1;
root_b = length(y_interpol);

p = bisection(f_root, root_a, root_b, y_cam);
figure(4)
plot (T, Y, 'ro');
hold on
plot (t_interpol, y_interpol);
plot (t_interpol(p), y_interpol(p), '*');
xlabel('time (s)');
ylabel('distance fallen (m)');
title('Figure 4: Interpolated polynomial over four points closest to 43m.');
legend('4 points near 43m', 'polynomial', 'closest to 43m');

fprintf('The camera should trigger at %7.5f seconds', t_interpol(p));
%% 5.6 Water touch option
%
% Describe the question, and then answer it.  In this case, you will
% re-solve the equations with different parameters for $L$ and $k$.  
% Experiment to find which values work best for the water touch option, but 
% include only the best combination that you found in the submitted code.

%% 6 Conclusion
%
% Conclude your report by summing up your findings and making any
% recommendations.