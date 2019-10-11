//modified from code sent by Philip G Jones <pgjones@saint-lukes.org>
// itself based on stan_polr code
// concentration (alpha) is given as a scalar parameter along with data

functions {
#include /bayes_cpm_funs.stan
}
data {
  int N;
  int ncat;
  int Ylev[N];
  int link;
  int K;
  matrix[N, K] Q;
  real<lower=0> alpha;
}

parameters {
  simplex[ncat] pi;
  vector[K] b;
}

transformed parameters {
  vector[ncat - 1] cutpoints;
  vector[N] log_lik;

  cutpoints = make_cutpoints(pi, ncat, link);
  log_lik = loglik(Ylev, N, cutpoints, ncat, Q * b, link);
}

model {
  
  //prior for counts (is it on right scale? transform to scale of cutpoints/intercepts??)
  // repeat alpha for all params (i.e. symmetric Dirichlet)
  target += dirichlet_lpdf(pi | rep_vector(alpha, ncat));
  // equivalently
  // pi ~ dirichlet(rep_vector(alpha, ncat));
  
  //prior for betas
  //target += student_t_lpdf(b | 3, 0, 10);
  // equivalently
  // b ~ student_t(3, 0, 10);
  
  target += log_lik;
}

generated quantities {
  //vector[K] beta = R_inv * b;
}

