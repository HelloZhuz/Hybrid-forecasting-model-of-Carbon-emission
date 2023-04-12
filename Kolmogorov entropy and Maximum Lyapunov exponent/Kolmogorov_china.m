clc
clear 
close all

load All_data;
x=data(:,1);
N=length(x);
mm=40;
y=meanph(x,mm);
X=y;
rr = 0.5;
Log2R = -6:rr:0;        
R = 2.^(Log2R);
fs = 1;               % Signal sampling frequency
dd =1;                 % Embedded dimension interval
D = 1:dd:12;            % Embedded dimension    
p = 12;                 % Restrict short separation, which is greater than the average period of the sequence (p = 1 when this factor is not considered) 
Log2Cr = log2(CorrelationIntegral(X,2,D,R,p));   % Each line of output corresponds to an embedded dimension.
% least square fit
Linear = [4:8];                            % Linear similarity region
[a,B] = LM2(Log2R,Log2Cr,Linear);           % Finding slope and intercept by least square method
fprintf('Correlation Dimension = %.4f\n',a);

%--------------------------------------------------------------------------
% Find the gradient
Slope = diff(Log2Cr,1,2)/rr;                % Find the gradient
xSlope = Log2R(1:end-1);                    
%--------------------------------------------------------------------------
% Solving k entropy by difference
KE = -diff(B)/(dd*2)*fs*log(2);          
D_KE = D(1:end-1);                          % The embedding dimension corresponding to k entropy
%--------------------------------------------------------------------------
% Output display
fprintf('Kolmogorov Entropy = %.4f\n',min(KE));
