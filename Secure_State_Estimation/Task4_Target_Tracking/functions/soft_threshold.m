function s = soft_threshold(u, lambda)
% Soft-thresholding operator 
s = sign(u) .* max(abs(u) - lambda, 0);
end