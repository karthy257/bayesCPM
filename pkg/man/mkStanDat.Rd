% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/mkStanDat.R
\name{mkStanDat}
\alias{mkStanDat}
\title{Format data for CPM models using Stan}
\usage{
mkStanDat(ds, outcome, preds, link)
}
\arguments{
\item{ds}{a data frame}

\item{outcome}{a character string containing the model outcome}

\item{preds}{vector of linear predictors for model}

\item{link}{the link function to be used (1 = logistic; 2 = probit;
3 = loglog; 4 = cloglog; 5 = cauchit)}
}
\value{
a list containing the data to be used for the model
}
\description{
This function formats data for use with rstan::stan() or rstan::sampling()
}
\examples{
dat1_stan <- mkStanDat(dat1, "outcome_var", c("pred1","pred2"), 2)
}
