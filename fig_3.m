clc;
clear all;
close all;

f1=figure(1)
set(f1,'PaperUnits','centimeters','Units','centimeters','PaperPosition', [0 0 18 32],'Position',[0 0 18 32])
 
set(0, 'defaultaxesfontsize', 12);
set(0, 'defaulttextfontsize', 12);
set(0, 'defaultlinelinewidth',2);

gap = [0.11 0.09];  % Gap between plots (top/bottom, left/right)
marg_h = [0.06 0.05]; % Margins in height (bottom/top)
marg_w = [0.09 0.01]; % Margins in width (left/right)
[ha, pos] = tight_subplot(2, 2, gap, marg_h, marg_w);



 T=1000;
   bhv=0.5;
  bvh=.5;    %%beta_vh
  v=1;      %%v biting rate
  d1=.5;     %%death rate of host1 (human)
  d2=.5;   %%death rate of host2
  d=.8;    %%death rate of vector
  del1=.5;  % rate of waning immunity for h1
  del2=0.5;   %% rate of waning immunity for h2
  Nh1=3000;    %Total population
  Nh2=1000;
  M=15000; %%birth=death rate for constant population
  b1=d1;
  b2=d2;

   bhv1=[0.4,0.5,.8,0.9];
 mu11=[0.5,.5,.5,.5];


    aA=0.01:.01:100;

  n = numel(aA);
 for j=1:length(bhv1)
           bhv=bhv1(j);
          mu1=mu11(j);
          axes(ha(j)); 
          for i=1:n
              a=aA(i);
      c1=bhv.*v.*M./(a.*Nh1+Nh2);
      c2=bvh.*v./(a.*Nh1+Nh2);
      h=@(t,p)[(a*c1*p(3)*(1-p(1)-p(4)))-(mu1+d1)*p(1);        %Inf host1
      c1*p(3)*(1-p(2))-(d2+del2)*p(2);          %Inf host2
      (c2*(a*Nh1*p(1)+ Nh2*p(2))*(1-p(3)))-d*p(3);        %Inf vect
      mu1*p(1)-(d1+del1)*p(4)];                          %Recovered host1

options = odeset('RelTol',1e-15,'AbsTol',1e-15);
[t,W]=ode89(h,[0 T],[ 0.001 0.001 0.001 0 ]);
IVV=W(:,3);IH1=W(:,1); IH2=W(:,2); RH1=W(:,4);

INF1(i)=IH1(end);
INF2(i)=IH2(end);
INF3(i)=IVV(end);
  end
w=(mu1+d1)/(d2+del2);
c11=bhv.*v.*M./(w.*Nh1+Nh2);
c22=bvh.*v./(w.*Nh1+Nh2);
R0c=(c11.*c22./d).*((w.^(2).* Nh1./(mu1+d1))+(Nh2./(del2+d2)));
          


semilogx(aA,INF1,'Linewidth',2,'Color','b') 
hold on
semilogx(aA,INF2,'Linewidth',2,'Color','g') 
hold on
semilogx(aA,INF3,'Linewidth',2,'Color','c') 
hold on
 
xline(w,':',LineWidth=2)
ylabel ('Prevalence','Interpreter','latex','FontSize',12,'Rotation',90,'FontWeight','bold');
xlabel ('$(\alpha_v)$','Interpreter','latex','FontSize',12,'FontWeight','bold');
 title({['$R_{0c}$=',num2str(R0c)]},'Interpreter','latex','FontSize',12)


box on
ax=gca;
ax.LineWidth=2;
ax.FontWeight="bold";
ax.TickLabelInterpreter="latex";
ax.XMinorTick="off";
ax.YMinorTick="off"; 
legend('$y_1^*$','$y_2^*$','$y_3^*$','Interpreter','latex','FontSize',12,'Box','off','FontWeight','bold')
legend(Box="off");
legend(Interpreter="latex")
legend(FontSize=12)
legend(FontWeight="bold")
ylim([0 1])
 end
AddLetters2Plots(f1, 'HShift', -0.08, 'VShift', -0.02)






