function [QOIvec] = stochasticEstimationCombined(ell,samples,T)
% initialize
stochasticInitialization
maxTime = T; % max simulation time
initializations = samples;
qoisTimes10 = zeros(initializations,ceil(T/10));
qoisTimes01 = zeros(initializations,ceil(T/10));
qoisTimes11 = zeros(initializations,ceil(T/10));

u1 = [1,0];
u2 = [0,1];
u3 = [1,1];

% run different initializations to sample
for initialization = 1:initializations
    % set initial state
    initialState = zeros(8,1);
    initialState(1:ell) = 1; %denotes location of tagged particle
    initialState = initialState(randperm(8));
    %plotState(initialState,vectors);
    
    % set evolution parameters
    qoi10(initialization) = 0; % keep track of the quantity of interest
    qoi01(initialization) = 0; % keep track of the quantity of interest
    qoi11(initialization) = 0; % keep track of the quantity of interest
    curTime = 0; % current time
    timestep = 0; % number of current time step
    state = initialState;
    taggedLocation = [0,0];
        
    % evlolve the system
    while true
        % keep track of the duration of the current timestep
        timestep = timestep + 1;
        stepDuration = exprnd(1/(ell+1));
        if stepDuration + curTime > maxTime
            stepDuration = maxTime-curTime;
        end
        curTime = curTime+stepDuration;
        
        %taggedLocation =  vectors{state==-1};
        qoi10(initialization) = (u1*taggedLocation').^2;
        qoi01(initialization) = (u2*taggedLocation').^2;
        qoi11(initialization) = (u3*taggedLocation').^2;
        qoisTimes01(initialization,ceil(curTime/10)) = qoi10(initialization);
        qoisTimes10(initialization,ceil(curTime/10)) = qoi01(initialization);
        qoisTimes11(initialization,ceil(curTime/10)) = qoi11(initialization);
        
        %stopping criterion
        if curTime + eps*maxTime >= maxTime
            break
        end
        
        % compute the next state
        picked = randi(ell+1,1,1);
        direction = randi(4,1,1);
        if picked < ell+1 % not the tagged particle
            positions = find(state~= 0);
            jumpFrom = positions(picked);
            % pick one random jump
            jumpTo = tau(direction,jumpFrom);
            if jumpTo > 0 %do not jump on tagged particle
                state = etaSwap(state,jumpFrom,jumpTo);
            end
        else %tagged particle
            if state(tau(direction,0)) == 0
                taggedLocation = taggedLocation + v{direction};
                state = etaShift(state,direction,tau);
            end
        end
        
    end
end
QOI10 = 1/initializations *sum(qoi10)/maxTime; %average over initializations and divide by endTime
QOI01 = 1/initializations *sum(qoi01)/maxTime; 
QOI11 = 1/initializations *sum(qoi11)/maxTime; 

QOIvec = 2*[QOI10,QOI01,QOI11];
end

% function plotState(state,vectors)
% close all
% for i = 1:numel(state)
%     if state(i) == 1
%         plot(vectors{i}(1),vectors{i}(2),'b*')
%         hold on
%     end
% end
% plot(0,0,'r*')
% axis([-2.1,2.1,-2.1,2.1])
% end
