
# Modeling the impact of host diversity on the evolution of vector feeding preferences and implications for disease control.

## This repository contains MATLAB codes for the figures in manuscript:
>*S. Shetgaonkar and A. Sharma. Modeling the impact of host diversity on the evolution of vector feeding preferences and implications for disease control. Submitted, 2025.*

The data is in the form of `.m` files (which can be opened in MATLAB). 

1.  `fig_1.m`: This file computes the value of  basic reproduction number $(R_0)$ for different values of vector preference $(\alpha_v)$.  In Figure (a) and (b), $R_0$ is computed for three different values of recovery rate for $h1$ and $h2$  ($\mu_1$ and $\delta_2$). In the code the value of $R_0$ is stored in array named `R0_val` of size 1 $\times$ 100001.
2.  `fig_2.m`:  This file computes the value of $R_0$ for different combinations of values for vector preference and total population of the host. In Figure(a-d), $R_0$ is computed by varying total population of $h1$ for different values of recovery rates for $h1$. In Figure(e-h), $R_0$ is computed by varying total population of $h2$ for different values of recovery rates for $h2$. The file contains a matrix `Q` of dimensions  400 $\times$ 401 that stores $R_0$ data for a single simulation. The threshold value of the host population at which $R_0$ attains maximum is stored in a matrix  `w1` and `w2` of size  400 $\times$ 801 and represented using green color on the plot. The value of vector preference at which $R_0$ attains minimum is stored in `w` (denoted using dotted line on all plots).
3. `fig_3.m`:
4. `fig_4.m`:
5. `fig_5.m`:
6. `fig_6.m`:
7. `fig_7.m`:
8. `fig_8.m`:
9. `fig_9.m`:

### The parameter values used for numerical simulation is presented in table below.

| Prameters    | Description                                  | Value   |
| ------------ | -------------------------------------------- | ------- |
| $\beta_{hv}$ | transmission probability from vector to host | 0.5     |
| $\beta_{vh}$ | transmission probability from host to vector | 0.5     |
| $ c$         | biting rate                                  | 1       |
| $\alpha_v$   | feeding preference                           | varied  |
| $\mu_1$      | recovery rate of $h1$                        | 0.5     |
| $\delta_2$   | recovery rate of $h2$                        | 0.5     |
| $b_3$        | birth rate of vector                         | 5       |
| $d_3$        | death rate of vector                         | 0.8     |
| $b_{31}$     | density dependent death rate of vector       | 0.00028 |
| $b_{1}$      | birth rate of $h1$                           | 0.5     |
| $b_{2}$      | birth rate of $h2$                           | 0.5     |
| $N_{h1}$     | total population of $h1$                     | 3000    |
| $N_{h2}$     | total population of $h1$                     | 1000    |
| $M$          | total vector population                      | 15000   |
### Description of variables is provided in following table.

| Variable | Description                   |
| -------- | ----------------------------- |
| t        | time instant                  |
| $y_1(t)$ | Proportion of infected $h1$   |
| $z_1(t)$ | Proportion of recovered $h1$  |
| $y_2(t)$ | Proportion of infected $h2$   |
| $y_3(t)$ | Proportion of infected vector |
