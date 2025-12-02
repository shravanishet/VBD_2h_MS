clc; clear all;  close all;
f1=figure(1)
set(f1,'PaperUnits','centimeters','Units','centimeters','PaperPosition', [0 0 18 18],'Position',[0 0 18 18]) 
set(0, 'defaultaxesfontsize', 12);
set(0, 'defaulttextfontsize', 12);
set(0, 'defaultlinelinewidth',2);
  T=100;
  bhv=.5;    %%beta_hv  transmission rate
  bvh=.5;    %%beta_vh
  v=1;      %%v biting rate
  mu1=.5;    %%recovery rate in host1 (keep it high to get complex EV)
  d1=.5;     %%death rate of host1 (human)
  d2=.5;   %%death rate of host2
  d=.8;    %%death rate of vector
  del1=.5;  % rate of waning immunity for h1
  del2=.5;   %% rate of waning immunity for h2
  Nh1=3000;    %Total population
  Nh2=1000;
  M=15000;
  a=.1;
b=d;      %%birth=death rate for constant population
b1=d1;
b2=d2;
c1=bhv*v*M/(a*Nh1+Nh2);
c2=bvh*v/(a*Nh1+Nh2);
m3=a*c1*(1+(mu1/(d1+del1)));
m1=(mu1+d1);
m2=(d2+del2);

options = odeset('RelTol',1e-15,'AbsTol',1e-15);
h=@(t,p)[(a*c1*p(3)*(1-p(1)-p(4)))-(mu1+d1)*p(1);        %Inf host1
         c1*p(3)*(1-p(2))-(d2+del2)*p(2);          %Inf host2
         (c2*(a*Nh1*p(1)+ Nh2*p(2))*(1-p(3)))-d*p(3);        %Inf vect
         mu1*p(1)-(d1+del1)*p(4)];                          %Recovered host1

 Ih10=[0.03,.2,.2,.2,.005,.1,.2,.20,.1,.15];
 Iv0=[.3,.1,.1,0.55,.1,.45,.2,.3,.5,0.001];
 Ih20=[.01,.01,.9,.9,.1,.2,.9,.9,.4,.7];

for i=1:length(Iv0)
[t,W]=ode89(h,[0 T],[Ih10(i) Ih20(i) Iv0(i) 0]);
IH1=W(:,1); IH2=W(:,2); IV=W(:,3); Rh1=W(:,4); 
plot3(IH1,IV,IH2,'Color','b')
hold on
end
grid on
xlabel ('$y_{1}$','Interpreter','latex','Rotation',0,'FontWeight','bold','FontName','Helvetica','FontSize',12);
ylabel ('$y_{3}$','Interpreter','latex','Rotation',0,'FontWeight','bold','FontName','Helvetica','FontSize',12);
zlabel ('$y_{2}$','Interpreter','latex','Rotation',0,'FontWeight','bold','FontName','Helvetica','FontSize',12);
hold on 
syms y1 y2 y3 z1
eqn1=(a*c1*y3*(1-y1-z1))-(mu1+d1)*y1==0;      
eqn2=c1*y3*(1-y2)-(d2+del2)*y2==0;   
eqn3=c2*(a*Nh1*y1+Nh2*y2)*(1-y3)-d*y3==0;        
eqn4= mu1*y1-(d1+del1)*z1==0;
sol=solve([eqn1,eqn2,eqn3,eqn4],[y1,y2,y3,z1]);
k=find(sol.y3>0);   
Iv=round(sol.y3(k),10);        %Inf vector
Ih1=round(sol.y1(k),10);       %Inf host1
Ih2=round(sol.y2(k),10);       %Inf host2
Rh11=round(sol.z1(k),10); 
plot3(Ih1,Iv,Ih2,'-o','Color','k','MarkerSize',4)
text(Ih1,Iv,Ih2,'$(y_{1}^{*},y_{3}^{*},y_{2}^{*})$','Interpreter','latex','FontSize',12);
 ax=gca;
 ax.LineWidth=2;
 ax.XMinorTick="off";
 ax.TickLabelInterpreter="latex";
 ax.FontWeight="bold";
