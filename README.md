# LV_QLearn_2C_SerialReversal
 Matlab code for generating a Q-Learning model from behavioral data.

See LV_QLearn_ExampleScript_2CSR for an example on how to call the fitting functions. 

Requirements:
 % Inputs: 
    % 1. Session Data is 2-choice serial reversal session data from BPod 
    % 2. Model is a 7-letter code for the type of choice algorithm to use.
    % The possible choices are as follows:
    
    % 'SoftMax' = a softmax model where choice probability is somewhat proportional
    % to the Q Value of the choice. Proportionality depends on beta
    % parameter. High beta exploits value differences, low beta does not.
    % 'SoftDec' = a softmax model where the value of the choice that isn't
    % chosen decays according to the decay parameter. There is an RPE for unchosen choice
    % 'Epsilon' = a choice algorithm where some percentage of the time a
    % choice is made randomly, and the other times the choice is made
    % according to highest Q value. Epsilon Parameter controls how often a
    % random choice is made (epsilon = 0.5 is random half of the time)
    % EpsiDec = a greedy-epsilon model where the unchosen choice decays in
    % value according to the decay parameter
     
    
    % Outputs: Result Matrix with Fitted Model parameters,
    % Trial-by-trial RPEs & Qvalues, & Model Likelihood
    
    % 1. Alpha is the learning rate. 
    % 2. Beta is the explore/exploit parameter.
    %    Beta < 1 is exploratory, Beta > 1 is exploitative.
    %    If testing epsilon model, beta will be set to 1.
    % 3. Epsilon is the percentage of trials where a random choice is made.
    %    If testing a softmax algorithm, epsilon will be set to 0.
    % 4. Decay is the fitted decay rate for models that include decay. Decay 
    %    will be set to 0 for models that don't include decay rates.
    % 5. Choice Probabilities is the probability of selecting each choice
    %    according to the Q value and beta parameter.
    % 6. RPEs is a matrix containing trial-by-trial RPEs for each choice. 
    %    Depending on the model used, there will or won't be an RPE for
    %    each choice
    % 7. QValues is a matrix containing the trial-by-trial Q value of each
    %    choice. Top row is for the left choice, bottom row is for right
    %    choice.
    % 8. QSums is the trial-by-trial sum of the Q value for each choice
    % 9. QDifferences is the trial-by-trial absolute difference between
    %    each of the choices
    % 10. Likelihood is a measure of the likelihood of the model. Lower is
    %    better.
    
    % Coded by Luigim Vargas. June 29, 2020.
