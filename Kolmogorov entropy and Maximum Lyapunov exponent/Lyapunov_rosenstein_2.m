function [Y] = Lyapunov_rosenstein_2(x,fs,taumax,P)
% Calculating Lyapunov exponent of chaotic time series

%-----------------------------------------------------------------
% Phase space reconstruction
tau = 2;
m = 9;
xn = PhaSpaRecon(x,tau,m);              % Each column and one point
N = size(xn,2);                         % Number of phase space points

%-----------------------------------------------------------------
% Nearest neighbor calculation

query_indices1 = [1:N-taumax]';                 % reference point
k = 1;                                          % Number of nearest neighbors
exclude = max(P-1,0);                           % Restrict short separation, which is greater than the average period of the sequence.
[index1,distance1] = SearchNN2(xn,query_indices1,k,exclude);

i = find(index1 <= N-taumax);                   % Find the subscript less than or equal to N-taumax in index_pair(:,2)
query_indices1 = query_indices1(i);
index1 = index1(i,:);                           % Primitive nearest neighbor pair
distance1 = distance1(i,:);

M = length(query_indices1);                     % Nearest neighbor logarithm
Y = zeros(taumax+1,1);
for i = 0:taumax
    query_indices2 = query_indices1 + i;
    index2 = index1 + i;
    xn_1 = xn(:,query_indices2)-xn(:,index2);
    distance2 = zeros(M,1);
    for j = 1:M
        distance2(j) = norm(xn_1(:,j));
    end
    distance2;                                  % Distance between nearest neighbor points after step j
    Y(i+1) = mean(log2(distance2./distance1))*fs;  
end

