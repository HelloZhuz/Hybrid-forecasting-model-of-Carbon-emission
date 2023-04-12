function [xn,dn] = PhaSpaRecon(s,tau,m,T)

[rows,cols] = size(s);
if (rows>cols)
    len = rows;
    s = s';
else
    len = cols;
end

if (nargin < 4)
    T = 1;
end

if (nargout==1)

    if (len-(m-1)*tau < 1)
        disp('err: delay time or the embedding dimension is too large!')
        xn = [];
    else
        xn = zeros(m,len-(m-1)*tau);
        for i = 1:m
            xn(i,:) = s(1+(i-1)*tau : len-(m-i)*tau);  
        end
    end
    
elseif (nargout==2)
    
    if (len-T-(m-1)*tau < 1)
        disp('err: delay time or the embedding dimension is too large!')
        xn = [];
        dn = [];
    else
        xn = zeros(m,len-T-(m-1)*tau);
        for i = 1:m
            xn(i,:) = s(1+(i-1)*tau : len-T-(m-i)*tau);  
        end
        dn = s(1+T+(m-1)*tau : end);    
    end
    
end



