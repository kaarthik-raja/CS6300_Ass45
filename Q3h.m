%%
function N = zeros(arr)
    L = length(arr);
    N =0;
    for i = 1:L-1
        if  arr(i)*arr(i+1)<0
            N = N+1;
        end
    end

end
%%
function E = zeros(arr)
    %E =0;
    %for i in arr
    %    E = E + i*i;
    %end
    E = sum(arr.*arr) ;
end