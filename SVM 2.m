function [alpha, lambda] = svm(G, y, C, params)

% function [alpha, lambda] = svm(G, y, C, params)
%
% Trains a support vector machine.
%
% G is the data matrix: if K is the kernel function and x_i is the
% i-th training example, then G(i,j) = K(x_i, x_j).
%
% y is the vector of target outputs, with each entry +1 or -1.
%
% C is the relative weight of error vs. margin (large C means a low
% error is more important, while small C means a wide margin is more
% important).
%
% Last argument, params, is optional.  If provided, its fields set
% some parameters:
%   params.iters: maximum iterations (default 75)
%   params.verbose: print progress messages (default false)
%   params.tol: convergence tolerance (default 1e-6)
%
% Returns the learned classifier parameters alpha and lambda.  Alpha
% is a vector of weights on the original examples (those with positive
% weights are the support vectors), and lambda is a cutoff.  Given a
% new example x, write k_i = y_i * K(x, x_i); then the predicted class
% for x is
%
%    sign(alpha' * k - lambda)
%
% For example usage, see the end of the M-file (use 'which svm').
%
% Uses a primal log-barrier algorithm to find parameters alpha and
% lambda which satisfy the optimality conditions
%
%   hess * [alpha; lambda] == rhs
%
% where
%
%   hess = [H -y; -y' 0];
%   rhs = [1 - H*alpha + lambda*y; alpha'*y];
%   H = G .* (y*y');
%
% The most expensive step in each iteration of this algorithm is
% solving an (n+1) by (n+1) linear system, where n is the size of the
% training set.

% magic numbers
backoff = .99995;
n = length(y);
if (nargin < 4)
  params = struct;
end
if (~isfield(params, 'iters'))
  params.iters = 75;
end
if (~isfield(params, 'verbose'))
  params.verbose = false;
end
if (~isfield(params, 'tol'))
  params.tol = 1e-6;
end

% indices of the first n diagonal elements of an (n+1) by (n+1)
% matrix
mask = speye(n+1);
mask(end) = 0;
dg = find(mask);

% multiply class signs into data matrix (to save typing later, since
% we never use the original G by itself)
H = G .* (y * y');

% We will initialize alpha to the analytic center of its feasible
% region.  The analytic center will have the components of alpha
% corresponding to y=1 equal to C*(1-p), and the ones corresponding to
% y=-1 equal to C*p, where p is the fraction of components with y=1.
p = sum(y>0) / n;
alpha = repmat(C * p, [n 1]);
alpha(y>0) = C * (1-p);

% start with a relatively large barrier term (which will be reduced
% during the optimization), and start with the dual variable lambda=0.
mu = 10000;
lambda = 0;

% main optimization loop
for i = 1:params.iters
  
  % Build the Newton system, leaving out the barrier terms (which
  % we will add in below after preconditioning)
  hess = [H -y; -y' 0];
  grad = [1 - H*alpha + lambda*y; alpha'*y];

  % We will symmetrically precondition the Newton system by
  % multiplying the Hessian on either side with a diagonal matrix.  We
  % do the preconditioning on the barrier terms analytically and add
  % them in last, since otherwise we may get a loss of precision.
  precond = [(alpha/C) .* (1-alpha/C); 1];
  hess = hess .* (precond * precond');
  hess(dg) = hess(dg) + mu * ((C-alpha).^2 + alpha.^2)/C^4;
  rhs = grad .* precond + (mu/C) * [1 - 2*alpha/C; 0];

  % compute search direction
  searchdir = hess \ rhs;
  searchdir = searchdir .* precond;

  % compute maximum possible step size (to keep alpha in [0,C])
  adir = searchdir(1:end-1);
  steplen = max(-adir ./ (alpha+1e-15));
  steplen = max(steplen, max(adir ./ (C-alpha+1e-15)));
  if (steplen <= 0) steplen = Inf; else steplen = 1 / steplen; end

  % back off from max step size according to how far it would have
  % taken us past the boundary
  steplen = min(1, .666 * steplen + (backoff - .666) * steplen^2);
 
  % do the step, pick the next barrier weight mu, and report
  alpha = alpha + steplen * adir;
  lambda = lambda + steplen * searchdir(end);
  oldmu = mu;
  update = sum(abs(searchdir));
  if (steplen > .995)
    mu = mu * .1;
  elseif (steplen > .95)
    mu = mu * .3334;
  end
  if (params.verbose)
    fprintf('Iteration %3d: step %8.6f, next_mu %8.6f, update %8.6f\n', ...
	    i, steplen, mu, update);
  end
  if (oldmu + update < params.tol/2)
    break;
  end

  % avoid getting too close to zero barrier
  if (mu < params.tol / 10)
    mu = params.tol / 10;
  end

end

if (oldmu + update > params.tol)
  warning('SVM:convergence', 'failed to converge');
end

return

