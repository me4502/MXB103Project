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
disp('Maximum speed occurs at ' + t(index) + 's');

%% 5.3 Maximum acceleration experienced by the jumper
%
% Describe the question, and then answer it.  In this case, you will call
% a function to numerically differentiate $v$ to find $a$.  Then plot $a$ 
% versus $t$ and refer to it to answer the question.

%% 5.4 Distance travelled by the jumper
%
% Describe the question, and then answer it.  In this case, you will call
% a function to numerically integrate $|v|$ to find the distance.

%% 5.5 Automated camera system
%
% Describe the question, and then answer it.  In this case, you will
% fit an interpolating polynomial through the four points in your solution
% $y$ that lie either side of the camera location.  Then use that
% polynomial to solve for when the jumper passes the camera.

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