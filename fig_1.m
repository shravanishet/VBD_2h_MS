clc; clear all;  close all;

f1=figure(1)
set(f1,'PaperUnits','centimeters','Units','centimeters','PaperPosition', [0 0 18 32],'Position',[0 0 18 32])
 
set(0, 'defaultaxesfontsize', 12);
set(0, 'defaulttextfontsize', 12);
set(0, 'defaultlinelinewidth',2);

gap = [0.09 0.09];  % Gap between plots (top/bottom, left/right)
marg_h = [0.09 0.04]; % Margins in height (bottom/top)
marg_w = [0.09 0.07]; % Margins in width (left/right)
[ha, pos] = tight_subplot(2, 1, gap, marg_h, marg_w);

cmap = sky(3);

bhv=.5;    %%beta_hv  transmission rate
bvh=.5;    %%beta_vh
v=1;      %%v biting rate
mu1=.5;    %%recovery rate in host1 (keep it high to get complex EV)
d1=.5;     %%death rate of host1 (human)
d2=.5;   %%death rate of host2
d=.8;    %%death rate of vector    %%birth=death rate for constant population
del1=.5;  % rate of waning immunity for h1
del2=.5;   %% rate of waning immunity for h2
Nh1=3000;    %Total population
Nh2=1000;
M=15000;
a=0:.001:100;
c1=bhv*v*M./(a.*Nh1+ Nh2);
c2=bvh*v./(a.*Nh1+Nh2);
deltatwo=[0.1,1,10];

axes(ha(1)); 

  for i=1:length(deltatwo)
      mu1=deltatwo(i);
      delta2{i}=strcat(' $\mu_{1}$=', num2str(mu1));
      R0_val=(c1.*c2./d).*((a.^(2).* Nh1./(mu1+d1))+(Nh2./(del2+d2)));
      semilogx(a,R0_val,'LineWidth',4, 'Color', cmap(i,:),MarkerFaceColor='k',MarkerSize=3.5);
      hold on
  end




for i=1:length(deltatwo)
    mu1=deltatwo(i);
    w=(mu1+d1)/(del2+d2);
    c11=bhv*v*M./(w.*Nh1+ Nh2);
    c12=bvh*v./(w.*Nh1+Nh2);
    R0c=(c11.*c12./d).*((w.^(2).* Nh1./(mu1+d1))+(Nh2./(del2+d2)));
    semilogx(w,R0c,'-o',Color='k',MarkerFaceColor='k',MarkerSize=3.5)
    a11=num2str(R0c);
    b11=num2str(w);
    Letsgo=strcat(b11,a11)
    text(w,R0c,Letsgo,'FontSize',12,'FontWeight','bold',Interpreter='latex')
    hold on
end

 plq=strcat(delta2);
 legend(plq)
 box on
 ax=gca;
 ax.LineWidth=2;
 ax.XMinorTick="off";
 ax.TickLabelInterpreter="latex";
 ax.FontWeight="bold";
 legend(Box="off");
 legend(Interpreter="latex")
 legend(FontSize=15)
 legend(FontWeight="bold")
 ylabel ('$R_0$','Interpreter','latex','FontSize',15,'Rotation',0,'FontWeight','bold','FontName','Helvetica');
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes(ha(2)); 
a=0:.001:100;
c1=bhv*v*M./(a.*Nh1+ Nh2);
c2=bvh*v./(a.*Nh1+Nh2);
deltatwo=[0.1,1,10];
mu1=0.5;
  for i=1:length(deltatwo)
      del2=deltatwo(i);
      delta2{i}=strcat(' $\delta_{2}$=', num2str(del2));
      R0_val=(c1.*c2./d).*((a.^(2).* Nh1./(mu1+d1))+(Nh2./(del2+d2)));
      semilogx(a,R0_val,'LineWidth',4, 'Color', cmap(i,:));
      hold on
  end




for i=1:length(deltatwo)
    del2=deltatwo(i);
    w=(mu1+d1)/(del2+d2);
    c11=bhv*v*M./(w.*Nh1+ Nh2);
    c12=bvh*v./(w.*Nh1+Nh2);
    R0c=(c11.*c12./d).*((w.^(2).* Nh1./(mu1+d1))+(Nh2./(del2+d2)));
    semilogx(w,R0c,'-o',Color='k',MarkerFaceColor='k',MarkerSize=3.5)
    a11=num2str(R0c);
    b11=num2str(w);
    Letsgo=strcat(b11,a11)
     text(w,R0c,Letsgo,'FontSize',12,'FontWeight','bold',Interpreter='latex')
    hold on
end

 plq=strcat(delta2);
 legend(plq)
 box on
 ax=gca;
 ax.LineWidth=2;
 ax.XMinorTick="off";
 ax.TickLabelInterpreter="latex";
 ax.FontWeight="bold";
 legend(Box="off");
 legend(Interpreter="latex")
 legend(FontSize=15)
 legend(FontWeight="bold")
 xlabel ('Vector preference ($\alpha_v$)','Interpreter','latex','FontSize',15,'FontWeight','bold','FontName','Helvetica');
 ylabel ('$R_0$','Interpreter','latex','FontSize',15,'Rotation',0,'FontWeight','bold','FontName','Helvetica');
AddLetters2Plots(f1, 'HShift', -0.08, 'VShift', -0.02)
