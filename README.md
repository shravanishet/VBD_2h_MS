
# Modeling the impact of host diversity on the evolution of vector feeding preferences and implications for disease control. 

### This repository contains MATLAB program files used to generate the figures of the manuscript:
>*S. Shetgaonkar and A. Sharma. Modeling the impact of host diversity on the evolution of vector feeding preferences and implications for disease control. Submitted, 2025.*

The codes are in the form of  `.m`  files, which can be executed in MATLAB. 

1.  `fig_1.m`: This file computes the value of basic reproduction number $(R_0)$ for different values of vector preference $(\alpha_v)$.  In Figures (a) and (b), $R_0$ is computed for three different values of recovery rate for $h1$ and $h2$  ($\mu_1$ and $\delta_2$). The value of $R_0$ is stored in matrix named `R0_val` of size 1 $\times$ 100001.

2.  `fig_2.m`:  This file computes the value of $R_0$ for different combinations of values for vector preference and total population of the host. In Figures (a)-(d), $R_0$ is computed by varying the total population of $h1$ for different values of recovery rates for $h1$. In Figures (e)-(h), $R_0$ is computed by varying the total population of $h2$ for different values of recovery rates for $h2$. The file contains a matrix `Q` of dimensions  400 $\times$ 401 that stores $R_0$ data for a single simulation. The threshold value of $N_{h1}$ and $N_{h2}$ at which $R_0$ attains maximum is stored in a matrix  `w1` and `w2`. The value of vector preference at which $R_0$ attains minimum is ($\alpha_{vc}$), which is stored in `w`.

3. `fig_3.m`: This file simulates the solution for the system using `ode89` for different values of $\alpha_v$ and transmission probability from vector to host ($\beta_{hv}$). The value of equilibrium prevalence for $h1,h2$ and vector is stored in matrix `INF1, INF2, INF3` of size 1 $\times$ 10000. The minimum value of $R_0$ and $\alpha_{vc}$ are stored in `R0c` and `w`.

4. `fig_4.m`: This file simulates the invasion fitness of the mutant $\psi_{\sigma_{h2(r)}}(\sigma_{h2(m)})$ for different combinations of resident and mutant trait value, $(\sigma_{h2(r)},\sigma_{h2(m)}) \in [0,1] \times [0,1]$. The encounter rates of $h1$ and $h2$ are taken as ($\mathcal{E}_{h1}$, $\mathcal{E}_{h2}$) $=(2,1),(1.05,1),(1,1.5),(1,5)$ for Figures (a)-(d), respectively. The value of the invasion fitness is stored in matrix `z` of size 500 $\times$ 500. The Parameters $p_2=0.95$, $q_2=0.95$, $\nu=0.5, \chi=1$, $\tau_2$=2.5 day, $\tau_f=0.1$ day, are taken from [C. Stone and K. Gross. 2018. Malar. J](https://doi.org/10.1186/s12936-018-2407-1).

5. `fig_5.m`: This file simulates the value of Evolutionary singular strategies (ESS) $\sigma_{h2}^{*}$, for different values of inverse trade-off strength ($\chi$). The value of $\chi$ is varied from 0 to 5, and matrix `ESS_value` of dimensions 1 $\times$ 502  stores the data for Evolutionary singular strategies. The subfigures are made by considering the 4 combinations of encounter rates similar to Figure(4).

6. `fig_6.m`: This file computes ESS for each $\chi$ value ranging from 0 to 5, and stores the data in the matrix `ESS_value` of dimensions 1 $\times$ 502.  The parameters used are $\mathcal{E}_{h1}=\mathcal{E}_{h2}$=1, $q_2=$ 0.1, $\tau_2$=1 day, $\tau_f$=0.2 day, $f_{rc}=4$. 

7. `fig_7.m`: This file contains simulations for the evolutionary singular point, basic reproduction number, equilibrium prevalence in $h1$ ($y_1^{\ast}$), equilibrium prevalence in $h2$ ($y_2^{\ast}$), and equilibrium prevalence in vector population ($y_3^{\ast}$), obtained for different $\chi$ values.  The value of $\chi$ is varied from 0 to 5. Matrices `ESS_val`, `R0`, `y1_val`, `y2_val`, `y3_val`, each of dimensions 1 $\times$ 501 store the values of  ESS, $R_0$, $y_1^{\ast}$, $y_2^{\ast}$, $y_3^{\ast}$, respectively for each simulation. Parameter values used are $\mathcal{E}_{h1}$=1.2, $\mathcal{E}_{h2}$=1, $\tau_2$=1 day and rest as in Figure(4). 

8. `fig_8.m`: The code in this file simulates solutions for the disease prevalence in $h1$ using `ode89`. The data for equilibrium prevalence $y_1^{\ast}$ is stored in matrix `INF1` of dimension 200 $\times$ 200, for each value of host competence $(\gamma=\frac{1}{\alpha_{vc}})$ and vector preference $(\alpha_v)$.

9. `fig_9.m`: This file simulates the solution curves for the ODE system for different values of initial conditions. The value of the equilibrium point ($y_1^{\ast},y_3^{\ast},y_2^{\ast}$) is calculated using the expressions given in Section 3.3 of the manuscript.

10. `AddLetters2Plots`: This file is used to add letters to the subplots in Figures. This function has been taken from [Alex Ryabov (2025)](https://in.mathworks.com/matlabcentral/fileexchange/95478-addletters2plots).

11. `slanCM`: This file is used to add colors to the Figures. This function has been taken from [Zhaoxu Liu / slandarer (2025)](https://in.mathworks.com/matlabcentral/fileexchange/120088-200-colormap).

12. `tight_subplot`: This file is used to create subplot axes and adjust gaps and margins. This function has been taken from [Colin Rowell (2025)](https://in.mathworks.com/matlabcentral/fileexchange/168926-tightsubplot).

### The parameter values used for numerical simulation are presented in the table below.
| Prameters    | Description                                  | Value   |
| ------------ | -------------------------------------------- | ------- |
| $\beta_{hv}$ | transmission probability from vector to host | 0.5     |
| $\beta_{vh}$ | transmission probability from host to vector | 0.5     |
| $c$          | biting rate                                  | 1       |
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

### Description of variables is provided in the following table.
| Variable | Description                   |
| -------- | ----------------------------- |
| $t$      | time instant in days          |
| $y_1(t)$ | Proportion of infected $h1$   |
| $z_1(t)$ | Proportion of recovered $h1$  |
| $y_2(t)$ | Proportion of infected $h2$   |
| $y_3(t)$ | Proportion of infected vector |
