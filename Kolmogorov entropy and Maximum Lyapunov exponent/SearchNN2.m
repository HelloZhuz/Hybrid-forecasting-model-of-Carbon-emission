function [index,distance] = SearchNN2(X1,query_indices,K,exclude)
% Searching for nearest neighbor pairs in reconstructed phase space
% input:   X1                Reconstructed phase space
%         query_indices     The nearest neighbor reference point defaults to [1:size(xn,2)]' 
%         K                 The number of nearest neighbors is 1 by default.
%         exclude           Restrict short separation, which is greater than the average period of the sequence, and the default value is 0.
% output:   index           Nearest neighbor subscript
%         distance          Nearest neighbor distance  

if nargin < 4 
    exclude = 0;        % Restrict short separation, which is greater than the average period of the sequence.   
    if nargin < 3
        K = 1;                  % Number of nearest neighbors
        if nargin < 2
            N = size(xn,2);             % Reconstructed orbital points
            query_indices = [1:N]';     % reference point    
        end
    end
end

%--------------------------------------------------------------------------

L1 = 7;
L2 = 7;
[Tree] = KNN_Tree(X1,L1,L2);

% function [Tree] = KNN_Tree(X1,L1,L2)
% KNN bifurcation tree algorithm
% input:
% X  - Sample points, one point in each column.
% L1 - Number of first-level tree nodes
% L2 - Number of nodes in the second-level tree
%
% output:
% Tree{i}.len                   % Number of each category
% Tree{i}.C                     % Each kind of center
% Tree{i}.Rmax                  % Maximum diameter
% Tree{i}.Tree{j}.X             % sample point
% Tree{i}.Tree{j}.I             % Category label
% Tree{i}.Tree{j}.len           % When there is no sample point, it is 0
% Tree{i}.Tree{j}.C             % When there is no sample point, it is 0
% Tree{i}.Tree{j}.Rmax          % When there is no sample point, it is 0
% Tree{i}.Tree{j}.R             % Distance between each sample and category center
%
% Tree{L1+1}.IJK                % The serial number of the two-layer node to which the sample point belongs.

%--------------------------------------------------------------------------

[index,distance] = KNN_Search(Tree,query_indices,K,exclude);


function [Tree] = KNN_Tree(X1,L1,L2)

IJK = zeros(3,size(X1,2));
[M1,R1max,N1,T1,R1] = KMeans2(X1,L1);
IJK(1,:) = T1;                            
for i = 1:L1
    I = find(T1==i);
    X2 = X1(:,I);

    Tree{i}.len = N1(i);                   
    Tree{i}.C = M1(:,i);                   
    Tree{i}.Rmax = R1max(i);               
    
    [M2,R2max,N2,T2,R2] = KMeans2(X2,L2);
    IJK(2,I) = T2;                         
    for j = 1:L2
        J = find(T2==j);        
        X3 = X2(:,J);
        
        Tree{i}.Tree{j}.X = X3;            
        Tree{i}.Tree{j}.I = I(J);           
        Tree{i}.Tree{j}.len = N2(j);       
        Tree{i}.Tree{j}.C = M2(:,j);        
        Tree{i}.Tree{j}.Rmax = R2max(j);   
        Tree{i}.Tree{j}.R = R2(J);         
        
        IJK(3,I(J)) = 1:length(J);        
    end
end
Tree{L1+1}.IJK = IJK;                      

%--------------------------------------------------------------------------

function [M1,R1max,N1,T1,R1] = KMeans2(X,c)


M1 = Initialize(X,c);                

tmax = 20;
k = 0;
Je = zeros(1,tmax);
while k<tmax
    
    k = k+1;    
    
    [M2,T1,R1,N1,R1max,je1] = KMeans2_Center_Update(X,M1);  
    Je(k) = je1;                                           
    
    if k>2 & abs(Je(k)-Je(k-1))/(Je(k-1)+1e-8)<0.005
        break;                                 
    end
    M1 = M2;
end
Je = Je(1:k);

%--------------------------------------------------------------------------

function [M] = Initialize(X,c)

n = size(X,2);            
M = zeros(size(X,1),c);   
M(:,1) = mean(X,2);
Dis = zeros(1,n);
for i = 2:c
    for k = 1:n
        d0 = inf;
        for j = 1:i-1
            d1 = norm(X(:,k)-M(:,j));
            if d1<d0
                d0 = d1;
            end
        end
        Dis(k) = d0;
    end
    [tmp,m] = max(Dis);
    M(:,i) = X(:,m);
end

%--------------------------------------------------------------------------

function [M2,T1,R1,N1,R1max,je1] = KMeans2_Center_Update(X,M1)


