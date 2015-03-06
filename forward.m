function u = forward (f,g,X,diffs,record)

    if nargin < 6
        record = 0;     
    end
    
    x1 = X.x1;
    x2 = X.x2;
    t = X.t;
    h = X.h;
    k = X.k;
    
    % initialize spatial derivative operators
    N_grid = length(x1);    
    
    DRX = diffs.DRX;
    DLX = diffs.DLX;
    DRZ = diffs.DRZ;
    DLZ = diffs.DLZ;
    c = reshape(X.C,N_grid^2,1);    

    %D2X = DRX*DLX;
    %D2Z = DRZ*DLZ;
    
    f = reshape(f,N_grid^2,1);
    g = reshape(g,N_grid^2,1);

    % setup to calculate solution using 2nd order method

    u_1 = zeros(N_grid^2,1);
    u_2 = f;
    
    u = zeros(length(x1),length(x2),length(t));
    u(:,:,1) = reshape(u_2,N_grid,N_grid);
    
    u_3 = u_2 + k*g + 0.5*k^2*( (DRX*(c.*(DLX*u_2)) +DRZ*(c.*(DLZ*u_2))));
    u(:,:,2) = reshape(u_3,N_grid,N_grid);    
    
    u_1 = u_2;
    u_2 = u_3;
    
    f = reshape(f,N_grid,N_grid);
    g = reshape(g,N_grid,N_grid);

    

    % Lambda_f(x,y,n) = u(x,y,(n-1)k) for x,y in boundary of Omega                                     
    
    
    for n = 2: length(t)-1
        %finite difference scheme

        %% 2nd Order Method
        u_3 = 2*u_2 - u_1 + k^2*( (DRX*(c.*(DLX*u_2)) +DRZ*(c.*(DLZ*u_2))));                      %u_3 = 2*u_2 - u_1 + k^2*(c.*(DRX*(DLX*u_2) +DRZ*(DLZ*u_2)));
        
        %store boundary data
        u(:,:,n+1) = reshape(u_3,N_grid,N_grid);  
       

        % update arrays in preparation for next pass
        u_1 = u_2;
        u_2 = u_3;
    end
    
end
