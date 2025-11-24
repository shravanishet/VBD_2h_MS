clc; clear all;  close all;

f1=figure(1)
set(f1,'PaperUnits','centimeters','Units','centimeters','PaperPosition', [0 0 18 32],'Position',[0 0 18 32])
 
set(0, 'defaultaxesfontsize', 15);
set(0, 'defaulttextfontsize', 15);
set(0, 'defaultlinelinewidth',3);
 
gap = [0.1 0.08];  % Gap between plots (top/bottom, left/right)
marg_h = [0.12 0.05]; % Margins in height (bottom/top)
marg_w = [0.03 0.08]; % Margins in width (left/right)
[ha, pos] = tight_subplot(2, 4, gap, marg_h, marg_w);
 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%this is Nh1 vs alpha_v for different mu1
T=1000;

bhv=.5;    %%beta_hv  transmission rate
 bvh=.5;    %%beta_vh
  v=1;      %%v biting rate
  mu1=.5;    %%recovery rate in host1 (keep it high to get complex EV)
  d1=.5;     %%death rate of host1 (human)
  d2=.5;   %%death rate of host2
  d=.8;    %%death rate of vector
  del1=.5;  % rate of waning immunity for h1
  del2=.5;   %% rate of waning immunity for h2
  M=15000;
  Nh2=1000;
 b1=d1;
 b2=d2;

 mu11=[0.05,.1,.5,1];
a=0:.005:4; %%%change tick labels
 Nh1=1:10:4000; 

   xa=[0:4];
ya=[0:4000];
 [a,Nh1] = meshgrid(a,Nh1);
c1=bhv*v*M./(a.*Nh1+ Nh2);
c2=bvh*v./(a.*Nh1+Nh2);
po=length(mu11);
for i=1:po;
    axes(ha(i));
mu1=mu11(i);
w1=(Nh2./a).*(1-((2./a).*(mu1+d1)./(del2+d2)));
w=((mu1+d1)/(del2+d2))
pp=(c1.*c2./d).*((a.^(2).* Nh1./(mu1+d1))+(Nh2./(del2+d2))); 
Q=double(pp);
imagesc(xa,ya,Q);
xline(w,':',LineWidth=2)
colormap(slanCM(21,40));
set(gca,'YDir','normal')
hold on 
plot(a,w1,'.',Color='g',LineWidth=2)
title({['$\mu_1$=',num2str(mu1)]},'Interpreter','latex','FontSize',12,'Rotation',-12)
hs = get(gca, 'XLabel');
pos = get(hs, 'Position');
pos(1) = pos(1) ;
set(hs, 'Position', pos)
set(gca,'View',[4 90])
clim([0 7]); 
 box on
 ax=gca;
ax.LineWidth=2;
 ax.XMinorTick="off";
 ax.TickLabelInterpreter="latex";
end
xlabel ('$\alpha_v$','Interpreter','latex','FontSize',15);
ylabel ('$N_{h1}$','Interpreter','latex','FontSize',15,'Rotation',0);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%this is Nh2 vs alpha_v for different del2

Nh1=3000;
M=30000;
mu1=0.5;
 del22=[0.05,.1,.5,1]
a=0:.005:2; %%%change tick labels
  Nh2=1:10:4000;  %%%change tick labels
  xa=[0:2];
ya=[0:4000];
 [a,Nh2] = meshgrid(a,Nh2);

po=length(del22);
for i=1:po;
   axes(ha(i+4));
c1=bhv*v*M./(a.*Nh1+ Nh2);
c2=bvh*v./(a.*Nh1+Nh2);
del2=del22(i);
w2=(1-(2.*a.*(d2+del2)./(mu1+d1))).*a.*Nh1;
w=((mu1+d1)/(del2+d2))
pp=(c1.*c2./d).*((a.^(2).* Nh1./(mu1+d1))+(Nh2./(del2+d2))); 
Q=double(pp);
figure(1)
imagesc(xa,ya,Q);
 xline(w,':',LineWidth=2)
 colormap(slanCM(21,40));
 set(gca,'YDir','normal')
hold on 
plot(a,w2,'.',Color='g',LineWidth=2)
  title({['$\delta_2$=',num2str(del2)]},'Interpreter','latex','FontSize',12,'Rotation',-12)
 set(gca,'View',[4 90])
    clim([0 7]);
    
   box on
 ax=gca;
ax.LineWidth=2;
 ax.XMinorTick="off";
 ax.TickLabelInterpreter="latex";

 hs = get(gca, 'XLabel');
pos = get(hs, 'Position');
pos(1) = pos(1) ;
set(hs, 'Position', pos)
end

xlabel ('$\alpha_v$','Interpreter','latex','FontSize',15);
ylabel ('$N_{h2}$','Interpreter','latex','FontSize',15,'Rotation',0);
 



h = axes(f1,'visible','off'); 
c = colorbar(h,'southoutside');  % attach colorbar to h
caxis(h,[0,7]); 
ylabel(c,'$R_0$','Interpreter','latex','FontSize',15,'Rotation',0)%,'Position',[0 115])
c.TickLabelInterpreter="latex";
AddLetters2Plots(f1, {'a', 'b', 'c', 'd','e','f','g','h'})




