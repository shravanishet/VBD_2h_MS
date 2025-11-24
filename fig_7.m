
clc; clear all;  close all;

f1=figure(1)
set(f1,'PaperUnits','centimeters','Units','centimeters','PaperPosition', [0 0 18 32],'Position',[0 0 18 32])
 
set(0, 'defaultaxesfontsize', 12);
set(0, 'defaulttextfontsize', 12);
set(0, 'defaultlinelinewidth',2);


gap = [0.06 0.09];  % Gap between plots (top/bottom, left/right)
marg_h = [0.05 0.01]; % Margins in height (bottom/top)
marg_w = [0.09 0.04]; % Margins in width (left/right)

[ha, pos] = tight_subplot(3, 2, gap, marg_h, marg_w);


global d1_e tf t2 sh egc pf mu sr K1 T bhv bvh mu1 ...
    d1 d2 del1 del2 Nh1 Nh2 gc gh Ih10 Ih20 Iv0 cd1 cd2 cd3 cd4
d1_e=0.00028;
tf=.1;
t2=1;    %2.5; %1
sh=1;
egc=5.0;
pf=0.95;
mu=0.5;
sr=.95; %%%taken from ppr Menach 2007
K1=1;
T=1000;
bhv=.5;    %%beta_hv  transmission rate
bvh=.5;    %%beta_vh
mu1=.5;    %%recovery rate in host1 (keep it high to get complex EV)
d1=.5;     %%death rate of host1 (human)
d2=.5;   %%death rate of host2
del1=.5;  % rate of waning immunity for h1
del2=.5;   %% rate of waning immunity for h2


Nh1=3000;    %Total population
Nh2=1000;

Ih10=0.001;
Ih20=0.001;
Iv0=0.001;

gh=1.2; 
gc=1;

cd1=0.1; 
cd2=2.01;

cd3=0;
cd4=0;

    wrr=0.01:.01:2;  
    wrr1=2:.01:5;

[sing,fs,b3s,d3s]=funct1(wrr);
[sing1,f1s,b31s,d31s]=funct2(wrr1);
ww=cat(2,wrr,wrr1); 
PP=cat(2, sing, sing1);
K2=double(PP);
biteq=cat(2,fs,f1s);
death=cat(2,d3s,d31s);
birth=cat(2,b3s,b31s);
[y11,y22,y33,a11,R0]=funct3(biteq,birth,death,K2);



 axes(ha(1));
plot(ww,K2)
xlim([0 5])
 hold on
 patch_x = [cd1 cd2];
fill([patch_x(1), patch_x(1), patch_x(2), patch_x(2)], [0, 1, 1, 0], 'r', 'FaceAlpha', 0.2, 'EdgeColor', 'none','FaceColor',[0.06, 1,1]);
hold on
patchw_x = [cd3 cd4];
fill([patchw_x(1), patchw_x(1), patchw_x(2), patchw_x(2)], [0, 1, 1, 0], 'r', 'FaceAlpha', 0.2, 'EdgeColor', 'none','FaceColor',[0.06, 1,1]);
   ylabel ('Evolutionary singular strategy ($\sigma_{h2}^*$)','Interpreter','latex','FontSize',12,'Rotation',90,'FontWeight','bold');
ylim([0 1])

hs = get(gca, 'XLabel');
pos = get(hs, 'Position');
pos(1) = pos(1) ;
set(hs, 'Position', pos)


 box on
 ax=gca;
ax.LineWidth=2;
 ax.XMinorTick="off";
 ax.TickLabelInterpreter="latex";



 axes(ha(2));
 plot(ww,a11)
  ylim([0 7])
  xlim([0 5])
  hold on
 patch_x = [cd1 cd2];
 fill([patch_x(1), patch_x(1), patch_x(2), patch_x(2)], [0, 8, 8, 0], 'r', 'FaceAlpha', 0.2, 'EdgeColor', 'none','FaceColor',[0.06, 1,1]);
hold on
patchw_x = [cd3 cd4];
fill([patchw_x(1), patchw_x(1), patchw_x(2), patchw_x(2)], [0, 5, 5, 0], 'r', 'FaceAlpha', 0.2, 'EdgeColor', 'none','FaceColor',[0.06, 1,1]);
ylabel ('Vector preference ($\alpha_v$)','Interpreter','latex','FontSize',12,'Rotation',90,'FontWeight','bold');
 legend('$\alpha_v$','$\alpha_v<1$','FontSize',13,'Box','off','FontWeight','bold',Interpreter='latex')
hs = get(gca, 'XLabel');
pos = get(hs, 'Position');
pos(1) = pos(1) ;
set(hs, 'Position', pos)
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 box on
 ax=gca;
ax.LineWidth=2;
 ax.XMinorTick="off";
 ax.TickLabelInterpreter="latex";



 axes(ha(3));
plot(ww,R0)
 ylim([0 8])
 xlim([0 5])
 hold on
 patch_x = [cd1 cd2];