[d,n] = size(X);                     
[d,c] = size(M1);
D = zeros(c,n);                       
for i = 1:c
    tmp1 = X - repmat(M1(:,i),1,n);
    D(i,:) = sum(tmp1.^2);              
end

[R1,T1] = sort(D);
T1 = T1(1,:);
R1 = sqrt(R1(1,:));
    
N1 = zeros(1,c);
M2 = zeros(d,c);
R1max = zeros(1,c);
for i = 1:c
    J = find(T1==i);

    if ~isempty(J)
        N1(i) = length(J);                    
        M2(:,i) = mean(X(:,J),2);                        
        R1max(i) = max(R1(J));
    else
        N1(i) = 0;                    
        M2(:,i) = 0;                    
        R1max(i) = 0;                  
    end
end
je1 = sum(R1);                        

%--------------------------------------------------------------------------

function [index,distance] = KNN_Search(Tree,query_indices,K,exclude)

n = length(query_indices);
index = zeros(n,K);
distance = zeros(n,K);
for i = 1:n
    [in,di] = KNN_Search_1P(Tree,query_indices(i),K,exclude);
    index(i,:) = in;
    distance(i,:) = di;
end



function [index,distance] = KNN_Search_1P(Tree,i,K,exclude)

IJK = Tree{end}.IJK;
ijk = IJK(:,i);
x = Tree{ijk(1)}.Tree{ijk(2)}.X(:,ijk(3));     

d = length(x);                                 
m = size(IJK,2);                                
if exclude>=0
    I = max(1,i-exclude):min(m,i+exclude);
    for j = 1:length(I)
        Tree = X_Inf(Tree,I(j));     
    end
end

%--------------------------------------------------------------------------


L1 = length(Tree)-1;             
L2 = length(Tree{1}.Tree);      

Len = zeros(1,L1*L2);
C = zeros(d,L1*L2);
IJ = zeros(2,L1*L2);
k = 0;
for i = 1:L1
    for j = 1:L2
        k = k+1;
        IJ(1,k) = i;                        
        IJ(2,k) = j;                       
        Len(k) = Tree{i}.Tree{j}.len;       
        C(:,k) = Tree{i}.Tree{j}.C;        
    end
end
C(:,find(Len==0))=inf;                      

tmp1 = C-repmat(x,1,L1*L2);
D = sum(tmp1.^2);
[tmp2,I] = sort(D);                        
Len = Len(I);    
IJ = IJ(:,I);

for i = 1:L1*L2
    if sum(Len(1:i))>2*K
        n = i;                             
        break
    end
end
n = max(n,2);                               

Len = Len(1:n);                              
IJ = IJ(:,1:n);

X1 = [];
I1 = [];
for k = 1:n
        i = IJ(1,k);
        j = IJ(2,k);
        X1 = [X1,Tree{i}.Tree{j}.X];        
        I1 = [I1,Tree{i}.Tree{j}.I];        
end

tmp1 = X1-repmat(x,1,size(X1,2));           
E = sum(tmp1.^2);
[tmp2,I2] = sort(E);                       
E = E(I2);
I1 = I1(I2);

index = I1(1:K);                          
distance = sqrt(E(1:K));                 

%--------------------------------------------------------------------------


for i = 1:L1
    len = Tree{i}.len;
    C = Tree{i}.C;                          
    Rmax = Tree{i}.Rmax;                    
    dmax = distance(end);                   
    d = norm(x-C);
    if len==0 | d>dmax+Rmax                
        continue;
    end
    
    for j = 1:L2
        tmp1 = abs(IJ-repmat([i;j],1,size(IJ,2)));
        tmp2 = ~sum(tmp1);
        if ~isempty(find(tmp2==1))          
            continue;
        end   
        
        len = Tree{i}.Tree{j}.len;
        C = Tree{i}.Tree{j}.C;
        Rmax = Tree{i}.Tree{j}.Rmax;
        d = norm(x-C);
        if len==0 | d>dmax+Rmax             
            continue;
        end

        for k = 1:len
            R = Tree{i}.Tree{j}.R(k);
            if d>dmax+R                                       
                continue;                
            end
            
            x2 = Tree{i}.Tree{j}.X(:,k);         
            d2 = norm(x-x2);
            if d2>dmax                     
                continue;
            end
            index(K) = Tree{i}.Tree{j}.I(k);        
            distance(K) = d2;
                        
            [tmp3,I3] = sort(distance);
            index = index(I3);                     
            distance = distance(I3);
            dmax = distance(K);                  
        end
    end
end



function [Tree] = X_Inf(Tree,m)

IJK = Tree{end}.IJK;
i = IJK(1,m);
j = IJK(2,m);
k = IJK(3,m);


Tree{i}.Tree{j}.X(:,k) = inf;
Tree{i}.Tree{j}.R(k) = inf;

