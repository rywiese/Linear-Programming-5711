function [value] = Knapsack(n, v, w, C)
	V = zeros([n, C]);
	i = 1;
	for j = 1:C
		if w(i) < j
			V(i, j) = v(i);
		else
			V(i, j) = 0;
		end
	end
	for i = 2:n
		for j = 1:C
			if (w(i) < j) && (V(i-1, j-w(i)) + v(i) > V(i-1, j))
				V(i, j) = V(i-1, j-w(i)) + v(i);
			else
				V(i, j) = V(i-1, j);
			end
		end
	end
	V
	value = V(n, C);
end