% Create a vertical patch of transparent color
fill([patch_x(1), patch_x(1), patch_x(2), patch_x(2)], [0, 15, 15, 0], 'r', 'FaceAlpha', 0.2, 'EdgeColor', 'none','FaceColor',[0.06, 1,1]);
hold on
patchw_x = [cd3 cd4];
fill([patchw_x(1), patchw_x(1), patchw_x(2), patchw_x(2)], [0, 15, 15, 0], 'r', 'FaceAlpha', 0.2, 'EdgeColor', 'none','FaceColor',[0.06, 1,1]);

ylabel ('Basic reproduction number ($R_0$)','Interpreter','latex','FontSize',12,'Rotation',90,'FontWeight','bold');
hs = get(gca, 'XLabel');
pos = get(hs, 'Position');
pos(1) = pos(1) ;
set(hs, 'Position', pos)

 box on
 ax=gca;
 ax.LineWidth=2;
 ax.XMinorTick="off";
 ax.TickLabelInterpreter="latex";


 axes(ha(4)); 
plot(ww,y11)
hold on
patch_x = [cd1 cd2];
fill([patch_x(1), patch_x(1), patch_x(2), patch_x(2)], [0, 1, 1, 0], 'r', 'FaceAlpha', 0.2, 'EdgeColor', 'none','FaceColor',[0.06, 1,1]);
hold on
patchw_x = [cd3 cd4];
fill([patchw_x(1), patchw_x(1), patchw_x(2), patchw_x(2)], [0, 1, 1, 0], 'r', 'FaceAlpha', 0.2, 'EdgeColor', 'none','FaceColor',[0.06, 1,1]);

 ylim([0 1])
 xlim([0 5])
ylabel ('$h1$ prevalence ($y_1^*$)','Interpreter','latex','FontSize',12,'Rotation',90,'FontWeight','bold');
hs = get(gca, 'XLabel');
pos = get(hs, 'Position');
pos(1) = pos(1) ;
set(hs, 'Position', pos)
 box on
 ax=gca;
ax.LineWidth=2;
 ax.XMinorTick="off";
 ax.TickLabelInterpreter="latex";


axes(ha(5));
plot(ww,y22)
xlim([0 5])
hold on 
 patch_x = [cd1 cd2];
% Create a vertical patch of transparent color
fill([patch_x(1), patch_x(1), patch_x(2), patch_x(2)], [0, 1, 1, 0], 'r', 'FaceAlpha', 0.2, 'EdgeColor', 'none','FaceColor',[0.06, 1,1]);
hold on
patchw_x = [cd3 cd4];
fill([patchw_x(1), patchw_x(1), patchw_x(2), patchw_x(2)], [0, 1, 1, 0], 'r', 'FaceAlpha', 0.2, 'EdgeColor', 'none','FaceColor',[0.06, 1,1]);

 ylim([0 1])
 xlabel ('Inverse trade-off strength $(\chi)$','Interpreter','latex','FontSize',12,'FontWeight','bold');
ylabel ('$h2$ prevalence ($y_2^*$)','Interpreter','latex','FontSize',12,'Rotation',90,'FontWeight','bold');
hold on
hs = get(gca, 'XLabel');
pos = get(hs, 'Position');
pos(1) = pos(1) ;
set(hs, 'Position', pos)
 box on
 ax=gca;
ax.LineWidth=2;
 ax.XMinorTick="off";
 ax.TickLabelInterpreter="latex";


axes(ha(6));
plot(ww,y33)
ylim([0 1])
xlim([0 5])
hold on
 patch_x = [cd1 cd2];
% Create a vertical patch of transparent color
fill([patch_x(1), patch_x(1), patch_x(2), patch_x(2)], [0, 1,1, 0], 'r', 'FaceAlpha', 0.2, 'EdgeColor', 'none','FaceColor',[0.06, 1,1]);
hold on
patchw_x = [cd3 cd4];
fill([patchw_x(1), patchw_x(1), patchw_x(2), patchw_x(2)], [0, 1, 1, 0], 'r', 'FaceAlpha', 0.2, 'EdgeColor', 'none','FaceColor',[0.06, 1,1]);

xlabel ('Inverse trade-off strength $(\chi)$','Interpreter','latex','FontSize',12,'FontWeight','bold');
ylabel ('Vector prevalence ($y_3^*$)','Interpreter','latex','FontSize',12,'Rotation',90,'FontWeight','bold');
 

  hs = get(gca, 'XLabel');
pos = get(hs, 'Position');
pos(1) = pos(1) ;
set(hs, 'Position', pos)
  box on
 ax=gca;
ax.LineWidth=2;
 ax.XMinorTick="off";
 ax.TickLabelInterpreter="latex";

 AddLetters2Plots(f1, 'HShift', 0.0, 'VShift', 0.0)




