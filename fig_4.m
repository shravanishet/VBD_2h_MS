%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%PIP PLOT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc; clear all;  close all;

f1=figure(1)
 set(f1,'PaperUnits','centimeters','Units','centimeters','PaperPosition', [0 0 18 32],'Position',[0 0 18 32])
set(0, 'defaultaxesfontsize', 12);
set(0, 'defaulttextfontsize', 12);
set(0, 'defaultlinelinewidth',2);

gap = [0.09 0.09];  % Gap between plots (top/bottom, left/right)
marg_h = [0.05 0.05]; % Margins in height (bottom/top)
marg_w = [0.09 0.01]; % Margins in width (left/right)
[ha, pos] = tight_subplot(2, 2, gap, marg_h, marg_w);


positiveColor = [0.3 0.5 0.5]; % Light grey for positive
negativeColor = [1 1 1]; % white for negative
customColormap = [negativeColor;positiveColor];
levels = [-Inf 0 0 Inf];

global gh gc tf t2 sh egc pf mu w sr d1_e
tf=.1;
t2=2.5;
sh=1;
egc=5; %frc
pf=0.95; %p2
mu=0.5;
w=1; %1
sr=.95;
d1_e=0.00028;

  Titlew={'Relative Encounter rate $\ll 1$','Relative Encounter rate $< \approx 1$',...
  'Relative Encounter rate $\gg 1$','Relative Encounter rate  $ > \approx 1$'};
      

gh1=[2,1.05,1,1];
gc1=[1,1,1.5,5];
A1=[0.833,0.519,0.156];

for i=1:length(gh1);
      axes(ha(i));     % To 'activate' the axis. 
      gh=gh1(i);
      gc=gc1(i);
      x_range = linspace(0, 1, 500);
      y_range = linspace(0, 1, 500);
      [x, y] = meshgrid(x_range, y_range);
      z = f(x, y);
      contourf(x, y, z, levels, 'LineColor', 'none');
      colormap(customColormap);
      
       xlabel ('Resident trait value ($\sigma_{h2(r)}$)','Interpreter','latex','FontSize',12,'FontWeight','bold');
       ylabel ('Mutant trait value ($\sigma_{h2(m)}$)','Interpreter','latex','FontSize',12,'Rotation',90,'FontWeight','bold');
      

      ax=gca;
      ax.LineWidth=2;
      ax.XMinorTick="off";
      ax.TickLabelInterpreter="latex";
      ax.FontWeight="bold";

hs = get(gca, 'XLabel');
pos = get(hs, 'Position');
pos(1) = pos(1) ;
set(hs, 'Position', pos)

 title(Titlew{i}, 'Interpreter', 'latex', 'FontSize', 12);
hold on
end

AddLetters2Plots(f1, 'HShift', -0.08, 'VShift', -0.02)

 hold on
 for i=2:4
     axes(ha(i));
     A11=A1(i-1)
     plot(A11,A11,'-o','Color','k','MarkerFaceColor','k','MarkerSize',4)
     hold on
 end





function dom=f(scr, scm)
global gh gc tf t2 sh egc pf mu w sr d1_e
psi=1-exp(-(sh.*gh+scr.*gc));
phs=psi.*pf./(1-((1-psi).*pf));
Q=scr.*gc./(gh+scr.*gc);
pc=1-mu.*((1-Q).^w);
ph=1-mu.*(Q.^w);
sf=phs.*(Q.*pc+(1-Q).*ph);
pgc=sf.*sr;
t1=tf./(1-(1-psi).*pf);
f=1./(t1+t2);
eps=egc.*f;
pd=pgc.^f;
% d3=-log(pd); 
M=(eps+log(pd))./(d1_e);

%%%%%%%%%
psiM=1-exp(-(sh.*gh+scm.*gc));
phsM=psiM.*pf./(1-(1-psiM).*pf);
QM=scm*gc./(gh+scm.*gc);
pcm=1-mu.*(1-QM).^w;
phm=1-mu.*(QM).^w;

sfM=phsM.*(QM.*pcm+(1-QM).*phm);
pgcM=sfM.*sr;
t1M=tf./(1-(1-psiM).*pf);
fM=1./(t1M+t2);
epM=egc.*fM;
pdM=pgcM.^fM;
dom=(epM-d1_e.*M+log(pdM));
end

