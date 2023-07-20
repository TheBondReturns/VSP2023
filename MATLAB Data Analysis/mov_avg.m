function array2 = mov_avg(array,n)

array2 = [];

for i = 1:(length(array)-n + 1)

    array3 = array(i:i+n-1);

    array2 = [array2 mean(array3)];

end

end