% %funct1
function [sing,fs,b3s,d3s]=funct1(wrr)
global d1_e tf t2 sh egc pf mu sr K1 T bhv bvh mu1 ...
    d1 d2 del1 del2 Nh1 Nh2 gc gh Ih10 Ih20 Iv0


 for i=1:length(wrr)
     i
    w=wrr(i);
 syms scr 
psi=1-exp(-(sh*gh+scr*gc));
phs=psi*pf/(1-((1-psi)*pf));
Q=scr*gc/(sh*gh+scr*gc);
pc=1-mu*((1-Q)^(w));
ph=1-mu*((Q)^(w));
sf=phs*((Q)*pc+(1-Q)*ph);
pgc=sf*sr;
t1=0.1/(1-((1-psi)*0.95));
f(i)=1/(t1+t2);
eps=egc*(f(i));
pd=pgc^(f(i));
b3(i)=eps;
d3(i)=-log(pd);
diff_pd=diff(f(i)*log(pgc),scr);
diff_ep=diff(eps,scr);
deri=diff_pd+diff_ep;
eqn=deri==0;
singular{i}=vpasolve(eqn,scr,.2);



    if singular{1,i} > 0
        if singular{1,i} < 1
            sing(i) = singular{1,i};
        else
            sing(i) = 0.001;
        end
    else
        sing(i) = 0.001;
    end

 fs(i)=subs(f(i),scr,sing(i));
 d3s(i)=subs(d3(i),scr,sing(i));
 b3s(i)=subs(b3(i),scr,sing(i));
 end
end


 %funct2
function [sing1,f1s,b31s,d31s]=funct2(wrr1)
global d1_e tf t2 sh egc pf mu sr K1 T bhv bvh mu1 ...
    d1 d2 del1 del2 Nh1 Nh2 gc gh Ih10 Ih20 Iv0
for j=1:length(wrr1)
     j
    w1=wrr1(j);

syms scr1 
psi1=1-exp(-(sh.*gh+scr1.*gc));
phs1=psi1.*pf./(1-((1-psi1).*pf));
Q1=scr1.*gc./(sh*gh+scr1.*gc);
pc1=1-mu.*((1-Q1).^(w1));
ph1=1-mu.*((Q1).^(w1));
sf1=phs1.*((Q1).*pc1+(1-Q1).*ph1);
pgc1=sf1.*sr;
t11=tf./(1-(1-psi1).*pf);
f1(j)=1./(t11+t2);
eps1=egc.*(f1(j));
b31(j)=eps1;
 pd1=pgc1.^(f1(j));
 d31(j)=-log(pd1);
diff_pd1=diff(f1(j).*log(pgc1),scr1);
diff_ep1=diff(eps1,scr1);
deri1=diff_pd1+diff_ep1;
eqn1=deri1==0;
singular1{j}=vpasolve(eqn1,scr1);



    if singular1{1,j} > 0
        if singular1{1,j} < 1
            sing1(j) = singular1{1,j};
        else
            sing1(j) = 0.001;
        end
    else
        sing1(j) = 0.001;
    end

 f1s(j)=subs(f1(j),scr1,sing1(j));
 d31s(j)=subs(d31(j),scr1,sing1(j));
 b31s(j)=subs(b31(j),scr1,sing1(j));
 end
 end

function [y11,y22,y33,a11,R0]=funct3(bite,birth,death,K2)
global d1_e tf t2 sh egc pf mu sr K1 T bhv bvh mu1 ...
    d1 d2 del1 del2 Nh1 Nh2 gc gh Ih10 Ih20 Iv0

  a11=K1.*Nh2./(K2.*Nh1);
ro=length(a11);
 for m=1:ro
        v=double(bite(m));
        d=double(death(m));
        b=double(birth(m));
        if b==d
            M=15000;
        else 
            M=(b-d)/d1_e;
        end

    a=a11(m);
    c1=bhv*v*M/(a*Nh1+Nh2);
    c2=bvh*v/(a*Nh1+Nh2);
 R0(m)=(c1*c2/d)*((a^(2)*Nh1/(mu1+d1))+(Nh2/(del2+d2)));
 options = odeset('RelTol',1e-15,'AbsTol',1e-15);
h=@(t,p)[(a*c1*p(3)*(1-p(1)-p(4)))-(mu1+d1)*p(1);        %Inf host1
         c1*p(3)*(1-p(2))-(d2+del2)*p(2);          %Inf host2
         (c2*(a*Nh1*p(1)+ Nh2*p(2))*(1-p(3)))-d*p(3);        %Inf vect
         mu1*p(1)-(d1+del1)*p(4);                          %Recovered host1
       ];

 [t,W]=ode89(h,[0 T],[Ih10 Ih20 Iv0 0.0]);
 IH1=W(:,1); 
 IH2=W(:,2); 
 IV=W(:,3); 
 y11(m)=IH1(1000);
 y22(m)=IH2(1000);
 y33(m)=IV(1000);
end
end





